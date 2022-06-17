local USER = vim.fn.expand('$USER')
local lspConfig = require('lsp_config')

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/home/'..USER..'/.config/nvim/language_servers/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/Linux/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = lspConfig.on_attach,
  flags = lspConfig.flags,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          '?.lua',
          '?/init.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.4/?.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.4/?/init.lua',
          '/usr/local/share/lua/5.4/?.lua',
          '/usr/local/share/lua/5.4/?/init.lua'
        }
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        checkThirdParty = false,
          library = {
            [vim.fn.expand('$VIMRUNTIME')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            [vim.fn.expand('~/.luarocks/share/lua/5.4')] = true,
            [vim.fn.expand('/usr/local/share/lua/5.4/?.lua')] = true
          },
          preloadFileSize = 1000,
          maxPreload = 2000
      },
      telemetry = {
        enable = false,
      },
    },
  }
}
