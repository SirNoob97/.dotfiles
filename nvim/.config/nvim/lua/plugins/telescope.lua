return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          }
        }
      })
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
      vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
    end
  }
}
