local U = require("spectra.util.color")
local T = require("spectra.util.theme")

local M = {}

function M.get(C, R, O)
  local transparent = O.transparent_background
  local normal_bg = transparent and C.none or C.bg
  local line_nr = C.line_nr or C.subtle
  local cursorline_nr = C.cursorline_nr or C.pink
  local match_paren_bg = C.match_paren_bg or U.blend(C.border, C.bg, 0.55)

  return {
    Normal = { fg = C.fg, bg = normal_bg },
    NormalFloat = { fg = C.fg, bg = transparent and C.none or C.bg_float },
    FloatBorder = { fg = C.border, bg = transparent and C.none or C.bg_float },
    ColorColumn = { bg = C.bg_dark },
    CursorColumn = { bg = C.bg_cursorline },
    CursorLine = { bg = C.bg_cursorline },
    CursorLineNr = { fg = cursorline_nr, bold = true },
    CursorLineFold = { fg = C.subtle },
    CursorLineSign = { fg = C.subtle },
    Directory = T.highlight(R, { "module", "type" }, { fg = C.cyan }, { bold = true }),
    EndOfBuffer = { fg = C.bg_dark },
    FoldColumn = { fg = C.subtle },
    Folded = { fg = C.subtle, bg = C.bg_dark },
    IncSearch = { fg = C.bg, bg = C.orange, bold = true },
    Search = T.highlight(R, { "ui_selection" }, { fg = C.fg, bg = U.blend(C.purple, C.bg, 0.35) }),
    CurSearch = { link = "IncSearch" },
    LineNr = { fg = line_nr },
    MatchParen = { fg = C.fg, bg = match_paren_bg, bold = true },
    NonText = { fg = C.subtle },
    Pmenu = { fg = C.fg, bg = C.bg_float },
    PmenuMatch = T.highlight(R, { "function_name", "module" }, { fg = C.cyan }, { bg = C.bg_float, bold = true }),
    PmenuMatchSel = T.highlight(R, { "function_name", "module" }, { fg = C.cyan }, { bg = C.bg_selection, bold = true }),
    PmenuSbar = { bg = C.bg_dark },
    PmenuSel = T.highlight(R, { "ui_selection" }, { fg = C.fg, bg = C.bg_selection }),
    PmenuThumb = { bg = C.purple },
    Question = T.highlight(R, { "function_name", "module" }, { fg = C.green }),
    SignColumn = { fg = C.subtle, bg = normal_bg },
    SpecialKey = { fg = C.red },
    StatusLine = { fg = C.fg, bg = C.gutter, bold = true },
    StatusLineNC = { fg = C.subtle, bg = C.bg_dark },
    TabLine = { fg = C.subtle, bg = C.bg_dark },
    TabLineFill = { fg = C.subtle, bg = C.bg_dark },
    TabLineSel = { fg = C.fg, bg = C.bg_float, bold = true },
    Title = T.highlight(R, { "module", "type" }, { fg = C.cyan }, { bold = true }),
    VertSplit = { fg = C.border },
    Visual = T.highlight(R, { "ui_selection" }, { bg = C.bg_selection }),
    VisualNOS = { link = "Visual" },
    WarningMsg = { fg = C.orange },
    WinSeparator = { fg = C.border },
    WildMenu = { fg = C.bg, bg = C.purple, bold = true },
    Whitespace = { fg = C.guide },
    WinBar = { fg = C.fg_muted, bg = transparent and C.none or C.bg },
    WinBarNC = { fg = C.subtle, bg = transparent and C.none or C.bg },
    FloatTitle = T.highlight(R, { "keyword", "tag" }, { fg = C.pink }, { bg = transparent and C.none or C.bg_float }),
    NormalNC = O.dim_inactive and { fg = C.fg_muted, bg = transparent and C.none or C.bg } or { link = "Normal" },
    Cursor = { fg = C.bg, bg = C.fg },
    CursorIM = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    TermCursor = { fg = C.bg, bg = C.fg },
    DiffAdd = { fg = C.green, bg = U.blend(C.green, C.bg, 0.18) },
    DiffChange = { fg = C.cyan, bg = U.blend(C.cyan, C.bg, 0.16) },
    DiffDelete = { fg = C.red, bg = U.blend(C.red, C.bg, 0.18) },
    DiffText = { fg = C.bg, bg = C.orange, bold = true },
    Added = { link = "DiffAdd" },
    Changed = { link = "DiffChange" },
    Removed = { link = "DiffDelete" },
  }
end

return M
