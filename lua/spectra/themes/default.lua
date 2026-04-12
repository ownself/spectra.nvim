--- Default palettes for Spectra.
--- Provides dark and light presets covering layers 0-2 (16 colors each).
--- @module spectra.themes.default

local M = {}

--- Default dark palette (inspired by VS Code Dark+ / Neovim defaults).
--- Covers layers 0-2: 2 base + 6 accent + 8 role = 16 colors.
--- @type table<string, string>
M.dark = {
  -- Layer 0: base
  fg = "#d4d4d4",
  bg = "#1e1e1e",
  -- Layer 1: accent
  ["accent.danger"]  = "#f44747",  -- red: errors, deletions
  ["accent.success"] = "#6a9955",  -- green: strings, additions
  ["accent.info"]    = "#4fc1ff",  -- cyan: identifiers, info diagnostics
  ["accent.caution"] = "#dcdcaa",  -- yellow: constants, warnings, search
  ["accent.action"]  = "#4ec9b0",  -- teal: functions, special, changes
  ["accent.control"] = "#c586c0",  -- purple: keywords, control flow
  -- Layer 2: role (domain splits)
  ["syntax.keyword"]  = "#569cd6",  -- blue: distinct from accent.control purple
  ["syntax.string"]   = "#ce9178",  -- orange: distinct from accent.success green
  ["syntax.function"] = "#dcdcaa",  -- yellow: function names
  ["syntax.comment"]  = "#6a9955",  -- green-gray: subdued
  ["syntax.type"]     = "#4ec9b0",  -- teal: types
  ["diag.error"]      = "#f44747",  -- bright red
  ["diag.warn"]       = "#cca700",  -- dark yellow
  ["diff.add"]        = "#4b5632",  -- muted green (bg use)
}

--- Default light palette.
--- Covers layers 0-2: 2 base + 6 accent + 8 role = 16 colors.
--- @type table<string, string>
M.light = {
  -- Layer 0: base
  fg = "#333333",
  bg = "#ffffff",
  -- Layer 1: accent
  ["accent.danger"]  = "#cd3131",
  ["accent.success"] = "#008000",
  ["accent.info"]    = "#0070c1",
  ["accent.caution"] = "#795e26",
  ["accent.action"]  = "#267f99",
  ["accent.control"] = "#af00db",
  -- Layer 2: role
  ["syntax.keyword"]  = "#0000ff",
  ["syntax.string"]   = "#a31515",
  ["syntax.function"] = "#795e26",
  ["syntax.comment"]  = "#008000",
  ["syntax.type"]     = "#267f99",
  ["diag.error"]      = "#cd3131",
  ["diag.warn"]       = "#bf8803",
  ["diff.add"]        = "#c8e6c9",
}

return M
