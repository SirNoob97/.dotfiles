vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
      { key = "?", cb = tree_cb('toggle_help') }
    }

--set termguicolors -- this variable must be enabled for colors to be applied properly

-- a list of groups can be found at `:help nvim_tree_highlight`
--highlight NvimTreeFolderIcon guibg=blue
