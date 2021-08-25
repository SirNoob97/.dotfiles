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
      lua = luafmt
    }
  }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  "<CMD>Format<CR>",
  {noremap = true, silent = true}
)
