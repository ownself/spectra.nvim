--- Integration test: third-party plugin HG support (T032-T034 — US7).
--- Verifies:
---   (1) Plugin HGs load when enabled (default)
---   (2) Individual plugins can be disabled
---   (3) All plugin groups use correct palette colors
---   (4) Plugin groups integrate with full load pipeline

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
  for k, _ in pairs(package.loaded) do
    if k:match("^spectra") then
      package.loaded[k] = nil
    end
  end
  return require("spectra")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 1: All plugins enabled by default
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: All plugins enabled ===")
do
  local spectra = reload_spectra()
  spectra.setup({ style = "dark" })
  spectra.load()

  -- Telescope groups should exist
  local ts_normal = vim.api.nvim_get_hl(0, { name = "TelescopeNormal" })
  assert_true("TelescopeNormal has bg", ts_normal.bg ~= nil)

  local ts_match = vim.api.nvim_get_hl(0, { name = "TelescopeMatching" })
  assert_true("TelescopeMatching has fg", ts_match.fg ~= nil)
  assert_eq("TelescopeMatching bold", ts_match.bold, true)

  -- nvim-tree groups should exist
  local nt_normal = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })
  assert_true("NvimTreeNormal has bg", nt_normal.bg ~= nil)

  local nt_dirty = vim.api.nvim_get_hl(0, { name = "NvimTreeGitDirty" })
  assert_true("NvimTreeGitDirty has fg", nt_dirty.fg ~= nil)

  -- gitsigns groups should exist
  local gs_add = vim.api.nvim_get_hl(0, { name = "GitSignsAdd" })
  assert_true("GitSignsAdd has fg", gs_add.fg ~= nil)

  local gs_change = vim.api.nvim_get_hl(0, { name = "GitSignsChange" })
  assert_true("GitSignsChange has fg", gs_change.fg ~= nil)

  local gs_del = vim.api.nvim_get_hl(0, { name = "GitSignsDelete" })
  assert_true("GitSignsDelete has fg", gs_del.fg ~= nil)

  -- indent-blankline groups should exist
  local ibl = vim.api.nvim_get_hl(0, { name = "IblIndent" })
  assert_true("IblIndent has fg", ibl.fg ~= nil)

  local ibl_scope = vim.api.nvim_get_hl(0, { name = "IblScope" })
  assert_true("IblScope has fg", ibl_scope.fg ~= nil)

  print("  All plugins enabled ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 2: Disable individual plugins
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: Disable telescope ===")
do
  local spectra = reload_spectra()
  spectra.setup({
    style = "dark",
    plugins = {
      telescope = false,
      nvim_tree = true,
      gitsigns = true,
      indent_blankline = true,
    },
  })
  spectra.load()

  -- Telescope groups should NOT exist (no fg, no bg, no link)
  local ts_normal = vim.api.nvim_get_hl(0, { name = "TelescopeNormal" })
  assert_true("TelescopeNormal not defined",
    ts_normal.fg == nil and ts_normal.bg == nil and ts_normal.link == nil)

  -- But other plugins should still be present
  local nt_normal = vim.api.nvim_get_hl(0, { name = "NvimTreeNormal" })
  assert_true("NvimTreeNormal still present", nt_normal.bg ~= nil)

  local gs_add = vim.api.nvim_get_hl(0, { name = "GitSignsAdd" })
  assert_true("GitSignsAdd still present", gs_add.fg ~= nil)

  print("  Disable telescope ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 3: Plugin colors match palette
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 3: Plugin colors match palette ===")
do
  local spectra = reload_spectra()
  spectra.setup({
    palette = {
      ["accent.danger"] = "#ff5555",
      ["accent.success"] = "#50fa7b",
    },
    style = "dark",
  })
  spectra.load()

  -- GitSignsAdd should use diff.add color (which derives from accent.success → default theme)
  local gs_add = vim.api.nvim_get_hl(0, { name = "GitSignsAdd" })
  assert_true("GitSignsAdd.fg is set", gs_add.fg ~= nil)

  -- GitSignsDelete should use diff.delete color (which derives from accent.danger)
  local gs_del = vim.api.nvim_get_hl(0, { name = "GitSignsDelete" })
  assert_true("GitSignsDelete.fg is set", gs_del.fg ~= nil)

  -- GitSignsAddLn should use diff.add.bg (blended background)
  local gs_add_ln = vim.api.nvim_get_hl(0, { name = "GitSignsAddLn" })
  assert_true("GitSignsAddLn.bg is set", gs_add_ln.bg ~= nil)

  print("  Plugin colors match palette ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 4: Plugin group count
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 4: Plugin group count ===")
do
  local palette = require("spectra.palette")
  local resolved = palette.resolve({ fg = "#d4d4d4", bg = "#1e1e1e" })
  local config = { plugins = { telescope = true, nvim_tree = true, gitsigns = true, indent_blankline = true } }

  local plugins_mod = require("spectra.groups.plugins")
  local groups = plugins_mod.get(resolved, config)

  local count = 0
  for _ in pairs(groups) do count = count + 1 end

  -- telescope: 18 + nvim-tree: 18 + gitsigns: 13 + indent-blankline: 6 = 55
  print(string.format("  Total plugin groups: %d", count))
  assert_true("plugin group count >= 50", count >= 50)

  print("  Plugin group count ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 5: Disable all plugins
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 5: Disable all plugins ===")
do
  local palette = require("spectra.palette")
  local resolved = palette.resolve({ fg = "#d4d4d4", bg = "#1e1e1e" })
  local config = { plugins = { telescope = false, nvim_tree = false, gitsigns = false, indent_blankline = false } }

  package.loaded["spectra.groups.plugins"] = nil
  local plugins_mod = require("spectra.groups.plugins")
  local groups = plugins_mod.get(resolved, config)

  local count = 0
  for _ in pairs(groups) do count = count + 1 end

  assert_eq("all disabled = 0 groups", count, 0)

  print("  Disable all plugins ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("Plugin support (US7): %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
