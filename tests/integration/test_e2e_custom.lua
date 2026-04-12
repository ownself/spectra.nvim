--- End-to-end test: custom 8-color palette through full load pipeline
local spectra = require("spectra")
spectra.setup({
  palette = {
    fg = "#e0e0e0",
    bg = "#1a1a2e",
    ["accent.danger"]  = "#ff6b6b",
    ["accent.success"] = "#51cf66",
    ["accent.info"]    = "#74c0fc",
    ["accent.caution"] = "#ffd43b",
    ["accent.action"]  = "#38d9a9",
    ["accent.control"] = "#da77f2",
  },
  style = "dark",
})
spectra.load()

local function hex(n)
  return string.format("#%06x", n)
end

local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
local diag_err = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })

-- Note: default theme provides layer 0-2 as base. User accent overrides don't
-- affect role-level slots that are already defined in the default theme.
-- syntax.comment comes from default.dark (#6a9955), syntax.keyword from default.dark (#569cd6),
-- diag.error from default.dark (#f44747). User accent colors only affect slots
-- NOT already provided by the default theme.
print("Normal.fg = " .. hex(normal.fg) .. " (expected #e0e0e0 — user override)")
print("Normal.bg = " .. hex(normal.bg) .. " (expected #1a1a2e — user override)")
print("Comment.fg = " .. hex(comment.fg) .. " (expected #6a9955 — default theme layer 2)")
print("Statement.fg = " .. hex(statement.fg) .. " (expected #569cd6 — default theme layer 2)")
print("DiagnosticError.fg = " .. hex(diag_err.fg) .. " (expected #f44747 — default theme layer 2)")
print("vim.g.colors_name = " .. vim.g.colors_name)

-- Verify key groups
local pass, fail = 0, 0
local function check(label, got, expected)
  if got == expected then
    pass = pass + 1
  else
    fail = fail + 1
    print(string.format("  FAIL: %s — expected %s, got %s", label, expected, got))
  end
end

check("Normal.fg = user override", hex(normal.fg), "#e0e0e0")
check("Normal.bg = user override", hex(normal.bg), "#1a1a2e")
-- Default theme provides these at layer 2, user didn't override them
check("Comment.fg = default theme", hex(comment.fg), "#6a9955")
check("Statement.fg = default theme keyword", hex(statement.fg), "#569cd6")
check("DiagnosticError.fg = default theme diag.error", hex(diag_err.fg), "#f44747")
check("colors_name", vim.g.colors_name, "spectra")

-- Check HG count
local key_groups = {
  "Normal", "Comment", "Statement", "String", "Function", "Type",
  "DiagnosticError", "DiagnosticWarn", "DiffAdd", "Visual", "Search",
  "Pmenu", "StatusLine", "CursorLine",
}
local defined = 0
for _, name in ipairs(key_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = name })
  if hl.fg or hl.bg or hl.link then defined = defined + 1 end
end
print(string.format("\nKey HGs with definitions: %d/%d", defined, #key_groups))
check("all key HGs defined", tostring(defined), tostring(#key_groups))

print(string.format("\nE2E custom palette: %d passed, %d failed", pass, fail))

if fail > 0 then
  vim.cmd("cquit 1")
else
  print("ALL PASSED")
  vim.cmd("quit")
end
