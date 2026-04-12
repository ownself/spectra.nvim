--- LSP semantic token highlight group definitions (L4).
--- Source: hg-mapping.csv rows where source=LSP (32 groups).
--- All groups link to their TreeSitter or editor equivalents.
--- @module spectra.groups.lsp

local M = {}

--- Generate LSP highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  return {
    -- LSP semantic token types → link to TreeSitter captures
    ["@lsp.type.class"]         = { link = "@type" },
    ["@lsp.type.comment"]       = { link = "@comment" },
    ["@lsp.type.decorator"]     = { link = "@attribute" },
    ["@lsp.type.enum"]          = { link = "@type" },
    ["@lsp.type.enumMember"]    = { link = "@constant" },
    ["@lsp.type.event"]         = { link = "@type" },
    ["@lsp.type.function"]      = { link = "@function" },
    ["@lsp.type.interface"]     = { link = "@type" },
    ["@lsp.type.keyword"]       = { link = "@keyword" },
    ["@lsp.type.macro"]         = { link = "@constant.macro" },
    ["@lsp.type.method"]        = { link = "@function.method" },
    ["@lsp.type.modifier"]      = { link = "@type.qualifier" },
    ["@lsp.type.namespace"]     = { link = "@module" },
    ["@lsp.type.number"]        = { link = "@number" },
    ["@lsp.type.operator"]      = { link = "@operator" },
    ["@lsp.type.parameter"]     = { link = "@variable.parameter" },
    ["@lsp.type.property"]      = { link = "@property" },
    ["@lsp.type.regexp"]        = { link = "@string.regexp" },
    ["@lsp.type.string"]        = { link = "@string" },
    ["@lsp.type.struct"]        = { link = "@type" },
    ["@lsp.type.type"]          = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"]      = { link = "@variable" },

    -- LSP modifier
    ["@lsp.mod.deprecated"]     = { link = "DiagnosticDeprecated" },

    -- LSP reference highlights
    LspReferenceText            = { link = "Visual" },
    LspReferenceRead            = { link = "LspReferenceText" },
    LspReferenceTarget          = { link = "LspReferenceText" },
    LspReferenceWrite           = { link = "LspReferenceText" },

    -- LSP signature
    LspSignatureActiveParameter = { link = "Visual" },

    -- LSP code lens
    LspCodeLens                 = { link = "NonText" },
    LspCodeLensSeparator        = { link = "LspCodeLens" },

    -- LSP inlay hints
    LspInlayHint                = { link = "NonText" },
  }
end

return M
