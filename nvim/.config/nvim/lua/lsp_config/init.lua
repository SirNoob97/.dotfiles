-- vim.lsp.set_log_level("debug")

local function on_attach(client, bufnr)
  require "completion".on_attach(client, bufnr)

  client.resolved_capabilities.document_formatting = false

  local opts = {noremap = true, silent = true}
  local function b_keymap(mode, keys, action)
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, action, opts)
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  b_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>")
  b_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>")
  b_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>")
  b_keymap("n", "gt", "<CMD>lua vim.lsp.buf.type_definition()<CR>")
  b_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>")

  b_keymap("n", "<leader>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>")
  b_keymap(
    "n",
    "<leader>wr",
    "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>"
  )
  b_keymap(
    "n",
    "<leader>wl",
    "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
  )
  b_keymap("n", "<leader>q", "<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>")

  --  formatter.nvim does not need a language server to use this
  --  buf_set_keymap('n', '<leader>f', '<CMD>lua vim.lsp.buf.formatting()<CR>')

  b_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
  b_keymap("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")

  b_keymap(
    "n",
    "<leader>e",
    "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
  )
  b_keymap("n", "[[", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>")
  b_keymap("n", "]]", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>")

  b_keymap("n", "ca", "<CMD>lua vim.lsp.buf.code_action()<CR>")

  b_keymap("n", "<leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>")
end

local flags = {
  debounce_text_changes = 500
}

return {on_attach = on_attach, flags = flags}
