if vim.g.loaded_completion then
  return
end

vim.g.completion_timer_cycle = 200
vim.g.completion_enable_auto_popup = 0
vim.g.completion_trigger_character = {'/', '@', '.', '::'}

local remap = vim.api.nvim_set_keymap

-- Use C-Space to manually triger completion
remap('i', '<C-Space>', '<Plug>(completion_trigger)', {silent = true})

-- Use <Tab> and <S-Tab> to navigate through popup menu
remap('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', {noremap = true, expr = true})
remap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<S-TAB>"', {noremap = true, expr = true})

vim.g.completion_chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet'}},
    {complete_items = {'path'}, triggered_only = '/'},
    {mode = '<c-p>'},
    {mode = '<c-n>'}
  },
  string = {
    {complete_items = {'path'}, triggered_only = '/'},
    {mode = '<c-p>'},
    {mode = '<c-n>'}
  },
  comment = {}
}
