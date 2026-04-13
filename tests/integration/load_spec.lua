--- Integration test: full load pipeline (T038).
--- Verifies:
---   (1) Default load without errors
---   (2) 201+ HGs all have definitions
---   (3) setup() before/after state
---   (4) dark/light switch correct

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
-- Test 1: Default load no errors
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: Default load ===")
do
  local spectra = reload()
  local ok, err = pcall(function()
    spectra.load()
  end)
  assert_true("load() succeeds", ok)
  if not ok then print("  Error: " .. tostring(err)) end
  assert_eq("colors_name set", vim.g.colors_name, "spectra")
  assert_eq("loaded flag", spectra._loaded, true)
end

-- ═══════════════════════════════════════════════════════════════
-- Test 2: HG count ≥ 201
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: HG count ===")
do
  -- Count all HGs that have at least one property set
  local defined = 0
  local all_groups = vim.api.nvim_get_hl(0, {})
  for _, _ in pairs(all_groups) do
    defined = defined + 1
  end
  print(string.format("  Total HGs with definitions: %d", defined))
  assert_true("HG count >= 201", defined >= 201)
end

-- ═══════════════════════════════════════════════════════════════
-- Test 3: setup() state management
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 3: setup() state ===")
do
  local spectra = reload()
  assert_eq("before setup: _config nil", spectra._config, nil)
  assert_eq("before setup: _loaded false", spectra._loaded, false)

  spectra.setup({ style = "dark" })
  assert_true("after setup: _config set", spectra._config ~= nil)
  assert_eq("after setup: style", spectra._config.style, "dark")

  -- load() without prior setup() should auto-setup
  local spectra2 = reload()
  spectra2.load()
  assert_true("auto-setup: _config set", spectra2._config ~= nil)
  assert_eq("auto-setup: default style", spectra2._config.style, "dark")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 4: dark/light switch
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 4: dark/light switch ===")
do
  local spectra = reload()
  spectra.setup({ style = "dark" })
  spectra.load()

  local dark_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  assert_eq("dark bg", hex(dark_bg), "#1e1e1e")

  local spectra2 = reload()
  spectra2.setup({ style = "light" })
  spectra2.load()

  local light_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  assert_eq("light bg", hex(light_bg), "#ffffff")

  assert_true("dark != light", dark_bg ~= light_bg)
end

-- ═══════════════════════════════════════════════════════════════
-- Test 5: Key HG spot checks
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 5: Key HG spot checks ===")
do
  local spectra = reload()
  spectra.setup({ style = "dark" })
  spectra.load()

  -- Editor
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  assert_true("Normal has fg+bg", normal.fg ~= nil and normal.bg ~= nil)

  local search = vim.api.nvim_get_hl(0, { name = "Search" })
  assert_true("Search has fg+bg", search.fg ~= nil and search.bg ~= nil)
  assert_eq("Search fg uses dark text on bright search bg", hex(search.fg), "#1e1e1e")

  -- Syntax
  local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
  assert_true("Comment has fg", comment.fg ~= nil)
  assert_eq("Comment italic disabled", comment.italic, nil)

  local statement = vim.api.nvim_get_hl(0, { name = "Statement" })
  assert_true("Statement has fg", statement.fg ~= nil)
  assert_eq("Statement bold", statement.bold, true)

  -- TreeSitter links
  local ts_kw = vim.api.nvim_get_hl(0, { name = "@keyword" })
  assert_eq("@keyword links to Keyword", ts_kw.link, "Keyword")

  -- LSP links
  local lsp_func = vim.api.nvim_get_hl(0, { name = "@lsp.type.function" })
  assert_eq("@lsp.type.function links to @function", lsp_func.link, "@function")

  -- Diagnostic
  local diag_err = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
  assert_true("DiagnosticError has fg", diag_err.fg ~= nil)

  -- Plugin (telescope)
  local ts_normal = vim.api.nvim_get_hl(0, { name = "TelescopeNormal" })
  assert_true("TelescopeNormal has bg", ts_normal.bg ~= nil)
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("load_spec: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
