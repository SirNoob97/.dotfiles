require('bufferline').setup {
  options = {
    numbers = 'none',
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)
        return buf.name
    end,
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 20,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count)
      return "("..count..")"
    end,
    custom_filter = nil,
    offsets = { text_align = "center" },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = false,
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id'
  }
}
