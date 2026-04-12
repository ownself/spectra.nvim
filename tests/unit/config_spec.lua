--- Unit tests for spectra.config module (T037).
--- Tests: config merge logic, #RRGGBB validation, invalid slot path warnings.

local config = require("spectra.config")

local pass_count = 0
local fail_count = 0

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

-- ═══════════════════════════════════════════════════════════════
-- validate_hex
-- ═══════════════════════════════════════════════════════════════
print("\n=== validate_hex ===")
do
  assert_eq("valid #d4d4d4", config.validate_hex("#d4d4d4"), true)
  assert_eq("valid #000000", config.validate_hex("#000000"), true)
  assert_eq("valid #ffffff", config.validate_hex("#ffffff"), true)
  assert_eq("valid #AABBCC", config.validate_hex("#AABBCC"), true)
  assert_eq("invalid: no #", config.validate_hex("d4d4d4"), false)
  assert_eq("invalid: short", config.validate_hex("#d4d"), false)
  assert_eq("invalid: name", config.validate_hex("red"), false)
  assert_eq("invalid: empty", config.validate_hex(""), false)
  assert_eq("invalid: number", config.validate_hex(123), false)
  assert_eq("invalid: nil", config.validate_hex(nil), false)
  assert_eq("invalid: rgb()", config.validate_hex("rgb(0,0,0)"), false)
  assert_eq("invalid: 8-digit", config.validate_hex("#ff000000"), false)
end

-- ═══════════════════════════════════════════════════════════════
-- validate_slot_path
-- ═══════════════════════════════════════════════════════════════
print("\n=== validate_slot_path ===")
do
  assert_eq("valid: fg", config.validate_slot_path("fg"), true)
  assert_eq("valid: bg", config.validate_slot_path("bg"), true)
  assert_eq("valid: accent.danger", config.validate_slot_path("accent.danger"), true)
  assert_eq("valid: syntax.function.method", config.validate_slot_path("syntax.function.method"), true)
  assert_eq("valid: ui.float.bg", config.validate_slot_path("ui.float.bg"), true)
  assert_eq("invalid: unknown", config.validate_slot_path("unknown"), false)
  assert_eq("invalid: accent.red", config.validate_slot_path("accent.red"), false)
  assert_eq("invalid: empty", config.validate_slot_path(""), false)
end

-- ═══════════════════════════════════════════════════════════════
-- VALID_SLOTS count
-- ═══════════════════════════════════════════════════════════════
print("\n=== VALID_SLOTS count ===")
do
  local n = 0
  for _ in pairs(config.VALID_SLOTS) do n = n + 1 end
  assert_eq("75 valid slots", n, 75)
end

-- ═══════════════════════════════════════════════════════════════
-- suggest_slot
-- ═══════════════════════════════════════════════════════════════
print("\n=== suggest_slot ===")
do
  local s1 = config.suggest_slot("syntax.keywrod")
  assert_true("suggest for typo", s1 ~= nil)

  local s2 = config.suggest_slot("accent.denger")
  assert_true("suggest for accent typo", s2 ~= nil)

  local s3 = config.suggest_slot("zzzzzzzzzzz")
  assert_eq("no suggest for gibberish", s3, nil)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: defaults
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge defaults ===")
do
  local m = config.merge({})
  assert_eq("default style", m.style, "dark")
  assert_true("default palette is table", type(m.palette) == "table")
  assert_true("default plugins is table", type(m.plugins) == "table")
  assert_eq("default telescope", m.plugins.telescope, true)
  assert_eq("default on_colors nil", m.on_colors, nil)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: user overrides
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge user overrides ===")
do
  local m = config.merge({
    style = "light",
    palette = { fg = "#333333", bg = "#ffffff" },
    plugins = { telescope = false },
  })
  assert_eq("user style", m.style, "light")
  assert_eq("user fg", m.palette.fg, "#333333")
  assert_eq("user telescope off", m.plugins.telescope, false)
  -- Other plugins should still be default
  assert_eq("gitsigns still on", m.plugins.gitsigns, true)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: invalid palette entries removed
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge removes invalid entries ===")
do
  local m = config.merge({
    palette = {
      fg = "#d4d4d4",
      ["syntax.keyword"] = "#569cd6",
      ["syntax.nonexistent"] = "#ffffff",  -- bad key
      ["syntax.string"] = "not-hex",       -- bad value
    },
  })
  assert_eq("valid fg kept", m.palette.fg, "#d4d4d4")
  assert_eq("valid keyword kept", m.palette["syntax.keyword"], "#569cd6")
  assert_eq("bad key removed", m.palette["syntax.nonexistent"], nil)
  assert_eq("bad value removed", m.palette["syntax.string"], nil)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: invalid style corrected
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge invalid style ===")
do
  local m = config.merge({ style = "invalid" })
  assert_eq("bad style → dark", m.style, "dark")

  local m2 = config.merge({ style = "auto" })
  assert_eq("auto is valid", m2.style, "auto")
end

-- ═══════════════════════════════════════════════════════════════
-- merge: dark/light sub-palettes validated
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge dark/light validation ===")
do
  local m = config.merge({
    dark = {
      ["syntax.keyword"] = "#569cd6",
      ["bad.path"] = "#ffffff",
    },
    light = {
      ["syntax.string"] = "#a31515",
      ["syntax.keyword"] = "invalid",
    },
  })
  assert_eq("dark valid kept", m.dark["syntax.keyword"], "#569cd6")
  assert_eq("dark invalid removed", m.dark["bad.path"], nil)
  assert_eq("light valid kept", m.light["syntax.string"], "#a31515")
  assert_eq("light invalid value removed", m.light["syntax.keyword"], nil)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: callbacks preserved
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge callbacks ===")
do
  local fn1 = function() end
  local fn2 = function() end
  local m = config.merge({
    on_colors = fn1,
    on_highlights = fn2,
  })
  assert_eq("on_colors preserved", m.on_colors, fn1)
  assert_eq("on_highlights preserved", m.on_highlights, fn2)
end

-- ═══════════════════════════════════════════════════════════════
-- merge: deep extend preserves unrelated fields
-- ═══════════════════════════════════════════════════════════════
print("\n=== merge deep extend ===")
do
  local m = config.merge({
    plugins = { telescope = false },
  })
  -- Other plugin defaults should still be present
  assert_eq("nvim_tree default", m.plugins.nvim_tree, true)
  assert_eq("gitsigns default", m.plugins.gitsigns, true)
  assert_eq("indent_blankline default", m.plugins.indent_blankline, true)
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("config_spec: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
