--- Integration test: dot-separated path validation (T021/T022 — US3).
--- Verifies:
---   (1) Dot-separated palette paths correctly map to color slots
---   (2) Layer 4 variant paths (e.g., syntax.function.method) correctly parse
---   (3) Invalid paths produce warnings but don't break other config loading

local config = require("spectra.config")
local palette = require("spectra.palette")

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

local function assert_neq(label, a, b)
  if a ~= b then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — values should differ but both are '%s'", label, tostring(a)))
  end
end

-- ═══════════════════════════════════════════════════════════════
-- Test 1: Valid dot-separated paths correctly recognized
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: Valid path recognition ===")
do
  -- Layer 0
  assert_eq("valid: fg", config.validate_slot_path("fg"), true)
  assert_eq("valid: bg", config.validate_slot_path("bg"), true)

  -- Layer 1 (dot-separated accent)
  assert_eq("valid: accent.danger", config.validate_slot_path("accent.danger"), true)
  assert_eq("valid: accent.success", config.validate_slot_path("accent.success"), true)
  assert_eq("valid: accent.info", config.validate_slot_path("accent.info"), true)
  assert_eq("valid: accent.caution", config.validate_slot_path("accent.caution"), true)
  assert_eq("valid: accent.action", config.validate_slot_path("accent.action"), true)
  assert_eq("valid: accent.control", config.validate_slot_path("accent.control"), true)

  -- Layer 2 (dot-separated role)
  assert_eq("valid: syntax.keyword", config.validate_slot_path("syntax.keyword"), true)
  assert_eq("valid: syntax.string", config.validate_slot_path("syntax.string"), true)
  assert_eq("valid: syntax.comment", config.validate_slot_path("syntax.comment"), true)
  assert_eq("valid: diag.error", config.validate_slot_path("diag.error"), true)
  assert_eq("valid: diff.add", config.validate_slot_path("diff.add"), true)

  -- Layer 3 (dot-separated full)
  assert_eq("valid: syntax.constant", config.validate_slot_path("syntax.constant"), true)
  assert_eq("valid: ui.cursorline", config.validate_slot_path("ui.cursorline"), true)
  assert_eq("valid: ui.statusline", config.validate_slot_path("ui.statusline"), true)

  -- Layer 4 (deep dot-separated variant)
  assert_eq("valid: syntax.function.method", config.validate_slot_path("syntax.function.method"), true)
  assert_eq("valid: syntax.function.builtin", config.validate_slot_path("syntax.function.builtin"), true)
  assert_eq("valid: syntax.type.module", config.validate_slot_path("syntax.type.module"), true)
  assert_eq("valid: syntax.string.escape", config.validate_slot_path("syntax.string.escape"), true)
  assert_eq("valid: diag.error.bg", config.validate_slot_path("diag.error.bg"), true)
  assert_eq("valid: diag.error.subtle", config.validate_slot_path("diag.error.subtle"), true)
  assert_eq("valid: ui.float.bg", config.validate_slot_path("ui.float.bg"), true)
  assert_eq("valid: diff.add.bg", config.validate_slot_path("diff.add.bg"), true)

  print("  Valid path recognition ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 2: Invalid paths rejected
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: Invalid path rejection ===")
do
  assert_eq("invalid: syntax.nonexistent", config.validate_slot_path("syntax.nonexistent"), false)
  assert_eq("invalid: accent.red", config.validate_slot_path("accent.red"), false)
  assert_eq("invalid: ui.sidebar", config.validate_slot_path("ui.sidebar"), false)
  assert_eq("invalid: color.primary", config.validate_slot_path("color.primary"), false)
  assert_eq("invalid: empty string", config.validate_slot_path(""), false)
  assert_eq("invalid: just a word", config.validate_slot_path("keyword"), false)
  assert_eq("invalid: underscore style", config.validate_slot_path("syntax_keyword"), false)

  print("  Invalid path rejection ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 3: Typo suggestions
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 3: Typo suggestions ===")
do
  -- Close matches should get suggestions
  local suggestion = config.suggest_slot("syntax.keywrod")
  assert_neq("suggest for 'syntax.keywrod'", suggestion, nil)

  local suggestion2 = config.suggest_slot("accent.denger")
  assert_neq("suggest for 'accent.denger'", suggestion2, nil)

  -- Completely unrelated should get nil
  local suggestion3 = config.suggest_slot("zzzzzzzzzzz")
  assert_eq("no suggest for 'zzzzzzzzzzz'", suggestion3, nil)

  print("  Typo suggestions ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 4: Config merge validates and cleans palette
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 4: Config merge validation ===")
do
  local merged = config.merge({
    palette = {
      -- Valid entries
      fg = "#e0e0e0",
      bg = "#1a1a2e",
      ["syntax.keyword"] = "#569cd6",
      ["syntax.function.method"] = "#ccbb77",
      ["accent.danger"] = "#ff5555",
      -- Invalid key (should be removed with warning)
      ["syntax.nonexistent"] = "#ffffff",
      -- Invalid value (should be removed with warning)
      ["syntax.string"] = "red",
      -- Another invalid key
      ["accent.red"] = "#ff0000",
    },
  })

  -- Valid entries preserved
  assert_eq("merge: fg preserved", merged.palette.fg, "#e0e0e0")
  assert_eq("merge: bg preserved", merged.palette.bg, "#1a1a2e")
  assert_eq("merge: syntax.keyword preserved", merged.palette["syntax.keyword"], "#569cd6")
  assert_eq("merge: syntax.function.method preserved", merged.palette["syntax.function.method"], "#ccbb77")
  assert_eq("merge: accent.danger preserved", merged.palette["accent.danger"], "#ff5555")

  -- Invalid entries removed
  assert_eq("merge: syntax.nonexistent removed", merged.palette["syntax.nonexistent"], nil)
  assert_eq("merge: syntax.string (bad value) removed", merged.palette["syntax.string"], nil)
  assert_eq("merge: accent.red removed", merged.palette["accent.red"], nil)

  print("  Config merge validation ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 5: Valid paths resolve correctly through palette engine
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 5: Path → palette resolution ===")
do
  local resolved = palette.resolve({
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    ["syntax.keyword"] = "#569cd6",
    ["syntax.function.method"] = "#ccbb77",
    ["syntax.function.builtin"] = "#eedd99",
  })

  -- Direct assignment
  assert_eq("resolve: syntax.keyword", resolved["syntax.keyword"], "#569cd6")
  assert_eq("resolve: syntax.function.method", resolved["syntax.function.method"], "#ccbb77")
  assert_eq("resolve: syntax.function.builtin", resolved["syntax.function.builtin"], "#eedd99")

  -- Variant promotion: syntax.function should get promoted from syntax.function.method
  -- since user didn't provide syntax.function directly (but first variant seen wins)
  assert_neq("resolve: syntax.function promoted", resolved["syntax.function"], nil)

  print("  Path → palette resolution ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 6: Dark/light palette path validation
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 6: Dark/light palette validation ===")
do
  local merged = config.merge({
    dark = {
      ["syntax.keyword"] = "#569cd6",
      ["syntax.invalid"] = "#ffffff",  -- invalid key
    },
    light = {
      ["syntax.string"] = "#a31515",
      ["accent.fake"] = "#000000",  -- invalid key
    },
  })

  assert_eq("dark: valid key preserved", merged.dark["syntax.keyword"], "#569cd6")
  assert_eq("dark: invalid key removed", merged.dark["syntax.invalid"], nil)
  assert_eq("light: valid key preserved", merged.light["syntax.string"], "#a31515")
  assert_eq("light: invalid key removed", merged.light["accent.fake"], nil)

  print("  Dark/light palette validation ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 7: Total valid slots count matches 75
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 7: Valid slots count ===")
do
  local count = 0
  for _ in pairs(config.VALID_SLOTS) do
    count = count + 1
  end
  assert_eq("total valid slots", count, 75)

  -- Also check palette.slots count
  assert_eq("total palette.slots", #palette.slots, 75)

  print("  Valid slots count ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("Path validation (US3): %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
