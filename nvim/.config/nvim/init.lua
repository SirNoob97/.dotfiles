require("disable_ntrw")
require("keymappings")
require("settings")
require("plugins")

require("config.gruvbox")
require("config.lua_line")
require("config.buffline")
require("config.nv_tree")

require("config.nv_completion")
require("lss.sumneko_lua")
require("lss.tsserver")
require("lss.gopls")

vim.cmd(
  [[
augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'lss.jdtls'.setup()
augroup end
]]
)

require("lsp_config")
require("config.lspcolors")
require("config.formatter_conf")
