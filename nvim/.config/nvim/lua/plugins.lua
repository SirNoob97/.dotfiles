vim.cmd [[packadd packer.nvim]]

local packer = require("packer")
return packer.startup(
  function(use)
    use "wbthomason/packer.nvim"
    use "lifepillar/vim-gruvbox8"
    use "hoob3rt/lualine.nvim"
    use "akinsho/bufferline.nvim"
    use "kyazdani42/nvim-tree.lua"

    use "neovim/nvim-lspconfig"
    use "folke/lsp-colors.nvim"
    use "glepnir/lspsaga.nvim"
    use "mhartington/formatter.nvim"
    use "nvim-lua/completion-nvim"
  end
)
