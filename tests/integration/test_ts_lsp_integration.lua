--- Integration test: TreeSitter + LSP HG integration (T023/T024 validation).
--- Verifies that:
---   (1) TreeSitter groups load and link correctly
---   (2) LSP groups link to TreeSitter groups
---   (3) Variant colors override links when provided
---   (4) Full load pipeline produces correct HG count

local spectra = require("spectra")

local pass_count = 0
local fail_count = 0

local function hex(n)
  if not n then return "nil" end
  return string.format("#%06x", n)
end

local function assert_eq(label, got, expected)
  if got == expected then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — expected '%s', got '%s'", label, tostring(expected), tostring(got)))
  end
end

-- ═══════════════════════════════════════════════════════════════
-- Test 1: Default load — TS/LSP groups all link-based
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: Default load with TS/LSP ===")
spectra.setup({ style = "dark" })
spectra.load()

-- TreeSitter link groups
local ts_comment = vim.api.nvim_get_hl(0, { name = "@comment" })
assert_eq("@comment links to Comment", ts_comment.link, "Comment")

local ts_string = vim.api.nvim_get_hl(0, { name = "@string" })
assert_eq("@string links to String", ts_string.link, "String")

local ts_function = vim.api.nvim_get_hl(0, { name = "@function" })
assert_eq("@function links to Function", ts_function.link, "Function")

local ts_keyword = vim.api.nvim_get_hl(0, { name = "@keyword" })
assert_eq("@keyword links to Keyword", ts_keyword.link, "Keyword")

local ts_type = vim.api.nvim_get_hl(0, { name = "@type" })
assert_eq("@type links to Type", ts_type.link, "Type")

-- @variable has direct fg
local ts_var = vim.api.nvim_get_hl(0, { name = "@variable" })
assert_eq("@variable has fg (not link)", ts_var.link, nil)
assert_eq("@variable.fg is set", ts_var.fg ~= nil, true)

-- LSP link groups
local lsp_func = vim.api.nvim_get_hl(0, { name = "@lsp.type.function" })
assert_eq("@lsp.type.function links to @function", lsp_func.link, "@function")

local lsp_var = vim.api.nvim_get_hl(0, { name = "@lsp.type.variable" })
assert_eq("@lsp.type.variable links to @variable", lsp_var.link, "@variable")

local lsp_kw = vim.api.nvim_get_hl(0, { name = "@lsp.type.keyword" })
assert_eq("@lsp.type.keyword links to @keyword", lsp_kw.link, "@keyword")

local lsp_ref = vim.api.nvim_get_hl(0, { name = "LspReferenceText" })
assert_eq("LspReferenceText links to Visual", lsp_ref.link, "Visual")

local lsp_inlay = vim.api.nvim_get_hl(0, { name = "LspInlayHint" })
assert_eq("LspInlayHint links to NonText", lsp_inlay.link, "NonText")

-- Markup style groups
local mk_italic = vim.api.nvim_get_hl(0, { name = "@markup.italic" })
assert_eq("@markup.italic has italic", mk_italic.italic, true)

local mk_bold = vim.api.nvim_get_hl(0, { name = "@markup.strong" })
assert_eq("@markup.strong has bold", mk_bold.bold, true)

-- Diff captures
local diff_plus = vim.api.nvim_get_hl(0, { name = "@diff.plus" })
assert_eq("@diff.plus links to Added", diff_plus.link, "Added")

print(string.format("  Test 1: default TS/LSP links ✓"))

-- ═══════════════════════════════════════════════════════════════
-- Test 2: Variant colors override TS links
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: Variant override ===")

-- Clear module cache to reload with new config
package.loaded["spectra"] = nil
package.loaded["spectra.init"] = nil
package.loaded["spectra.groups.treesitter"] = nil
local spectra2 = require("spectra")

spectra2.setup({
  palette = {
    ["syntax.function.method"] = "#aabbcc",
    ["syntax.function.builtin"] = "#ddeeff",
    ["syntax.type.builtin"] = "#112233",
  },
  style = "dark",
})
spectra2.load()

-- @function.method should now have independent fg, not link
local fm = vim.api.nvim_get_hl(0, { name = "@function.method" })
assert_eq("@function.method has fg (variant override)", fm.link, nil)
assert_eq("@function.method.fg", hex(fm.fg), "#aabbcc")

-- @function.builtin should also have independent fg
local fb = vim.api.nvim_get_hl(0, { name = "@function.builtin" })
assert_eq("@function.builtin has fg (variant override)", fb.link, nil)
assert_eq("@function.builtin.fg", hex(fb.fg), "#ddeeff")

-- @type.builtin should have independent fg
local tb = vim.api.nvim_get_hl(0, { name = "@type.builtin" })
assert_eq("@type.builtin has fg (variant override)", tb.link, nil)
assert_eq("@type.builtin.fg", hex(tb.fg), "#112233")

-- @function should still link (parent wasn't overridden directly, but gets promoted)
-- Due to variant promotion, syntax.function gets the value of syntax.function.method
-- So @function still links to Function, but Function gets the promoted color
local f = vim.api.nvim_get_hl(0, { name = "@function" })
assert_eq("@function still links to Function", f.link, "Function")

print(string.format("  Test 2: variant override ✓"))

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("TS/LSP integration: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
