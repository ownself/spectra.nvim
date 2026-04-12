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
    -- 通用正文与默认文本内容。
    text = { fg = C.fg },
    -- 一般标识符，通常用于未进一步细分的名字。
    identifier = { fg = C.fg_muted },
    -- 局部变量。
    local_variable = { fg = C.fg_muted },
    -- 内建变量、语言预定义变量。
    builtin_variable = { fg = C.purple },
    -- 注释文本。
    comment = { fg = C.comment, italic = vim.tbl_contains(styles.comments or {}, "italic") },
    -- 关键字，如 if、for、return、class。
    keyword = { fg = C.pink },
    -- 预处理或编译指令。
    preproc = { fg = C.pink },
    -- 函数名、可调用实体名称。
    function_name = { fg = C.green },
    -- 内建函数、标准库函数。
    function_builtin = { fg = C.cyan },
    -- 类型名。
    type = { fg = C.cyan },
    -- 内建类型，如 string、number、boolean。
    builtin_type = { fg = C.cyan },
    -- 泛型参数、模板类型参数。
    type_parameter = { fg = C.purple },
    -- 构造器。
    constructor = { fg = C.cyan },
    -- 参数、形参。
    parameter = { fg = C.fg_parameter, italic = vim.tbl_contains(styles.parameters or {}, "italic") },
    -- 标签、跳转标记。
    label = { fg = C.subtle },
    -- 字段，通常偏向结构体/对象成员字段。
    field = { fg = C.orange },
    -- 属性，通常偏向面向对象属性或键值属性。
    property = { fg = C.amber },
    -- 常量。
    constant = { fg = C.purple, bold = true },
    -- 宏。
    macro = { fg = C.purple },
    -- 字符串。
    string = { fg = C.yellow },
    -- 字符字面量。
    character = { fg = C.yellow },
    -- 数字字面量。
    number = { fg = C.purple },
    -- 转义序列。
    escape = { fg = C.orange },
    -- 正则表达式内容。
    regexp = { fg = C.pink },
    -- 特殊语义项，兜底给特殊字符或特殊语法片段。
    special = { fg = C.orange },
    -- 标签名，例如 HTML/XML tag。
    tag = { fg = C.pink },
    -- 特性、注解、attribute。
    attribute = { fg = C.green },
    -- 运算符。
    operator = { fg = C.pink },
    -- 模块、命名空间、包名。
    module = { fg = C.cyan },
    -- URI、链接地址。
    uri = { fg = C.cyan, underline = true },
    -- TODO/FIXME 等待办提示。
    todo = { fg = C.bg, bg = C.pink, bold = true },
    -- 诊断错误。
    diagnostic_error = { fg = C.red },
    -- 诊断警告。
    diagnostic_warn = { fg = C.orange },
    -- 诊断信息。
    diagnostic_info = { fg = C.cyan },
    -- 诊断提示。
    diagnostic_hint = { fg = C.sky },
    -- UI 边框语义色。
    ui_border = { fg = C.border },
    -- UI 选区语义色。
    ui_selection = { bg = C.bg_selection },
    -- UI 菜单语义色。
    ui_menu = { fg = C.fg, bg = C.bg_float },
  }
end

M.meta = {
  name = "dracula-colorful",
  colorscheme = "dracula-colorful",
  background = "dark",
}

M.overrides = {
  modules = {},
  integrations = {},
  languages = {},
}

return M
