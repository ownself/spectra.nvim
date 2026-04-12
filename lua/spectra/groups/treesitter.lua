--- TreeSitter highlight group definitions (L3).
--- Source: hg-mapping.csv rows where source=TreeSitter (54 groups).
--- Groups with layer-4 variant colors get independent fg; others link to VimSyntax.
--- @module spectra.groups.treesitter

local M = {}

--- Generate TreeSitter highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  local groups = {
    -- @variable: uses syntax.variable (falls back to fg if not set)
    ["@variable"] = { fg = p["syntax.variable"] },

    -- Core captures → link to VimSyntax equivalents
    ["@comment"]          = { link = "Comment" },
    ["@string"]           = { link = "String" },
    ["@string.special"]   = { link = "SpecialChar" },
    ["@string.escape"]    = { link = "@string.special" },
    ["@string.regexp"]    = { link = "@string.special" },
    ["@string.special.url"] = { link = "Underlined" },
    ["@character"]        = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@number"]           = { link = "Number" },
    ["@number.float"]     = { link = "Float" },
    ["@boolean"]          = { link = "Boolean" },
    ["@constant"]         = { link = "Constant" },
    ["@constant.builtin"] = { link = "Special" },
    ["@constant.macro"]   = { link = "@constant" },
    ["@function"]         = { link = "Function" },
    ["@function.builtin"] = { link = "Special" },
    ["@function.method"]  = { link = "@function" },
    ["@keyword"]          = { link = "Keyword" },
    ["@label"]            = { link = "Label" },
    ["@operator"]         = { link = "Operator" },
    ["@punctuation"]      = { link = "Delimiter" },
    ["@punctuation.special"] = { link = "Special" },
    ["@property"]         = { link = "Identifier" },
    ["@variable.parameter"] = { link = "@variable" },
    ["@variable.builtin"] = { link = "Constant" },
    ["@variable.parameter.builtin"] = { link = "@variable.builtin" },
    ["@type"]             = { link = "Type" },
    ["@type.definition"]  = { link = "@type" },
    ["@type.qualifier"]   = { link = "@type" },
    ["@type.builtin"]     = { link = "Type" },
    ["@module"]           = { link = "Structure" },
    ["@module.builtin"]   = { link = "@module" },
    ["@attribute"]        = { link = "Macro" },
    ["@attribute.builtin"] = { link = "Special" },
    ["@tag"]              = { link = "Tag" },
    ["@tag.builtin"]      = { link = "@tag" },
    ["@constructor"]      = { link = "Type" },

    -- Markup captures
    ["@markup"]               = { link = "Special" },
    ["@markup.heading"]       = { link = "Title" },
    ["@markup.link"]          = { link = "Underlined" },
    ["@markup.italic"]        = { italic = true },
    ["@markup.strong"]        = { bold = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"]     = { underline = true },

    -- Vimdoc special headings
    ["@markup.heading.1.delimiter.vimdoc"] = { fg = p.bg, bg = p.bg, sp = p.fg, underdouble = true, nocombine = true },
    ["@markup.heading.2.delimiter.vimdoc"] = { fg = p.bg, bg = p.bg, sp = p.fg, underline = true, nocombine = true },

    -- Diff captures → link to Added/Changed/Removed
    ["@diff.plus"]  = { link = "Added" },
    ["@diff.delta"] = { link = "Changed" },
    ["@diff.minus"] = { link = "Removed" },

    -- Comment semantic captures → link to Diagnostic
    ["@comment.error"]   = { link = "DiagnosticError" },
    ["@comment.warning"] = { link = "DiagnosticWarn" },
    ["@comment.note"]    = { link = "DiagnosticInfo" },
    ["@comment.todo"]    = { link = "Todo" },
  }

  -- Layer-4 variant color overrides: if user provided a variant-specific color,
  -- set independent fg instead of linking to the parent group.
  -- The palette resolver already handles fallback — if the variant color equals
  -- the parent color, linking is visually identical. But if the user explicitly
  -- set a variant color, they want differentiation.

  -- syntax.function.method → @function.method
  if p["syntax.function.method"] ~= p["syntax.function"] then
    groups["@function.method"] = { fg = p["syntax.function.method"] }
  end

  -- syntax.function.builtin → @function.builtin
  if p["syntax.function.builtin"] ~= p["syntax.function"] then
    groups["@function.builtin"] = { fg = p["syntax.function.builtin"] }
  end

  -- syntax.constant.builtin → @constant.builtin
  if p["syntax.constant.builtin"] ~= p["syntax.constant"] then
    groups["@constant.builtin"] = { fg = p["syntax.constant.builtin"] }
  end

  -- syntax.constant.macro → @constant.macro
  if p["syntax.constant.macro"] ~= p["syntax.constant"] then
    groups["@constant.macro"] = { fg = p["syntax.constant.macro"] }
  end

  -- syntax.type.builtin → @type.builtin
  if p["syntax.type.builtin"] ~= p["syntax.type"] then
    groups["@type.builtin"] = { fg = p["syntax.type.builtin"] }
  end

  -- syntax.type.definition → @type.definition
  if p["syntax.type.definition"] ~= p["syntax.type"] then
    groups["@type.definition"] = { fg = p["syntax.type.definition"] }
  end

  -- syntax.type.module → @module (not @type.module — TS uses @module for modules)
  if p["syntax.type.module"] ~= p["syntax.type"] then
    groups["@module"] = { fg = p["syntax.type.module"] }
  end

  -- syntax.string.escape → @string.escape
  if p["syntax.string.escape"] ~= p["syntax.string"] then
    groups["@string.escape"] = { fg = p["syntax.string.escape"] }
  end

  -- syntax.string.special → @string.special
  if p["syntax.string.special"] ~= p["syntax.string"] then
    groups["@string.special"] = { fg = p["syntax.string.special"] }
  end

  -- syntax.comment.doc → @comment (no separate @comment.doc in standard TS)
  -- Doc comments typically use the same @comment group; variant color applied
  -- only if user explicitly differentiated it
  if p["syntax.comment.doc"] ~= p["syntax.comment"] then
    -- Some TS parsers emit @comment.documentation
    groups["@comment.documentation"] = { fg = p["syntax.comment.doc"], italic = true }
  end

  -- syntax.identifier.member → @property
  if p["syntax.identifier.member"] ~= p["syntax.identifier"] then
    groups["@property"] = { fg = p["syntax.identifier.member"] }
  end

  -- syntax.identifier.parameter → @variable.parameter
  if p["syntax.identifier.parameter"] ~= p["syntax.identifier"] then
    groups["@variable.parameter"] = { fg = p["syntax.identifier.parameter"] }
  end

  -- syntax.preproc.include → handled by @attribute link to Macro → PreProc
  if p["syntax.preproc.include"] ~= p["syntax.preproc"] then
    groups["@attribute"] = { fg = p["syntax.preproc.include"] }
  end

  -- syntax.preproc.macro → @attribute.builtin
  if p["syntax.preproc.macro"] ~= p["syntax.preproc"] then
    groups["@attribute.builtin"] = { fg = p["syntax.preproc.macro"] }
  end

  -- syntax.label → @label
  if p["syntax.label"] ~= p["syntax.keyword"] then
    groups["@label"] = { fg = p["syntax.label"] }
  end

  -- syntax.constant.character → @character
  if p["syntax.constant.character"] ~= p["syntax.constant"] then
    groups["@character"] = { fg = p["syntax.constant.character"] }
    groups["@character.special"] = { fg = p["syntax.constant.character"] }
  end

  -- syntax.variable → @variable (already set as default, but ensure override for member)
  -- When syntax.variable differs from syntax.identifier, @variable.parameter
  -- should still use identifier.parameter if set, so no extra logic needed.

  -- syntax.tag → @tag
  if p["syntax.tag"] ~= p["syntax.keyword"] then
    groups["@tag"] = { fg = p["syntax.tag"] }
    groups["@tag.builtin"] = { fg = p["syntax.tag"] }
  end

  -- syntax.type.constructor → @constructor
  if p["syntax.type.constructor"] ~= p["syntax.type"] then
    groups["@constructor"] = { fg = p["syntax.type.constructor"] }
  end

  -- syntax.identifier.builtin → @variable.builtin
  if p["syntax.identifier.builtin"] ~= p["syntax.identifier"] then
    groups["@variable.builtin"] = { fg = p["syntax.identifier.builtin"] }
  end

  -- syntax.identifier.field → @variable.member
  if p["syntax.identifier.field"] ~= p["syntax.identifier.member"] then
    groups["@variable.member"] = { fg = p["syntax.identifier.field"] }
  end

  -- syntax.delimiter → @punctuation (already handled via Delimiter in syntax.lua)
  -- But also ensure @punctuation.delimiter uses it
  if p["syntax.delimiter"] ~= p.fg then
    groups["@punctuation.delimiter"] = { fg = p["syntax.delimiter"] }
  end

  return groups
end

return M
