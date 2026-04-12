--- Integration test: HG completeness validation (T025 — US5).
--- Verifies every group_name in hg-mapping.csv is defined by one of the group modules.

local palette = require("spectra.palette")

-- Resolve with defaults to get a full palette
local resolved = palette.resolve({
  fg = "#d4d4d4",
  bg = "#1e1e1e",
})

local config = { plugins = {} }

-- Collect all defined HGs from all group modules
local all_groups = {}
local modules = { "editor", "syntax", "treesitter", "lsp", "diagnostic", "diff" }

for _, mod_name in ipairs(modules) do
  local ok, mod = pcall(require, "spectra.groups." .. mod_name)
  if ok and mod.get then
    local hgs = mod.get(resolved, config)
    local count = 0
    for group, _ in pairs(hgs) do
      all_groups[group] = mod_name
      count = count + 1
    end
    print(string.format("  %s: %d groups", mod_name, count))
  else
    print(string.format("  ERROR: failed to load %s", mod_name))
  end
end

-- Count total defined groups
local total_defined = 0
for _ in pairs(all_groups) do
  total_defined = total_defined + 1
end
print(string.format("\nTotal defined HGs: %d", total_defined))

-- All 208 group_names from hg-mapping.csv (minus header row)
-- EditorBasic: 53, VimSyntax: 35, TreeSitter: 54, LSP: 32, Diagnostic: 32, Diff(in editor): 0 standalone
-- Note: diff.lua has 3 extra groups (diffAdded, diffChanged, diffRemoved) not in the main CSV
local csv_groups = {
  -- EditorBasic (53) — rows 2-54
  "Normal", "CursorLine", "CursorColumn", "ColorColumn", "Visual", "VisualNOS",
  "Search", "Substitute", "Pmenu", "PmenuSel", "PmenuMatch", "PmenuMatchSel",
  "NormalFloat", "FloatBorder", "FloatTitle", "StatusLine", "StatusLineNC",
  "TabLine", "TabLineSel", "TabLineFill", "SignColumn", "FoldColumn",
  "LineNr", "CursorLineNr", "NonText", "EndOfBuffer", "Whitespace", "Conceal",
  "Title", "Directory", "MoreMsg", "Question", "ErrorMsg", "WarningMsg",
  "ModeMsg", "OkMsg", "WinSeparator", "VertSplit", "Folded", "Cursor",
  "TermCursor", "MatchParen", "SpecialKey", "SearchSpecialSearchType", "StderrMsg",
  "DiffTextAdd", "Added", "Changed", "Removed", "DiffAdd", "DiffChange",
  "DiffDelete", "DiffText",

  -- VimSyntax (35) — rows 55-89
  "Comment", "String", "Constant", "Function", "Identifier", "Statement",
  "Operator", "Delimiter", "PreProc", "Type", "Special", "Todo", "Error",
  "Underlined", "Keyword", "Conditional", "Repeat", "Label", "Exception",
  "Boolean", "Character", "Number", "Float", "Include", "Define", "Macro",
  "PreCondit", "StorageClass", "Structure", "Typedef", "SpecialChar", "Tag",
  "Debug", "SpecialComment", "Ignore",

  -- TreeSitter (54) — rows 90-143
  "@variable", "@comment", "@string", "@string.special", "@string.escape",
  "@string.regexp", "@string.special.url", "@character", "@character.special",
  "@number", "@number.float", "@boolean", "@constant", "@constant.builtin",
  "@constant.macro", "@function", "@function.builtin", "@function.method",
  "@keyword", "@label", "@operator", "@punctuation", "@punctuation.special",
  "@property", "@variable.parameter", "@type", "@type.definition",
  "@type.qualifier", "@type.builtin", "@module", "@module.builtin",
  "@attribute", "@attribute.builtin", "@tag", "@tag.builtin", "@constructor",
  "@variable.builtin", "@variable.parameter.builtin",
  "@markup", "@markup.heading", "@markup.link", "@markup.italic",
  "@markup.strong", "@markup.strikethrough", "@markup.underline",
  "@markup.heading.1.delimiter.vimdoc", "@markup.heading.2.delimiter.vimdoc",
  "@diff.plus", "@diff.delta", "@diff.minus",
  "@comment.error", "@comment.warning", "@comment.note", "@comment.todo",

  -- LSP (32) — rows 144-175
  "@lsp.type.class", "@lsp.type.comment", "@lsp.type.decorator",
  "@lsp.type.enum", "@lsp.type.enumMember", "@lsp.type.event",
  "@lsp.type.function", "@lsp.type.interface", "@lsp.type.keyword",
  "@lsp.type.macro", "@lsp.type.method", "@lsp.type.modifier",
  "@lsp.type.namespace", "@lsp.type.number", "@lsp.type.operator",
  "@lsp.type.parameter", "@lsp.type.property", "@lsp.type.regexp",
  "@lsp.type.string", "@lsp.type.struct", "@lsp.type.type",
  "@lsp.type.typeParameter", "@lsp.type.variable",
  "@lsp.mod.deprecated",
  "LspReferenceText", "LspReferenceRead", "LspReferenceTarget",
  "LspReferenceWrite", "LspSignatureActiveParameter",
  "LspCodeLens", "LspCodeLensSeparator", "LspInlayHint",

  -- Diagnostic (32) — rows 176-207
  "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint",
  "DiagnosticOk", "DiagnosticUnderlineError", "DiagnosticUnderlineWarn",
  "DiagnosticUnderlineInfo", "DiagnosticUnderlineHint", "DiagnosticUnderlineOk",
  "DiagnosticDeprecated", "DiagnosticUnnecessary",
  "DiagnosticFloatingError", "DiagnosticSignError",
  "DiagnosticVirtualTextError", "DiagnosticVirtualLinesError",
  "DiagnosticFloatingWarn", "DiagnosticSignWarn",
  "DiagnosticVirtualTextWarn", "DiagnosticVirtualLinesWarn",
  "DiagnosticFloatingInfo", "DiagnosticSignInfo",
  "DiagnosticVirtualTextInfo", "DiagnosticVirtualLinesInfo",
  "DiagnosticFloatingHint", "DiagnosticSignHint",
  "DiagnosticVirtualTextHint", "DiagnosticVirtualLinesHint",
  "DiagnosticFloatingOk", "DiagnosticSignOk",
  "DiagnosticVirtualTextOk", "DiagnosticVirtualLinesOk",
}

