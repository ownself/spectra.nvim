--- Quickstart scenario validation (T040).
--- Runs all 3 configuration examples from quickstart.md:
---   (1) 2-color minimal
---   (2) 8-color accent
---   (3) 27-color full
--- Verifies no errors and correct palette resolution.

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

local function assert_true(label, cond)
  if cond then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s", label))
  end
end

local function reload()
  for k in pairs(package.loaded) do
    if k:match("^spectra") then package.loaded[k] = nil end
  end
  return require("spectra")
end

-- ═══════════════════════════════════════════════════════════════
-- Scenario 1: 2-color minimal (quickstart.md line 34-41)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Quickstart: 2-color minimal ===")
do
  local spectra = reload()
  local ok, err = pcall(function()
    spectra.setup({
      palette = {
        fg = "#d4d4d4",
        bg = "#1e1e1e",
      },
    })
    spectra.load()
  end)
  assert_true("2-color: no errors", ok)
  if not ok then print("  Error: " .. tostring(err)) end

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_eq("2-color: Normal.fg", hex(normal.fg), "#d4d4d4")
  assert_eq("2-color: Normal.bg", hex(normal.bg), "#1e1e1e")
  assert_eq("2-color: colors_name", vim.g.colors_name, "spectra")

  -- Count HGs
  local count = 0
  for _ in pairs(vim.api.nvim_get_hl(0, {})) do count = count + 1 end
  assert_true("2-color: HG count >= 200", count >= 200)
  print(string.format("  HGs: %d", count))
end

-- ═══════════════════════════════════════════════════════════════
-- Scenario 2: 8-color accent (quickstart.md line 46-58)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Quickstart: 8-color accent ===")
do
  local spectra = reload()
  local ok, err = pcall(function()
    spectra.setup({
      palette = {
        fg = "#d4d4d4",
        bg = "#1e1e1e",
        ["accent.danger"]  = "#f44747",
        ["accent.success"] = "#6a9955",
        ["accent.info"]    = "#4fc1ff",
        ["accent.caution"] = "#dcdcaa",
        ["accent.action"]  = "#4ec9b0",
        ["accent.control"] = "#c586c0",
      },
    })
    spectra.load()
  end)
  assert_true("8-color: no errors", ok)
  if not ok then print("  Error: " .. tostring(err)) end

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_eq("8-color: Normal.fg", hex(normal.fg), "#d4d4d4")

  -- DiagnosticError should use accent.danger (or default theme's diag.error)
  local diag = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
  assert_true("8-color: DiagnosticError has fg", diag.fg ~= nil)
end

-- ═══════════════════════════════════════════════════════════════
-- Scenario 3: 27-color full (quickstart.md line 63-98)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Quickstart: 27-color full ===")
do
  local spectra = reload()
  local ok, err = pcall(function()
    spectra.setup({
      palette = {
        fg = "#d4d4d4",
        bg = "#1e1e1e",
        ["accent.danger"]  = "#f44747",
        ["accent.success"] = "#6a9955",
        ["accent.info"]    = "#4fc1ff",
        ["accent.caution"] = "#dcdcaa",
        ["accent.action"]  = "#4ec9b0",
        ["accent.control"] = "#c586c0",
        ["syntax.keyword"]  = "#569cd6",
        ["syntax.string"]   = "#ce9178",
        ["syntax.function"] = "#dcdcaa",
        ["syntax.comment"]  = "#6a9955",
        ["syntax.type"]     = "#4ec9b0",
        ["diag.error"]      = "#f44747",
        ["diag.warn"]       = "#cca700",
        ["diff.add"]        = "#4b5632",
        ["syntax.constant"]   = "#b5cea8",
        ["syntax.identifier"] = "#9cdcfe",
        ["syntax.special"]    = "#d7ba7d",
        ["syntax.operator"]   = "#d4d4d4",
        ["syntax.preproc"]    = "#c586c0",
        ["diag.info"]         = "#4fc1ff",
        ["diag.hint"]         = "#888888",
        ["diag.ok"]           = "#6a9955",
        ["diff.change"]       = "#0078d4",
        ["diff.delete"]       = "#6e3030",
        ["ui.search"]         = "#e8ab53",
      },
    })
    spectra.load()
  end)
  assert_true("27-color: no errors", ok)
  if not ok then print("  Error: " .. tostring(err)) end

  -- Verify specific colors applied
  local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
  assert_eq("27-color: Statement.fg = syntax.keyword", hex(statement.fg), "#569cd6")

  local string_hl = vim.api.nvim_get_hl(0, { name = "String" })
  assert_eq("27-color: String.fg = syntax.string", hex(string_hl.fg), "#ce9178")

  local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
  assert_eq("27-color: Comment.fg = syntax.comment", hex(comment.fg), "#6a9955")

  local constant = vim.api.nvim_get_hl(0, { name = "Constant" })
  assert_eq("27-color: Constant.fg = syntax.constant", hex(constant.fg), "#b5cea8")

  local diag_hint = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
  assert_eq("27-color: DiagnosticHint.fg = diag.hint", hex(diag_hint.fg), "#888888")

  -- Count HGs
  local count = 0
  for _ in pairs(vim.api.nvim_get_hl(0, {})) do count = count + 1 end
  assert_true("27-color: HG count >= 200", count >= 200)
  print(string.format("  HGs: %d", count))
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("Quickstart scenarios: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL SCENARIOS PASSED")
  vim.cmd("quit")
end
