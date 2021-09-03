local lspConfig = require("lsp_config")

require "lspconfig".gopls.setup {
  on_attach = lspConfig.on_attach,
  cmd = {"gopls", "serve"},
  gopls = {
    experimentalPostfixCompletions = true,
    codelenses = {
      generate = true,
      gc_details = true,
      test = true,
      tidy = true
    }
  },
  flags = lspConfig.flags,
}
