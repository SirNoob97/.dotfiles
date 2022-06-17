require'lualine'.setup {
  options = {
    icons_enabled = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'branch',
        icon = ''
      }
    },
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'fileformat'},
    lualine_z = {'location'}
  },
}
