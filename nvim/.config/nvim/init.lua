require("disable_ntrw")
require("keymappings")
require("settings")
require("plugins")

require("config.gruvbox")
require("config.nv_tree")
require("config.lua_line")

require("config.nvim_cmp")
--require("lss.sumneko_lua")
require("lss.tsserver")
--require("lss.gopls")
--require("lss.bashls")

--vim.cmd(
--  [[
--augroup jdtls_lsp
--    autocmd!
--    autocmd FileType java lua require'lss.jdtls'.setup()
--augroup end
--]]
--)
--
require("lsp_config")
--require("config.formatter_conf")
