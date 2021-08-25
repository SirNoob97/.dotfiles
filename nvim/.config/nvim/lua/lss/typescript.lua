local lspConfig = require('lsp_config')

require'lspconfig'.tsserver.setup {
  on_attach = lspConfig.on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  flags = lspConfig.flags
}
