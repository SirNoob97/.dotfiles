local vset = vim.opt

vset.compatible = false
vset.encoding = "UTF-8"
vset.mouse = "a"
vset.lazyredraw = true

vset.wildignore:append("*/node_modules/*")

vset.clipboard:append("unnamedplus")

vset.spelllang = "en_gb"
vset.backspace = "indent,eol,start"
vset.scrolloff = 5

vset.hidden = true
vset.timeout = true
vset.timeoutlen = 1500
vset.ttimeoutlen = 150
vset.updatetime = 300

vset.splitbelow = true
vset.splitright = true

vset.history = 1000
vset.backup = false
vset.swapfile = false
vset.writebackup = false

vset.undofile = true
vset.undodir = "/home/martin/.cache/nvim_undodir"

vset.showmode = false
vset.number = true
vset.relativenumber = true
vset.signcolumn = "number"

vset.hlsearch = true
vset.smartcase = true
vset.ignorecase = true
vset.incsearch = true

vset.omnifunc = "syntaxcomplete#Complete"
vset.completeopt = "menuone,noinsert"
vset.shortmess:append({ c = true})
vset.suffixesadd = ".java,.js,.es,.json,.py"

vset.autoindent = true
vset.shiftwidth = 2
vset.cindent = true
vset.smarttab = true
vset.tabstop = 2
vset.softtabstop = 2
vset.expandtab = true
vset.wrap = false

vset.showmatch = true
vset.showcmd = true

vset.termguicolors = true
vset.background = "dark"
vim.cmd("colorscheme gruvbox")

vset.exrc = true
vset.secure = true
