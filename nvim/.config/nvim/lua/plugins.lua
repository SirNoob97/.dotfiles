vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
  function()
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-gruvbox8'

    use 'hoob3rt/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use 'kyazdani42/nvim-tree.lua'

    use 'folke/lsp-colors.nvim'
    use 'neovim/nvim-lspconfig'
    use 'mhartington/formatter.nvim'
    use 'nvim-lua/completion-nvim'
  end
)
