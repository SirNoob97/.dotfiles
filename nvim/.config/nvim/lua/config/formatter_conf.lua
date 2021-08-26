local google_java_fmt = {
  function()
    return {
      exe = "google-java-format",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
  end
}

local eslintD = {
  function()
    return {
      exe = "eslint_d",
      args = {"--stdin", "--stdin-filename", "%filename", "--fix-to-stdout"},
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
      javascript = eslintD,
      typescript = eslintD,
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
