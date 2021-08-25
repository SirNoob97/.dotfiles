vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0

vim.g.nvim_tree_ignore = { '.git', '.mvn', 'node_modules', '.cache' }
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_symlink_arrow = ' >> '

-- unnecessary
vim.g.nvim_tree_special_files = {}

vim.g.nvim_tree_lsp_diagnostics = 1
--vim.g.nvim_tree_git_hl = 1
--vim.g.nvim_tree_icon_padding = ' '
vim.g.nvim_tree_show_icons = {
--   git = 1,
   git = 0,
   folders = 0,
   files = 0,
   folder_arrows = 0
}

vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
      { key = '?', cb = tree_cb('toggle_help') }
}
