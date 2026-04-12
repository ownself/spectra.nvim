--- End-to-end test: user overrides role-level colors over default theme
local spectra = require("spectra")
spectra.setup({
  palette = {
    fg = "#e0e0e0",
    bg = "#1a1a2e",
    -- User explicitly overrides role-level slots (layer 2)
    ["syntax.keyword"] = "#ff79c6",
    ["syntax.string"]  = "#f1fa8c",
    ["syntax.comment"] = "#6272a4",
    ["diag.error"]     = "#ff5555",
  },
  style = "dark",
})
spectra.load()

local function hex(n)
  return string.format("#%06x", n)
end

local pass, fail = 0, 0
local function check(label, got, expected)
  if got == expected then
    pass = pass + 1
  else
    fail = fail + 1
    print(string.format("  FAIL: %s — expected %s, got %s", label, expected, got))
  end
end

local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
local str = vim.api.nvim_get_hl(0, { name = "String" })
local diag_err = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })

-- User overrides should win over default theme
check("Normal.fg = user", hex(normal.fg), "#e0e0e0")
check("Normal.bg = user", hex(normal.bg), "#1a1a2e")
check("Comment.fg = user override", hex(comment.fg), "#6272a4")
check("Statement.fg = user keyword", hex(statement.fg), "#ff79c6")
check("String.fg = user string", hex(str.fg), "#f1fa8c")
check("DiagnosticError.fg = user diag.error", hex(diag_err.fg), "#ff5555")

-- Non-overridden role slots keep default theme values
local func = vim.api.nvim_get_hl(0, { name = "Function" })
check("Function.fg = default theme syntax.function", hex(func.fg), "#dcdcaa")

local typ = vim.api.nvim_get_hl(0, { name = "Type" })
check("Type.fg = default theme syntax.type", hex(typ.fg), "#4ec9b0")

print(string.format("\nE2E role override: %d passed, %d failed", pass, fail))

if fail > 0 then
  vim.cmd("cquit 1")
else
  print("ALL PASSED")
  vim.cmd("quit")
end
