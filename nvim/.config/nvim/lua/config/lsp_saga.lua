local saga = require('lspsaga')

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

local function mappings(bufnr)
  local opts = { noremap=true, silent=true }
  local function keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  keymap('n', 'K', '<CMD>Lspsaga hover_doc<CR>', opts)
  keymap('n', '<C-k>', '<CMD>Lspsaga signature_help<CR>', opts)

  keymap('n', '<leader>e', '<CMD>Lspsaga show_line_diagnostics<CR>', opts)
  keymap('n', ']]', '<CMD>Lspsaga diagnostic_jump_next<CR>', opts)
  keymap('n', '[[', '<CMD>Lspsaga diagnostic_jump_next<CR>', opts)

  keymap('n', 'ca', '<CMD>Lspsaga code_action<CR>', opts)
  keymap('v', 'ca', '<C-U>Lspsaga range_code_action<CR>', opts)

  keymap('n', '<leader>rn', '<CMD>Lspsaga rename<CR>', opts)
end

return { mappings = mappings }
