--- Dracula Colorful palette for Spectra.
--- Port of spectra.nvim's dracula-colorful theme.
--- @module spectra.themes.dracula_colorful

local M = {}

M.dark = {
  -- Layer 0: base
  fg = "#F8F8F2",
  bg = "#282A36",

  -- Layer 1: accent
  ["accent.danger"]  = "#FF5555",
  ["accent.success"] = "#50FA7B",
  ["accent.info"]    = "#8BE9FD",
  ["accent.caution"] = "#F1FA8C",
  ["accent.action"]  = "#50FA7B",
  ["accent.control"] = "#FF79C6",

  -- Layer 2: role
  ["syntax.keyword"]  = "#FF79C6",
  ["syntax.string"]   = "#F1FA8C",
  ["syntax.function"] = "#50FA7B",
  ["syntax.comment"]  = "#98AFFF",
  ["syntax.type"]     = "#8BE9FD",
  ["diag.error"]      = "#FF5555",
  ["diag.warn"]       = "#FFB86C",
  ["diff.add"]        = "#50FA7B",

  -- Layer 3: full
  ["syntax.constant"]   = "#BD93F9",
  ["syntax.identifier"] = "#B9BCD1",
  ["syntax.special"]    = "#FFB86C",
  ["syntax.operator"]   = "#FF79C6",
  ["syntax.preproc"]    = "#FF79C6",
  ["diag.info"]         = "#8BE9FD",
  ["diag.hint"]         = "#98AFFF",
  ["diag.ok"]           = "#50FA7B",
  ["diff.change"]       = "#8BE9FD",
  ["diff.delete"]       = "#FF5555",

  -- Layer 3: UI
  ["ui.cursorline"] = "#1E1F29",
  ["ui.float"]      = "#3A3D4C",
  ["ui.visual"]     = "#494E69",
  ["ui.linenr"]     = "#3F4152",

  -- Layer 4: variant
  ["syntax.variable"]             = "#B9BCD1",
  ["syntax.delimiter"]            = "#F8F8F2",
  ["syntax.tag"]                  = "#FF79C6",
  ["syntax.label"]                = "#787E9F",
  ["syntax.type.constructor"]     = "#8BE9FD",
  ["syntax.type.builtin"]         = "#8BE9FD",
  ["syntax.type.module"]          = "#8BE9FD",
  ["syntax.function.builtin"]     = "#8BE9FD",
  ["syntax.identifier.builtin"]   = "#BD93F9",
  ["syntax.identifier.field"]     = "#FFB86C",
  ["syntax.identifier.member"]    = "#FFC98F",
  ["syntax.identifier.parameter"] = "#D8A0F0",
  ["syntax.constant.builtin"]     = "#BD93F9",
  ["syntax.constant.character"]   = "#F1FA8C",
  ["syntax.constant.macro"]       = "#BD93F9",
  ["syntax.preproc.macro"]        = "#BD93F9",
  ["syntax.string.escape"]        = "#FFB86C",
  ["syntax.string.special"]       = "#FFB86C",
}

M.light = M.dark

return M
