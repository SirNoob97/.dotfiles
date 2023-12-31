return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "clangd", "lua_ls", "tsserver" },
      }
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect"
        },
        mapping = cmp.mapping.preset.insert({
          --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
        })
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local on_attach = function()
        local opts = { silent = true, noremap = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
        vim.keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set("n", "<space>D", vim.diagnostic.open_float)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
        vim.keymap.set("n", "[[", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]]", vim.diagnostic.goto_next)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local opts = { capabilities = capabilities, on_attach = on_attach }
      local conf = require("lspconfig")
      conf.clangd.setup(opts)
      conf.tsserver.setup(opts)
      conf.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true
              }
            },
          },
        },
      })
    end
  }
}
