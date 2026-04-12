--- Catppuccin Macchiato palette for Spectra.
--- Port of the Catppuccin macchiato flavour.
--- @module spectra.themes.catppuccin_macchiato

local M = {}

M.dark = {
  -- Layer 0: base
  fg = "#cad3f5",   -- text
  bg = "#24273a",   -- base

  -- Layer 1: accent
  ["accent.danger"]  = "#ed8796",   -- red
  ["accent.success"] = "#a6da95",   -- green
  ["accent.info"]    = "#91d7e3",   -- sky
  ["accent.caution"] = "#eed49f",   -- yellow
  ["accent.action"]  = "#8aadf4",   -- blue
  ["accent.control"] = "#c6a0f6",   -- mauve

  -- Layer 2: role
  ["syntax.keyword"]  = "#c6a0f6",  -- mauve
  ["syntax.string"]   = "#a6da95",  -- green
  ["syntax.function"] = "#8aadf4",  -- blue
  ["syntax.comment"]  = "#8087a2",  -- overlay1
  ["syntax.type"]     = "#eed49f",  -- yellow
  ["diag.error"]      = "#ed8796",  -- red
  ["diag.warn"]       = "#eed49f",  -- yellow
  ["diff.add"]        = "#a6da95",  -- green

  -- Layer 3: full
  ["syntax.constant"]   = "#f5a97f",  -- peach
  ["syntax.identifier"] = "#f0c6c6",  -- flamingo
  ["syntax.special"]    = "#f5bde6",  -- pink
  ["syntax.operator"]   = "#91d7e3",  -- sky
  ["syntax.preproc"]    = "#c6a0f6",  -- mauve
  ["diag.info"]         = "#91d7e3",  -- sky
  ["diag.hint"]         = "#8bd5ca",  -- teal
  ["diag.ok"]           = "#a6da95",  -- green
  ["diff.change"]       = "#f5a97f",  -- peach
  ["diff.delete"]       = "#ed8796",  -- red

  -- Layer 3: UI
  ["ui.cursorline"] = "#363a4f",   -- surface0
  ["ui.float"]      = "#1e2030",   -- mantle
  ["ui.visual"]     = "#494d64",   -- surface1
  ["ui.linenr"]     = "#494d64",   -- surface1

  -- Layer 4: variant
  ["syntax.variable"]             = "#cad3f5",  -- text (= fg, distinct from identifier)
  ["syntax.delimiter"]            = "#cad3f5",  -- text (= fg)
  ["syntax.tag"]                  = "#8aadf4",  -- blue
  ["syntax.label"]                = "#8087a2",  -- overlay1
  ["syntax.type.constructor"]     = "#eed49f",  -- yellow (= type)
  ["syntax.type.builtin"]         = "#c6a0f6",  -- mauve
  ["syntax.type.module"]          = "#eed49f",  -- yellow
  ["syntax.function.builtin"]     = "#f5a97f",  -- peach
  ["syntax.identifier.builtin"]   = "#ed8796",  -- red
  ["syntax.identifier.field"]     = "#b7bdf8",  -- lavender
  ["syntax.identifier.member"]    = "#b7bdf8",  -- lavender
  ["syntax.identifier.parameter"] = "#ee99a0",  -- maroon
  ["syntax.constant.builtin"]     = "#f5a97f",  -- peach
  ["syntax.constant.character"]   = "#8bd5ca",  -- teal
  ["syntax.constant.macro"]       = "#c6a0f6",  -- mauve
  ["syntax.preproc.macro"]        = "#f5bde6",  -- pink
  ["syntax.string.escape"]        = "#f5bde6",  -- pink
  ["syntax.string.special"]       = "#f0c6c6",  -- flamingo
}

M.light = M.dark

return M
