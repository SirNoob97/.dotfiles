-- vim.lsp.set_log_level("debug")

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false

  local opts = {noremap = true, silent = true}
  local keymap = vim.keymap
  
  keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  keymap.set('n', '[[', vim.diagnostic.goto_prev, opts)
  keymap.set('n', ']]', vim.diagnostic.goto_next, opts)
  keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  local bufopts = {noremap = true, silent = true, buffer = bufnr}
  keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)


  keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

local flags = {
  debounce_text_changes = 500
}

return {on_attach = on_attach, flags = flags}
