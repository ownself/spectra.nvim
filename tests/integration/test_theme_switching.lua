--- Integration test: dark/light theme switching (T028-T031 — US6).
--- Verifies:
---   (1) style="dark" loads dark scheme
---   (2) style="light" loads light scheme
---   (3) style="auto" respects vim.o.background
---   (4) dark/light sub-palettes apply correctly
---   (5) OptionSet autocmd triggers reload on background change (style="auto")

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

local function reload_spectra()
  -- Clear module cache for clean reload
  for k, _ in pairs(package.loaded) do
    if k:match("^spectra") then
      package.loaded[k] = nil
    end
  end
  return require("spectra")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 1: style="dark" loads dark theme
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: style='dark' ===")
do
  local spectra = reload_spectra()
  spectra.setup({ style = "dark" })
  spectra.load()

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  -- Default dark: fg=#d4d4d4, bg=#1e1e1e
  assert_eq("dark: Normal.fg", hex(normal.fg), "#d4d4d4")
  assert_eq("dark: Normal.bg", hex(normal.bg), "#1e1e1e")
  assert_eq("dark: vim.o.background", vim.o.background, "dark")

  print("  style='dark' ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 2: style="light" loads light theme
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: style='light' ===")
do
  local spectra = reload_spectra()
  spectra.setup({ style = "light" })
  spectra.load()

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  -- Default light: fg=#333333, bg=#ffffff
  assert_eq("light: Normal.fg", hex(normal.fg), "#333333")
  assert_eq("light: Normal.bg", hex(normal.bg), "#ffffff")
  assert_eq("light: vim.o.background", vim.o.background, "light")

  -- Verify syntax colors use light theme values
  local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
  -- Default light keyword: #0000ff
  assert_eq("light: Statement.fg", hex(statement.fg), "#0000ff")

  print("  style='light' ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 3: style="auto" respects vim.o.background
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 3: style='auto' ===")
do
  local spectra = reload_spectra()
  -- Set background before setup
  vim.o.background = "dark"
  spectra.setup({ style = "auto" })
  spectra.load()

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_eq("auto-dark: Normal.bg", hex(normal.bg), "#1e1e1e")

  print("  style='auto' ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 4: dark/light sub-palettes apply correctly
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 4: dark/light sub-palettes ===")
do
  local spectra = reload_spectra()
  spectra.setup({
    style = "dark",
    dark = {
      ["syntax.keyword"] = "#ff79c6",  -- Dracula-style pink keyword
    },
    light = {
      ["syntax.keyword"] = "#0000ff",  -- Blue keyword for light
    },
  })
  spectra.load()

  -- Dark mode: should use dark sub-palette keyword
  local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
  assert_eq("dark sub-palette: Statement.fg", hex(statement.fg), "#ff79c6")

  -- Now reload in light mode
  local spectra2 = reload_spectra()
  spectra2.setup({
    style = "light",
    dark = {
      ["syntax.keyword"] = "#ff79c6",
    },
    light = {
      ["syntax.keyword"] = "#0000ff",
    },
  })
  spectra2.load()

  local statement2 = vim.api.nvim_get_hl(0, { name = "Statement" })
  assert_eq("light sub-palette: Statement.fg", hex(statement2.fg), "#0000ff")

  print("  dark/light sub-palettes ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 5: OptionSet autocmd with style="auto"
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 5: OptionSet autocmd ===")
do
  local spectra = reload_spectra()
  vim.o.background = "dark"
  spectra.setup({ style = "auto" })
  spectra.load()

  -- Verify autocmd group exists
  assert_true("autocmd group created", spectra._augroup ~= nil)

  -- Check dark colors applied
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_eq("auto: starts dark", hex(normal.bg), "#1e1e1e")

  -- Simulate background change via :set background=light
  -- This triggers OptionSet autocmd
  vim.o.background = "light"
  -- In headless mode the autocmd fires synchronously
  vim.cmd("doautocmd OptionSet background")

  local normal2 = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_eq("auto: switched to light bg", hex(normal2.bg), "#ffffff")
  assert_eq("auto: switched to light fg", hex(normal2.fg), "#333333")

  print("  OptionSet autocmd ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 6: No autocmd when style != "auto"
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 6: No autocmd for explicit style ===")
do
  local spectra = reload_spectra()
  spectra.setup({ style = "dark" })
  spectra.load()

  assert_eq("no autocmd for style=dark", spectra._augroup, nil)

  print("  No autocmd for explicit style ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 7: Light theme has correct built-in colors
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 7: Light theme built-in palette ===")
do
  local default_theme = require("spectra.themes.default")

  -- Verify light palette has all expected keys
  assert_eq("light has fg", default_theme.light.fg, "#333333")
  assert_eq("light has bg", default_theme.light.bg, "#ffffff")
  assert_true("light has accent.danger", default_theme.light["accent.danger"] ~= nil)
  assert_true("light has accent.success", default_theme.light["accent.success"] ~= nil)
  assert_true("light has syntax.keyword", default_theme.light["syntax.keyword"] ~= nil)
  assert_true("light has syntax.string", default_theme.light["syntax.string"] ~= nil)
  assert_true("light has diag.error", default_theme.light["diag.error"] ~= nil)
  assert_true("light has diff.add", default_theme.light["diff.add"] ~= nil)

  -- Count light palette size (should be 16: 2 base + 6 accent + 8 role)
  local count = 0
  for _ in pairs(default_theme.light) do count = count + 1 end
  assert_eq("light palette size = 16", count, 16)

  print("  Light theme built-in palette ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("Theme switching (US6): %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
