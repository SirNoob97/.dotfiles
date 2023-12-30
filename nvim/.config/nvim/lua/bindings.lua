vim.g.mapleader = " "

vim.keymap.set("n", "<CR>", "<CMD>nohlsearch<CR><CR>", {silent = true, noremap = true})
vim.keymap.set("v", "<C-c>", "\"+y", {silent = true})
vim.keymap.set("v", "<C-d>", "\"+d", {silent = true})

vim.keymap.set("n", "++", "<CMD>m -2<CR>", {noremap = true})
vim.keymap.set("n", "--", "<CMD>m +1<CR>", {noremap = true})
vim.keymap.set("v", "++", "<CMD>m '<-2<CR>v", {noremap = true})
vim.keymap.set("v", "--", "<CMD>m '>+1<CR>v", {noremap = true})


vim.keymap.set("n", "<TAB>", "<CMD>bnext<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<S-TAB>", "<CMD>bprevious<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<LEADER>d", "<CMD>bdelete<CR>", {silent = true, noremap = true})

vim.keymap.set("n", "<LEADER>h", "<CMD>split<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<LEADER>v", "<CMD>vsplit<CR>", {silent = true, noremap = true})

vim.keymap.set("n", "<LEADER><UP>", "<CMD>resize +5<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<LEADER><DOWN>", "<CMD>resize -5<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<LEADER><RIGHT>", "<CMD>vertical resize -5<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<LEADER><LEFT>", "<CMD>vertical resize +5<CR>", {silent = true, noremap = true})
