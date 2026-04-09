local M = {}

local palettes = {
  mocha = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
    background = "dark",
  },
  macchiato = {
    rosewater = "#f4dbd6",
    flamingo = "#f0c6c6",
    pink = "#f5bde6",
    mauve = "#c6a0f6",
    red = "#ed8796",
    maroon = "#ee99a0",
    peach = "#f5a97f",
    yellow = "#eed49f",
    green = "#a6da95",
    teal = "#8bd5ca",
    sky = "#91d7e3",
    sapphire = "#7dc4e4",
    blue = "#8aadf4",
    lavender = "#b7bdf8",
    text = "#cad3f5",
    subtext1 = "#b8c0e0",
    subtext0 = "#a5adcb",
    overlay2 = "#939ab7",
    overlay1 = "#8087a2",
    overlay0 = "#6e738d",
    surface2 = "#5b6078",
    surface1 = "#494d64",
    surface0 = "#363a4f",
    base = "#24273a",
    mantle = "#1e2030",
    crust = "#181926",
    background = "dark",
  },
  frappe = {
    rosewater = "#f2d5cf",
    flamingo = "#eebebe",
    pink = "#f4b8e4",
    mauve = "#ca9ee6",
    red = "#e78284",
    maroon = "#ea999c",
    peach = "#ef9f76",
    yellow = "#e5c890",
    green = "#a6d189",
    teal = "#81c8be",
    sky = "#99d1db",
    sapphire = "#85c1dc",
    blue = "#8caaee",
    lavender = "#babbf1",
    text = "#c6d0f5",
    subtext1 = "#b5bfe2",
    subtext0 = "#a5adce",
    overlay2 = "#949cbb",
    overlay1 = "#838ba7",
    overlay0 = "#737994",
    surface2 = "#626880",
    surface1 = "#51576d",
    surface0 = "#414559",
    base = "#303446",
    mantle = "#292c3c",
    crust = "#232634",
    background = "dark",
  },
  latte = {
    rosewater = "#dc8a78",
    flamingo = "#dd7878",
    pink = "#ea76cb",
    mauve = "#8839ef",
    red = "#d20f39",
    maroon = "#e64553",
    peach = "#fe640b",
    yellow = "#df8e1d",
    green = "#40a02b",
    teal = "#179299",
    sky = "#04a5e5",
    sapphire = "#209fb5",
    blue = "#1e66f5",
    lavender = "#7287fd",
    text = "#4c4f69",
    subtext1 = "#5c5f77",
    subtext0 = "#6c6f85",
    overlay2 = "#7c7f93",
    overlay1 = "#8c8fa1",
    overlay0 = "#9ca0b0",
    surface2 = "#acb0be",
    surface1 = "#bcc0cc",
    surface0 = "#ccd0da",
    base = "#eff1f5",
    mantle = "#e6e9ef",
    crust = "#dce0e8",
    background = "light",
  },
}

local function enrich_palette(C)
  local palette = vim.deepcopy(C)

  palette.bg = C.base
  palette.bg_dark = C.mantle
  palette.bg_darker = C.crust
  palette.bg_float = C.mantle
  palette.bg_visual = C.surface0
  palette.bg_cursorline = C.surface0
  palette.bg_selection = C.surface1
  palette.fg = C.text
  palette.fg_muted = C.subtext1
  palette.fg_parameter = C.maroon
  palette.comment = C.overlay1
  palette.subtle = C.overlay1
  palette.gutter = C.mantle
  palette.guide = C.surface0
  palette.border = C.surface2
  palette.none = "NONE"

  palette.line_nr = C.surface1
  palette.cursorline_nr = C.lavender
  palette.match_paren_bg = C.surface1

  -- Stable slots used by the current shared runtime.
  palette.cyan = C.blue
  palette.green = C.green
  palette.orange = C.peach
  palette.amber = C.lavender
  palette.pink = C.mauve
  palette.purple = C.peach
  palette.red = C.red
  palette.yellow = C.yellow
  palette.sky = C.sky
  palette.teal = C.teal

  palette.braces = C.blue
  palette.brackets = C.teal
  palette.parens = C.yellow
  palette.rainbow = {
    C.red,
    C.peach,
    C.yellow,
    C.green,
    C.sapphire,
    C.lavender,
  }

  palette.terminal = {
    C.crust,
    C.red,
    C.green,
    C.yellow,
    C.blue,
    C.pink,
    C.teal,
    C.text,
    C.surface2,
    C.maroon,
    C.green,
    C.yellow,
    C.sapphire,
    C.pink,
    C.sky,
    C.rosewater,
  }

  return palette
