return {
  "nvimtools/none-ls.nvim",
  config = function()
    local none_ls = require("null-ls")
    none_ls.setup({
      none_ls.builtins.formatting.stylua,
      none_ls.builtins.formatting.prettier,
    })
  end
}
