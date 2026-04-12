--- Tokyonight Storm palette for Spectra.
--- Port of spectra.nvim's tokyonight-storm theme.
--- @module spectra.themes.tokyonight_storm

local M = {}

M.dark = {
  -- Layer 0: base
  fg = "#c0caf5",
  bg = "#24283b",

  -- Layer 1: accent
  ["accent.danger"]  = "#f7768e",   -- red/pink
  ["accent.success"] = "#9ece6a",   -- green
  ["accent.info"]    = "#7aa2f7",   -- blue
  ["accent.caution"] = "#e0af68",   -- yellow/amber
  ["accent.action"]  = "#7aa2f7",   -- blue
  ["accent.control"] = "#bb9af7",   -- purple

  -- Layer 2: role
  ["syntax.keyword"]  = "#bb9af7",  -- purple
  ["syntax.string"]   = "#9ece6a",  -- green
  ["syntax.function"] = "#7aa2f7",  -- blue
  ["syntax.comment"]  = "#565f89",  -- comment
  ["syntax.type"]     = "#73daca",  -- teal
  ["diag.error"]      = "#f7768e",  -- red
  ["diag.warn"]       = "#e0af68",  -- yellow
  ["diff.add"]        = "#9ece6a",  -- green

  -- Layer 3: full
  ["syntax.constant"]   = "#ff9e64",  -- orange
  ["syntax.identifier"] = "#9aa5ce",  -- fg_muted
  ["syntax.special"]    = "#7dcfff",  -- cyan
  ["syntax.operator"]   = "#7dcfff",  -- cyan
  ["syntax.preproc"]    = "#bb9af7",  -- purple
  ["diag.info"]         = "#7aa2f7",  -- blue
  ["diag.hint"]         = "#73daca",  -- teal
  ["diag.ok"]           = "#9ece6a",  -- green
  ["diff.change"]       = "#7aa2f7",  -- blue
  ["diff.delete"]       = "#f7768e",  -- red

  -- Layer 3: UI
  ["ui.cursorline"] = "#292e42",
  ["ui.float"]      = "#1f2335",
  ["ui.visual"]     = "#2e334d",
  ["ui.linenr"]     = "#3b4261",   -- guide

  -- Layer 4: variant
  ["syntax.variable"]             = "#c0caf5",  -- fg (local_variable = fg)
  ["syntax.delimiter"]            = "#c0caf5",  -- fg
  ["syntax.tag"]                  = "#f7768e",  -- red
  ["syntax.label"]                = "#ff9e64",  -- orange
  ["syntax.type.constructor"]     = "#73daca",  -- teal
  ["syntax.type.builtin"]         = "#73daca",  -- teal
  ["syntax.type.module"]          = "#73daca",  -- teal
  ["syntax.function.builtin"]     = "#7dcfff",  -- cyan
  ["syntax.identifier.builtin"]   = "#f7768e",  -- red
  ["syntax.identifier.field"]     = "#73daca",  -- teal (field)
  ["syntax.identifier.member"]    = "#73daca",  -- teal (property)
  ["syntax.identifier.parameter"] = "#e0af68",  -- yellow (parameter)
  ["syntax.constant.builtin"]     = "#ff9e64",  -- orange
  ["syntax.constant.character"]   = "#9ece6a",  -- green (character = green)
  ["syntax.constant.macro"]       = "#f7768e",  -- red (macro = red)
  ["syntax.preproc.macro"]        = "#f7768e",  -- red (macro = red)
  ["syntax.string.escape"]        = "#f7768e",  -- red (escape = red)
  ["syntax.string.special"]       = "#ff9e64",  -- orange
}

M.light = M.dark

return M
