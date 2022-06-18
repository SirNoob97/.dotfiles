local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {
  disable_netrw = false,
  hijack_netrw = false,
  diagnostics = {
    enable = true
  },
  filters = {
    custom = { '.git', '.mvn', 'node_modules', '.cache' }
  },
  renderer = {
    add_trailing = true,
    icons = {
      symlink_arrow = ' >> ',
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false
      }
    }
  },
  view = {
    mappings = {
      list = {
        { key = '?', cb = tree_cb('toggle_help') },
      },
    },
  }
}

vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
