local M = {}

function M.palette()
  return {
    bg = "#282A36",
    bg_dark = "#242632",
    bg_darker = "#21222C",
    bg_float = "#3A3D4C",
    bg_visual = "#494E69",
    bg_cursorline = "#1E1F29",
    bg_selection = "#494E69",
    fg = "#F8F8F2",
    fg_muted = "#B9BCD1",
    fg_parameter = "#D8A0F0",
    comment = "#98AFFF",
    subtle = "#787E9F",
    gutter = "#3F4152",
    guide = "#3E404B",
    cyan = "#8BE9FD",
    green = "#50FA7B",
    orange = "#FFB86C",
    amber = "#FFC98F",
    pink = "#FF79C6",
    purple = "#BD93F9",
    red = "#FF5555",
    yellow = "#F1FA8C",
    sky = "#98AFFF",
    teal = "#8BE9FD",
    border = "#6B7090",
    braces = "#737FFF",
    brackets = "#36FFAC",
    parens = "#FFF906",
    rainbow = {
      "#BD93F9",
      "#FF79C6",
      "#FFB86C",
      "#50FA7B",
      "#8BE9FD",
      "#737FFF",
      "#36FFAC",
    },
    none = "NONE",
    terminal = {
      "#21222C",
      "#FF5555",
      "#50FA7B",
      "#F1FA8C",
      "#BD93F9",
      "#FF79C6",
      "#8BE9FD",
      "#F8F8F2",
      "#6272A4",
      "#FF6E6E",
      "#69FF94",
      "#FFFFA5",
      "#D6ACFF",
      "#FF92DF",
      "#A4FFFF",
      "#FFFFFF",
    },
  }
end

function M.roles(C, O)
  local styles = O.styles or {}

  return {
    text = { fg = C.fg },
    identifier = { fg = C.fg_muted },
    local_variable = { fg = C.fg_muted },
    comment = { fg = C.comment, italic = vim.tbl_contains(styles.comments or {}, "italic") },
    keyword = { fg = C.pink },
    function_name = { fg = C.green },
    type = { fg = C.cyan },
    parameter = { fg = C.fg_parameter, italic = vim.tbl_contains(styles.parameters or {}, "italic") },
    field = { fg = C.orange },
    property = { fg = C.amber },
    constant = { fg = C.purple, bold = true },
    string = { fg = C.yellow },
    escape = { fg = C.orange },
    operator = { fg = C.pink },
    module = { fg = C.cyan },
    diagnostic_error = { fg = C.red },
    diagnostic_warn = { fg = C.orange },
    diagnostic_info = { fg = C.cyan },
    diagnostic_hint = { fg = C.sky },
    ui_border = { fg = C.border },
    ui_selection = { bg = C.bg_selection },
    ui_menu = { fg = C.fg, bg = C.bg_float },
  }
end

M.meta = {
  name = "dracula-colorful",
  colorscheme = "dracula-colorful",
  background = "dark",
}

M.overrides = {}

return M
