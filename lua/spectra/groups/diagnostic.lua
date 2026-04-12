--- Diagnostic highlight group definitions (L5).
--- Source: hg-mapping.csv rows where source=Diagnostic (32 groups).
--- @module spectra.groups.diagnostic

local M = {}

--- Generate Diagnostic highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  return {
    -- Base diagnostic groups: direct palette mapping
    DiagnosticError = { fg = p["diag.error"] },
    DiagnosticWarn  = { fg = p["diag.warn"] },
    DiagnosticInfo  = { fg = p["diag.info"] },
    DiagnosticHint  = { fg = p["diag.hint"] },
    DiagnosticOk    = { fg = p["diag.ok"] },

    -- Underline variants: undercurl with sp color
    DiagnosticUnderlineError = { sp = p["diag.error"], underline = true },
    DiagnosticUnderlineWarn  = { sp = p["diag.warn"],  underline = true },
    DiagnosticUnderlineInfo  = { sp = p["diag.info"],  underline = true },
    DiagnosticUnderlineHint  = { sp = p["diag.hint"],  underline = true },
    DiagnosticUnderlineOk    = { sp = p["diag.ok"],    underline = true },

    -- Deprecated: strikethrough
    DiagnosticDeprecated   = { sp = p["diag.error"], strikethrough = true },

    -- Unnecessary: same as Comment (subdued)
    DiagnosticUnnecessary  = { link = "Comment" },

    -- Floating variants: link to base
    DiagnosticFloatingError = { link = "DiagnosticError" },
    DiagnosticFloatingWarn  = { link = "DiagnosticWarn" },
    DiagnosticFloatingInfo  = { link = "DiagnosticInfo" },
    DiagnosticFloatingHint  = { link = "DiagnosticHint" },
    DiagnosticFloatingOk    = { link = "DiagnosticOk" },

    -- Sign variants: link to base
    DiagnosticSignError = { link = "DiagnosticError" },
    DiagnosticSignWarn  = { link = "DiagnosticWarn" },
    DiagnosticSignInfo  = { link = "DiagnosticInfo" },
    DiagnosticSignHint  = { link = "DiagnosticHint" },
    DiagnosticSignOk    = { link = "DiagnosticOk" },

    -- VirtualText variants: link to base
    DiagnosticVirtualTextError = { link = "DiagnosticError" },
    DiagnosticVirtualTextWarn  = { link = "DiagnosticWarn" },
    DiagnosticVirtualTextInfo  = { link = "DiagnosticInfo" },
    DiagnosticVirtualTextHint  = { link = "DiagnosticHint" },
    DiagnosticVirtualTextOk    = { link = "DiagnosticOk" },

    -- VirtualLines variants: link to base
    DiagnosticVirtualLinesError = { link = "DiagnosticError" },
    DiagnosticVirtualLinesWarn  = { link = "DiagnosticWarn" },
    DiagnosticVirtualLinesInfo  = { link = "DiagnosticInfo" },
    DiagnosticVirtualLinesHint  = { link = "DiagnosticHint" },
    DiagnosticVirtualLinesOk    = { link = "DiagnosticOk" },
  }
end

return M
