vim.cmd [[packadd packer.nvim]]
return require('packer').startup(
  function()
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'neovim/nvim-lspconfig'
  end
)
