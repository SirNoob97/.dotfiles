return {
  {
    "folke/neodev.nvim",
    opts = {},
    config = function()
      require("neodev").setup({})
    end
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup {
        settings = {
          expose_as_code_action = "all",
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = 500,
        },
      }
    end
  }
  , { "p00f/clangd_extensions.nvim" }, {}, {}
}
