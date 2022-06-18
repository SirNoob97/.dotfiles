local lspConfig = require("lsp_config")
local jdtls = require('jdtls')

local function jdtlsOnAttach(client, bufnr)
  lspConfig.on_attach(client, bufnr) 

  jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()

  local opts = { silent = true, buffer = bufnr }
  local keymap = vim.keymap
  keymap.set('n', '<leader>o', jdtls.organize_imports, opts)
  keymap.set('n', '<leader>tf', jdtls.test_class, opts)
  keymap.set('n', '<leader>tm', jdtls.test_nearest_method, opts)
  keymap.set('n', '<leader>ev', jdtls.extract_variable, opts)
  keymap.set('v', '<leader>em', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
  keymap.set('n', '<leader>ec', jdtls.extract_constant, opts)
end


local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')
local workspace = home .. '/.cache/eclipse/jdtls/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
local jars_paths = {
  '/java_nvim_extension/java-debug-0.36.0/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
}
local bundles = {}
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
	  '-Dosgi.bundles.defaultStartLevel=4',
	  '-Declipse.product=org.eclipse.jdt.ls.core.product',
	  '-Dlog.level=ALL',
	  '-noverify',
	  '-Xmx1G',
	  '--add-modules=ALL-SYSTEM',
	  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
	  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
	  '-jar', vim.fn.glob(home .. '/java_nvim_extension/eclipse_jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
	  '-configuration', home .. '/java_nvim_extension/eclipse_jdtls/config_linux',
	  '-data', workspace
  },
  settings = {
    java = {
      completion = {
        favoriteStaticMember = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*'
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*'
        }
      }
    }
  },
  init_options = {
    bundles = ''
  },
  on_attach = jdtlsOnAttach
}

jdtls.start_or_attach(config)
