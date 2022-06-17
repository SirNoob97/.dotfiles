local lspConfig = require("lsp_config")

require "lspconfig".tsserver.setup {
  on_attach = lspConfig.on_attach,
  filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
  flags = lspConfig.flags,
  init_options = {
    preferences = {
      quotePreference = "single",
      importModuleSpecifierEnding = "index"
    }
  }
}