-- Also add the 3 diff.lua groups (diffAdded, diffChanged, diffRemoved)
-- These are VimSyntax tradition groups not in the main CSV numbering
local extra_groups = { "diffAdded", "diffChanged", "diffRemoved" }

print(string.format("\nCSV groups to check: %d", #csv_groups))
print(string.format("Extra groups (diff.lua): %d", #extra_groups))

-- Check completeness
local missing = {}
for _, group in ipairs(csv_groups) do
  if not all_groups[group] then
    table.insert(missing, group)
  end
end

for _, group in ipairs(extra_groups) do
  if not all_groups[group] then
    table.insert(missing, group .. " (extra)")
  end
end

-- Also check IncSearch and CurSearch which are in editor.lua but not in CSV
-- (they were added as standard Neovim groups)

print(string.format("\n══════════════════════════════════════"))
if #missing == 0 then
  print(string.format("COMPLETENESS CHECK: ALL %d CSV groups covered", #csv_groups))
  print(string.format("Plus %d extra groups from diff.lua", #extra_groups))
  print(string.format("Total HGs defined: %d", total_defined))
  print("ALL GROUPS ACCOUNTED FOR")
  vim.cmd("quit")
else
  print(string.format("COMPLETENESS CHECK: %d MISSING groups:", #missing))
  for _, m in ipairs(missing) do
    print("  - " .. m)
  end
  print(string.format("══════════════════════════════════════"))
  vim.cmd("cquit 1")
end
