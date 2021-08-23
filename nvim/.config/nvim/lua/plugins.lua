vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
  function()
    use 'wbthomason/packer.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'kyazdani42/nvim-tree.lua'
  end
)
