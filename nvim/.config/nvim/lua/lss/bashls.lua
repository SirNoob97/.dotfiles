local lspConfig = require("lsp_config")

require "lspconfig".bashls.setup {
  on_attach = lspConfig.on_attach,
  flags = lspConfig.flags
}
