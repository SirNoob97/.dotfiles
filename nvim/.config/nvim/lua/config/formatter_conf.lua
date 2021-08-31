local google_java_fmt = {
  function()
    return {
      exe = "google-java-format",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
  end
}

local prettier = {
  function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
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

vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  "<CMD>Format<CR>",
  {noremap = true, silent = true}
)
