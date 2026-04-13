--- EditorBasic highlight group definitions (L0-L1 + L6 diff groups).
--- Source: hg-mapping.csv rows where source=EditorBasic (53 groups).
--- @module spectra.groups.editor

local M = {}

--- Generate EditorBasic highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  local colors = require("spectra.colors")

  local transparent = config.transparent == true
  local bg = not transparent and p.bg or nil
  local search_bg = p["ui.search.bg"]
  local search_fg = colors.is_dark(search_bg) and p.fg or p.bg

  return {
    -- L0: Root
    Normal = { fg = p.fg, bg = bg },

    -- L1: UI - Cursor/Selection
    CursorLine   = { bg = not transparent and p["ui.cursorline"] or nil },
    CursorColumn = { bg = not transparent and p["ui.cursorline"] or nil },
    ColorColumn  = { bg = not transparent and p["ui.cursorline"] or nil },
    Visual       = { bg = p["ui.visual"] },
    VisualNOS    = { link = "Visual" },

    -- L1: UI - Search
    Search     = { fg = search_fg, bg = search_bg },
    IncSearch  = { link = "Search" },
    CurSearch  = { link = "Search" },
    Substitute = { link = "Search" },

    -- L1: UI - Popup menu
    Pmenu         = { bg = p["ui.pmenu"] },
    PmenuSel      = { bg = p["ui.pmenu"], reverse = true },
    PmenuMatch    = { link = "Pmenu", bold = true },
    PmenuMatchSel = { link = "PmenuSel", bold = true },
    PmenuSbar     = { bg = p["ui.pmenu.subtle"] },
    PmenuThumb    = { bg = p["ui.pmenu.subtle"] },
    PmenuKind     = { link = "Pmenu" },
    PmenuKindSel  = { link = "PmenuSel" },
    PmenuExtra    = { link = "Pmenu" },
    PmenuExtraSel = { link = "PmenuSel" },

    -- L1: UI - Float
    NormalFloat = { bg = p["ui.float"] },
    FloatBorder = { link = "NormalFloat" },
    FloatTitle  = { link = "Title" },
    FloatFooter = { link = "NormalFloat" },

    -- L1: UI - Status/Tab line
    StatusLine   = { fg = p.fg, bg = not transparent and p["ui.statusline"] or nil },
    StatusLineNC = { fg = p["ui.linenr"], bg = not transparent and p["ui.statusline"] or nil },
    TabLine      = { link = "StatusLineNC" },
    TabLineSel   = { bg = p["ui.statusline"], bold = true },
    TabLineFill  = { link = "TabLine" },
    WinBar       = { link = "StatusLine" },
    WinBarNC     = { link = "StatusLineNC" },

    -- L1: UI - Sign/Line number
    SignColumn   = { fg = p["ui.linenr"], bg = bg },
    FoldColumn   = { link = "SignColumn" },
    LineNr       = { fg = p["ui.linenr"] },
    LineNrAbove  = { link = "LineNr" },
    LineNrBelow  = { link = "LineNr" },
    CursorLineNr = { fg = p["ui.linenr"], bold = true },

    -- L1: UI - Non-text
    NonText     = { fg = p["ui.linenr"] },
    EndOfBuffer = { link = "NonText" },
    Whitespace  = { link = "NonText" },
    Conceal     = { fg = p["ui.linenr"] },

    -- L1: UI - Messages
    Title      = { fg = p.fg, bold = true },
    Directory  = { fg = p["syntax.function"] },
    MoreMsg    = { fg = p["syntax.function"] },
    Question   = { fg = p["syntax.function"] },
    ErrorMsg   = { fg = p["diag.error"] },
    WarningMsg = { fg = p["diag.warn"] },
    ModeMsg    = { fg = p["diff.add"] },
    OkMsg      = { fg = p["diag.ok"] },

    -- L1: UI - Separators
    WinSeparator = { link = "Normal" },
    VertSplit    = { link = "WinSeparator" },

    -- L1: UI - Misc
    Folded    = { fg = p["ui.linenr"], bg = not transparent and p["ui.float"] or nil },
    Cursor    = { fg = p.bg, bg = p.fg },
    TermCursor = { reverse = true },
    MatchParen = { bg = p["ui.cursorline"], bold = true, underline = true },
    SpecialKey = { link = "Special" },
    SearchSpecialSearchType = { link = "MoreMsg" },
    StderrMsg  = { link = "ErrorMsg" },

    -- L6: Diff (part of EditorBasic source)
    DiffAdd     = { fg = p.fg, bg = p["diff.add.bg"] },
    DiffChange  = { fg = p.fg, bg = p["diff.change.bg"] },
    DiffDelete  = { fg = p["diff.delete"], bold = true },
    DiffText    = { fg = p.fg, bg = colors.blend(p.bg, p["diff.change"], 0.25) },
    DiffTextAdd = { link = "DiffText" },
    Added       = { fg = p["diff.add"] },
    Changed     = { fg = p["diff.change"] },
    Removed     = { fg = p["diff.delete"] },
  }
end

return M
