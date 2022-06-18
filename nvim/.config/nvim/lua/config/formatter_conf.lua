local util = require("formatter.util")

local google_java_fmt = {
  function()
    return {
      exe = "google-java-format",
      args = {
        util.escape_path(util.get_current_buffer_file_path()),
      },
      stdin = true
    }
  end
}

local prettier = {
  function()
    return {
      exe = "prettier",
      args = {
        "--stdin-filepath",
        util.escape_path(util.get_current_buffer_file_path()),
        "--single-quote"
      },
      stdin = true
    }
  end
}

local luafmt = {
  function()
    return {
      exe = "luafmt",
      args = {"--indent-count", 2, "--line-width", 80, "--stdin"},
      stdin = true
    }
  end
}
require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      lua = luafmt,
      java = google_java_fmt
    }
  }
)

vim.keymap.set('n', '<leader>f', '<CMD>Format<CR>', {noremap = true, silent = true})
