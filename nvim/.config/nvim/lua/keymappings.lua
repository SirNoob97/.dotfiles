vim.g.mapleader = ' '

vim.api.nvim_set_keymap('', '`', ':setlocal spell!<CR>', { silent = true })

vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', { silent = true })

vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-d>', '"+d', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '++', ':m <-2<CR>v', { noremap = true })
vim.api.nvim_set_keymap('v', '--', ':m >-1<CR>v', { noremap = true })

vim.api.nvim_set_keymap('n', '++', ':m -2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '--', ':m +1<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR><CR>', { noremap = true, silent = true })			 

vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<leader>d', ':bdelete<CR>', { noremap = true, silent = true })			 

vim.api.nvim_set_keymap('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })			 

vim.api.nvim_set_keymap('n', '<leader><up>', ':resize +5<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<leader><down>', ':resize -5<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<leader><right>', ':vertical resize -5<CR>', { noremap = true, silent = true })			 
vim.api.nvim_set_keymap('n', '<leader><left>', ':vertical resize +5<CR>', { noremap = true, silent = true })			 
