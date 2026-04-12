--- Kanagawa Wave palette for Spectra.
--- Port of spectra.nvim's kanagawa-wave theme.
--- @module spectra.themes.kanagawa_wave

local M = {}

M.dark = {
  -- Layer 0: base
  fg = "#DCD7BA",   -- fujiWhite
  bg = "#1F1F28",   -- sumiInk3

  -- Layer 1: accent
  ["accent.danger"]  = "#E46876",   -- waveRed
  ["accent.success"] = "#98BB6C",   -- springGreen
  ["accent.info"]    = "#7E9CD8",   -- crystalBlue
  ["accent.caution"] = "#C0A36E",   -- boatYellow2
  ["accent.action"]  = "#7E9CD8",   -- crystalBlue
  ["accent.control"] = "#957FB8",   -- oniViolet

  -- Layer 2: role
  ["syntax.keyword"]  = "#957FB8",  -- oniViolet
  ["syntax.string"]   = "#98BB6C",  -- springGreen
  ["syntax.function"] = "#7E9CD8",  -- crystalBlue
  ["syntax.comment"]  = "#727169",  -- fujiGray
  ["syntax.type"]     = "#7AA89F",  -- waveAqua2
  ["diag.error"]      = "#E46876",  -- waveRed
  ["diag.warn"]       = "#FFA066",  -- surimiOrange
  ["diff.add"]        = "#98BB6C",  -- springGreen

  -- Layer 3: full
  ["syntax.constant"]   = "#FFA066",  -- surimiOrange
  ["syntax.identifier"] = "#E6C384",  -- carpYellow (amber)
  ["syntax.special"]    = "#7FB4CA",  -- springBlue
  ["syntax.operator"]   = "#C0A36E",  -- boatYellow2
  ["syntax.preproc"]    = "#E46876",  -- waveRed
  ["diag.info"]         = "#7E9CD8",  -- crystalBlue
  ["diag.hint"]         = "#7AA89F",  -- waveAqua2
  ["diag.ok"]           = "#98BB6C",  -- springGreen
  ["diff.change"]       = "#7E9CD8",  -- crystalBlue
  ["diff.delete"]       = "#E46876",  -- waveRed

  -- Layer 3: UI
  ["ui.cursorline"] = "#2A2A37",   -- sumiInk4
  ["ui.float"]      = "#16161D",   -- sumiInk0
  ["ui.visual"]     = "#223249",   -- waveBlue1
  ["ui.linenr"]     = "#54546D",   -- sumiInk6

  -- Layer 4: variant
  ["syntax.variable"]             = "#DCD7BA",  -- fujiWhite (local_variable = fg)
  ["syntax.delimiter"]            = "#DCD7BA",  -- fujiWhite (fg)
  ["syntax.tag"]                  = "#E46876",  -- waveRed
  ["syntax.label"]                = "#FFA066",  -- surimiOrange (label = orange)
  ["syntax.type.constructor"]     = "#7AA89F",  -- waveAqua2
  ["syntax.type.builtin"]         = "#7AA89F",  -- waveAqua2
  ["syntax.type.module"]          = "#7AA89F",  -- waveAqua2
  ["syntax.function.builtin"]     = "#7FB4CA",  -- springBlue (cyan)
  ["syntax.identifier.builtin"]   = "#FFA066",  -- surimiOrange (builtin_variable = orange)
  ["syntax.identifier.field"]     = "#E6C384",  -- carpYellow (field = amber)
  ["syntax.identifier.member"]    = "#E6C384",  -- carpYellow (property = amber)
  ["syntax.identifier.parameter"] = "#b8b4d0",  -- oniViolet2 (fg_parameter)
  ["syntax.constant.builtin"]     = "#FFA066",  -- surimiOrange
  ["syntax.constant.character"]   = "#98BB6C",  -- springGreen (character = green)
  ["syntax.constant.macro"]       = "#E46876",  -- waveRed (macro = red)
  ["syntax.preproc.macro"]        = "#E46876",  -- waveRed (macro = red)
  ["syntax.string.escape"]        = "#E46876",  -- waveRed (escape = red)
  ["syntax.string.special"]       = "#FFA066",  -- surimiOrange
}

M.light = M.dark

return M
