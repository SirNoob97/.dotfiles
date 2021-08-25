vim.cmd [[packadd packer.nvim]]
local ft = {
  "lua",
  "java",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact"
}
return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "lifepillar/vim-gruvbox8"
    use  {"kyazdani42/nvim-tree.lua", opt = true, cmd = {"NvimTreeOpen", "NvimTreeToggle"}}
    use "hoob3rt/lualine.nvim"
    use {"akinsho/bufferline.nvim", opt = true, event = {"BufEnter"}}
    use "folke/lsp-colors.nvim"
    use "neovim/nvim-lspconfig"
    use "glepnir/lspsaga.nvim"
    use {"mhartington/formatter.nvim", ft = ft}
    use {"nvim-lua/completion-nvim", ft = ft}
  end
)
