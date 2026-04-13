--- VimSyntax highlight group definitions (L2).
--- Source: hg-mapping.csv rows where source=VimSyntax (35 groups).
--- @module spectra.groups.syntax

local M = {}

--- Generate VimSyntax highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  local groups = {
    -- Root syntax groups with direct palette mapping
    Comment    = { fg = p["syntax.comment"] },
    String     = { fg = p["syntax.string"] },
    Constant   = { fg = p["syntax.constant"] },
    Function   = { fg = p["syntax.function"] },
    Identifier = { fg = p["syntax.identifier"] },
    Statement  = { fg = p["syntax.keyword"], bold = true },
    Operator   = { fg = p["syntax.operator"] },
    Delimiter  = { fg = p["syntax.delimiter"] },
    PreProc    = { fg = p["syntax.preproc"] },
    Type       = { fg = p["syntax.type"] },
    Special    = { fg = p["syntax.special"] },
    Todo       = { fg = p.fg, bold = true },
    Error      = { fg = p.fg, bg = p["diag.error.bg"] },
    Underlined = { underline = true },

    -- Statement children → link to Statement
    Keyword     = { link = "Statement" },
    Conditional = { link = "Statement" },
    Repeat      = { link = "Statement" },
    Exception   = { link = "Statement" },

    -- Constant children → link to Constant
    Boolean   = { link = "Constant" },
    Number    = { link = "Constant" },
    Float     = { link = "Number" },

    -- PreProc children → link to PreProc
    Include  = { link = "PreProc" },
    Define   = { link = "PreProc" },
    Macro    = { link = "PreProc" },
    PreCondit = { link = "PreProc" },

    -- Type children → link to Type
    StorageClass = { link = "Type" },
    Structure    = { link = "Type" },
    Typedef      = { link = "Type" },

    -- Special children → link to Special
    SpecialChar    = { link = "Special" },
    Debug          = { link = "Special" },
    SpecialComment = { link = "Special" },

    -- Misc
    Ignore = { link = "Normal" },
  }

  -- Tag: use syntax.tag if distinct from keyword, else link to Special
  if p["syntax.tag"] ~= p["syntax.keyword"] then
    groups.Tag = { fg = p["syntax.tag"] }
  else
    groups.Tag = { link = "Special" }
  end

  -- Label: use syntax.label if distinct from keyword, else link to Statement
  if p["syntax.label"] ~= p["syntax.keyword"] then
    groups.Label = { fg = p["syntax.label"] }
  else
    groups.Label = { link = "Statement" }
  end

  -- Character: use syntax.constant.character if distinct from constant, else link
  if p["syntax.constant.character"] ~= p["syntax.constant"] then
    groups.Character = { fg = p["syntax.constant.character"] }
  else
    groups.Character = { link = "Constant" }
  end

  return groups
end

return M