end

local function roles(C, O)
  local styles = O.styles or {}

  return {
    text = { fg = C.text },
    identifier = { fg = C.flamingo },
    local_variable = { fg = C.text },
    comment = { fg = C.overlay1, italic = vim.tbl_contains(styles.comments or {}, "italic") },
    keyword = { fg = C.mauve },
    function_name = { fg = C.blue },
    type = { fg = C.yellow },
    parameter = { fg = C.maroon, italic = vim.tbl_contains(styles.parameters or {}, "italic") },
    field = { fg = C.lavender },
    property = { fg = C.lavender },
    constant = { fg = C.peach },
    string = { fg = C.green },
    escape = { fg = C.pink },
    operator = { fg = C.sky },
    module = { fg = C.yellow },
    diagnostic_error = { fg = C.red },
    diagnostic_warn = { fg = C.yellow },
    diagnostic_info = { fg = C.sky },
    diagnostic_hint = { fg = C.teal },
    ui_border = { fg = C.surface2 },
    ui_selection = { bg = C.surface1 },
    ui_menu = { fg = C.text, bg = C.mantle },
  }
end

local function editor_overrides(C)
  return {
    Directory = { fg = C.blue, bold = true },
    FloatTitle = { fg = C.subtext0, bg = C.mantle },
    LineNr = { fg = C.surface1 },
    CursorLineNr = { fg = C.lavender, bold = true },
    MatchParen = { fg = C.peach, bg = C.surface1, bold = true },
    Question = { fg = C.blue },
    Title = { fg = C.blue, bold = true },
    EndOfBuffer = { fg = C.surface1 },
    WildMenu = { fg = C.base, bg = C.overlay0, bold = true },
  }
end

local function syntax_overrides(C)
  return {
    Character = { fg = C.teal },
    Constant = { fg = C.peach },
    Number = { fg = C.peach },
    Boolean = { fg = C.peach },
    Float = { fg = C.peach },
    StorageClass = { fg = C.yellow },
    Structure = { fg = C.yellow },
    Special = { fg = C.pink },
    SpecialChar = { fg = C.pink },
    Tag = { fg = C.lavender, bold = true },
    Conceal = { fg = C.overlay1 },
    MoreMsg = { fg = C.blue },
    ModeMsg = { fg = C.text },
    Todo = { fg = C.base, bg = C.flamingo, bold = true },
  }
end

