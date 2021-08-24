vim.o.compatible = false
vim.o.encoding = 'UTF-8'
vim.o.mouse = 'a'

vim.o.clipboard= vim.o.clipboard..'unnamedplus'

vim.o.spelllang = 'en_gb'
vim.o.backspace = 'indent,eol,start'
vim.o.scrolloff = 5

vim.o.hidden = true
vim.o.timeout = true
vim.o.timeoutlen = 1500
vim.o.ttimeoutlen = 150
vim.o.updatetime = 300

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.history=1000
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

vim.o.undofile = true
vim.o.undodir = '/home/martin/.cache/nvim_undodir'

vim.o.showmode = false
vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

vim.o.omnifunc = 'syntaxcomplete#Complete'
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.suffixesadd = '.java'

vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.cindent = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.wrap = false

vim.o.showmatch = true
vim.o.showcmd = true

vim.o.background = 'dark'
vim.o.lazyredraw = true
vim.cmd 'colorscheme gruvbox8'
