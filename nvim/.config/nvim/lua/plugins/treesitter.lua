return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ignore_install = {},
        ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript" },
        sync_install = false,
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
        },
        modules = {}
      })
    end
  }
}
