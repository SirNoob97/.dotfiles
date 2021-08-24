vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_symlink_arrow = ' >> '

vim.g.nvim_tree_special_files = { {'README.md', 1}, {'Makefile', 1}, {'MAKEFILE', 1} }
vim.g.nvim_tree_show_icons = {
  { 'git', 0,},
  { 'folders', 0,},
  { 'files', 0,},
  { 'folder_arrows', 0,}
}

vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
      { key = '?', cb = tree_cb('toggle_help') }
    }

--set termguicolors -- this variable must be enabled for colors to be applied properly

-- a list of groups can be found at `:help nvim_tree_highlight`
--highlight NvimTreeFolderIcon guibg=blue
