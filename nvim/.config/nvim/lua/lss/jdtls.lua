local M = {}

function M.setup()
  local on_attach = function(client, bufnr)
    require "jdtls.setup".add_commands()
    require "jdtls".setup_dap()
    require "completion".on_attach(client, bufnr)

    local opts = {noremap = true, silent = true}
    local function b_keymap(mode, key, action)
      vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, opts)
    end

    -- Mappings.
    b_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    b_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    b_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    b_keymap(
      "n",
      "gr",
      '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>'
    )
    b_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

    b_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
    b_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

    b_keymap(
      "n",
      "<leader>wa",
      "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"
    )
    b_keymap(
      "n",
      "<leader>wr",
      "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"
    )
    b_keymap(
      "n",
      "<leader>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
    )
    b_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

    b_keymap(
      "n",
      "<leader>e",
      "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
    )
    b_keymap("n", "]]", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    b_keymap("n", "[[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    b_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")

    -- Java specific
    b_keymap("n", "ca", "<Cmd>lua require('jdtls').code_action()<CR>")
    b_keymap("v", "ca", "<Esc><Cmd>lua require('jdtls').code_action(true)<CR>")

    b_keymap("n", "<leader>o", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
    b_keymap("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>")
    b_keymap(
      "n",
      "<leader>tm",
      "<Cmd>lua require'jdtls'.test_nearest_method()<CR>"
    )
    b_keymap(
      "v",
      "<leader>xv",
      "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>"
    )
    b_keymap(
      "n",
      "<leader>xv",
      "<Cmd>lua require('jdtls').extract_variable()<CR>"
    )
    b_keymap(
      "v",
      "<leader>xm",
      "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>"
    )
  end

  local root_markers = {"gradlew", "pom.xml"}
  local root_dir = require("jdtls.setup").find_root(root_markers)
  local home = os.getenv("HOME")

  local capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }

  local workspace_folder =
    home ..
    "/.cache/eclipse/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = {
    flags = {
      allow_incremental_sync = true
    },
    capabilities = capabilities,
    on_attach = on_attach
  }

  config.settings = {
    java = {
      format = {enabled = false},
      signatureHelp = {enabled = true},
      contentProvider = {preferred = "fernflower"},
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk-amd64"
          }
        }
      }
    }
  }
  config.cmd = {"javalsp", workspace_folder}
  config.filetypes = {"java"}
  config.on_attach = on_attach
  config.on_init = function(client, _)
    client.notify(
      "workspace/didChangeConfiguration",
      {settings = config.settings}
    )
  end

  local extendedClientCapabilities = require "jdtls".extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  config.init_options = {
    extendedClientCapabilities = extendedClientCapabilities
  }

  -- Server
  require("jdtls").start_or_attach(config)
end

return M
