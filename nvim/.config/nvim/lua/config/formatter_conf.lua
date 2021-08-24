local eslintD = {
  function()
    return {
      exe = "eslint_d",
      args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
      stdin = true
    }
  end
}

require('formatter').setup({
  logging = false,
  filetype = {
    javascript =  eslintD,
    typescript = eslintD
    --lua = {
    --    -- luafmt
    --    function()
    --      return {
    --        exe = "luafmt",
    --        args = {"--indent-count", 2, "--stdin"},
    --        stdin = true
    --      }
    --    end
    --}
  }
})

vim.api.nvim_set_keymap('n', '<leader>f', '<CMD>lua vim.lsp.buf.formatting()<CR>', { noremap=true, silent=true })
