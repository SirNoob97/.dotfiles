vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
return packer.startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "gruvbox-community/gruvbox"
    use "kyazdani42/nvim-tree.lua"
    use "nvim-lualine/lualine.nvim"

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use "rafamadriz/friendly-snippets"

    use "neovim/nvim-lspconfig"
    use "mhartington/formatter.nvim"
    use "mfussenegger/nvim-jdtls"
    use 'mfussenegger/nvim-dap'
  end
)