local function treesitter_overrides(C)
  return {
    ["@variable"] = { fg = C.text },
    ["@variable.builtin"] = { fg = C.red },
    ["@variable.parameter"] = { fg = C.maroon },
    ["@variable.member"] = { fg = C.lavender },
    ["@constant"] = { fg = C.peach },
    ["@constant.builtin"] = { fg = C.peach },
    ["@constant.macro"] = { fg = C.mauve },
    ["@module"] = { fg = C.yellow, italic = true },
    ["@string.documentation"] = { fg = C.teal },
    ["@string.escape"] = { fg = C.pink },
    ["@string.special.symbol"] = { fg = C.flamingo },
    ["@type.builtin"] = { fg = C.mauve },
    ["@attribute"] = { fg = C.peach },
    ["@property"] = { fg = C.lavender },
    ["@function.builtin"] = { fg = C.peach },
    ["@function.macro"] = { fg = C.pink },
    ["@constructor"] = { fg = C.yellow },
    ["@keyword.import"] = { fg = C.mauve },
    ["@punctuation.bracket"] = { fg = C.overlay2 },
    ["@markup.link"] = { fg = C.lavender, underline = true },
    ["@markup.link.label"] = { fg = C.lavender },
    ["@markup.link.url"] = { fg = C.blue, underline = true, italic = true },
    ["@markup.quote"] = { fg = C.pink },
    ["@tag"] = { fg = C.blue },
    ["@tag.builtin"] = { fg = C.blue },
    ["@tag.attribute"] = { fg = C.yellow, italic = true },
    ["@tag.delimiter"] = { fg = C.teal },
    ["@comment.todo"] = { fg = C.base, bg = C.flamingo, bold = true },
    ["@comment.note"] = { fg = C.base, bg = C.rosewater, bold = true },
    ["@comment.warning"] = { fg = C.base, bg = C.yellow, bold = true },
    ["@comment.error"] = { fg = C.base, bg = C.red, bold = true },
    ["@markup.heading.1.markdown"] = { fg = C.red, bold = true },
    ["@markup.heading.2.markdown"] = { fg = C.peach, bold = true },
    ["@markup.heading.3.markdown"] = { fg = C.yellow, bold = true },
    ["@markup.heading.4.markdown"] = { fg = C.green, bold = true },
    ["@markup.heading.5.markdown"] = { fg = C.sapphire, bold = true },
    ["@markup.heading.6.markdown"] = { fg = C.lavender, bold = true },
    ["@property.css"] = { fg = C.blue },
    ["@property.scss"] = { fg = C.blue },
    ["@property.id.css"] = { fg = C.yellow },
    ["@property.class.css"] = { fg = C.yellow },
    ["@type.css"] = { fg = C.lavender },
    ["@type.tag.css"] = { fg = C.blue },
    ["@number.css"] = { fg = C.peach },
    ["@string.special.url.html"] = { fg = C.green, underline = true },
    ["@markup.link.label.html"] = { fg = C.text },
    ["@character.special.html"] = { fg = C.red },
    ["@attribute.c_sharp"] = { fg = C.yellow },
  }
end

local function semantic_token_overrides(C)
  return {
    ["@lsp.type.enumMember"] = { fg = C.teal },
    ["@lsp.type.parameter"] = { fg = C.maroon },
    ["@lsp.type.property"] = { fg = C.lavender },
    ["@lsp.type.variable.readonly"] = { fg = C.peach, bold = true },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
    ["@lsp.typemod.property.defaultLibrary"] = { fg = C.lavender },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = C.peach },
    ["@lsp.typemod.variable.globalScope"] = { fg = C.peach, bold = true },
    ["@lsp.typemod.variable.readonly"] = { fg = C.peach, bold = true },
    ["@lsp.typemod.variable.static"] = { fg = C.peach, bold = true },
  }
end

local function shared_overrides(C)
  return {
    editor = function()
      return editor_overrides(C)
    end,
    syntax = function()
      return syntax_overrides(C)
    end,
    treesitter = function()
      return treesitter_overrides(C)
    end,
    semantic_tokens = function()
      return semantic_token_overrides(C)
    end,
  }
end

function M.make(flavour)
  local raw = palettes[flavour]
  if not raw then
    error("spectra.nvim: unknown Catppuccin flavour '" .. tostring(flavour) .. "'")
  end

  local colorscheme = "catppuccin-" .. flavour

  return {
    meta = {
      name = colorscheme,
      colorscheme = colorscheme,
      background = raw.background,
      family = "catppuccin",
      flavour = flavour,
    },
    palette = function()
      return enrich_palette(raw)
    end,
    roles = roles,
    overrides = shared_overrides(raw),
  }
end

return M
