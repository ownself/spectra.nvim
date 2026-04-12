--- Integration test: validate six configuration tiers (T020).
--- Verifies that the palette resolves correctly at each tier:
---   Tier 1: 2-color (fg+bg only)
---   Tier 2: 4-color (partial accent)
---   Tier 3: 8-color (full accent)
---   Tier 4: 16-color (role layer)
---   Tier 5: 27-color (full layer)
---   Tier 6: 40+ color (variant layer)

local palette = require("spectra.palette")
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

local function assert_neq(label, a, b)
  if a ~= b then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — values should differ but both are '%s'", label, tostring(a)))
  end
end

local function assert_hex(label, value)
  if type(value) == "string" and value:match("^#%x%x%x%x%x%x$") then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — expected hex color, got '%s'", label, tostring(value)))
  end
end

local function count_resolved(resolved)
  local n = 0
  for _ in pairs(resolved) do n = n + 1 end
  return n
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 1: Minimal — only fg + bg (2 colors)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 1: Minimal (2 colors: fg + bg) ===")
do
  local user = { fg = "#e0e0e0", bg = "#1a1a2e" }
  local resolved = palette.resolve(user)
  local total = count_resolved(resolved)

  assert_eq("T1: fg preserved", resolved.fg, "#e0e0e0")
  assert_eq("T1: bg preserved", resolved.bg, "#1a1a2e")
  assert_eq("T1: total slots filled", total, 75)

  -- All syntax should fallback to fg (via accent→fg chain)
  assert_eq("T1: syntax.keyword = fg", resolved["syntax.keyword"], "#e0e0e0")
  assert_eq("T1: syntax.string = fg", resolved["syntax.string"], "#e0e0e0")
  assert_eq("T1: syntax.function = fg", resolved["syntax.function"], "#e0e0e0")
  assert_eq("T1: syntax.comment = fg (accent-skip)", resolved["syntax.comment"], "#e0e0e0")
  assert_eq("T1: syntax.type = fg (accent-skip)", resolved["syntax.type"], "#e0e0e0")
  assert_eq("T1: syntax.operator = fg (accent-skip)", resolved["syntax.operator"], "#e0e0e0")

  -- Accents should all be fg
  assert_eq("T1: accent.danger = fg", resolved["accent.danger"], "#e0e0e0")
  assert_eq("T1: accent.success = fg", resolved["accent.success"], "#e0e0e0")

  -- UI should be auto-derived from bg (not equal to bg)
  assert_hex("T1: ui.cursorline is hex", resolved["ui.cursorline"])
  assert_neq("T1: ui.cursorline != bg", resolved["ui.cursorline"], "#1a1a2e")
  assert_hex("T1: ui.statusline is hex", resolved["ui.statusline"])

  print(string.format("  Tier 1: all 75 slots filled from 2 user colors ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 2: Basic — 4 colors (fg + bg + 2 accents)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 2: Basic (4 colors: fg + bg + 2 accents) ===")
do
  local user = {
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    ["accent.danger"]  = "#ff5555",
    ["accent.success"] = "#50fa7b",
  }
  local resolved = palette.resolve(user)
  local total = count_resolved(resolved)

  assert_eq("T2: total slots filled", total, 75)
  assert_eq("T2: accent.danger preserved", resolved["accent.danger"], "#ff5555")
  assert_eq("T2: accent.success preserved", resolved["accent.success"], "#50fa7b")

  -- Roles that depend on provided accents should inherit
  assert_eq("T2: diag.error = accent.danger", resolved["diag.error"], "#ff5555")
  assert_eq("T2: syntax.string = accent.success", resolved["syntax.string"], "#50fa7b")
  assert_eq("T2: diff.add = accent.success", resolved["diff.add"], "#50fa7b")

  -- Missing accents should fallback to fg
  assert_eq("T2: accent.info = fg", resolved["accent.info"], "#d4d4d4")
  assert_eq("T2: accent.action = fg", resolved["accent.action"], "#d4d4d4")

  print(string.format("  Tier 2: partial accent, correct fallback ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 3: Accent — 8 colors (fg + bg + all 6 accents)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 3: Accent (8 colors: fg + bg + 6 accents) ===")
do
  local user = {
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    ["accent.danger"]  = "#f44747",
    ["accent.success"] = "#6a9955",
    ["accent.info"]    = "#4fc1ff",
    ["accent.caution"] = "#dcdcaa",
    ["accent.action"]  = "#4ec9b0",
    ["accent.control"] = "#c586c0",
  }
  local resolved = palette.resolve(user)

  -- Roles should derive from their parent accent
  assert_eq("T3: syntax.keyword = accent.control", resolved["syntax.keyword"], "#c586c0")
  assert_eq("T3: syntax.function = accent.action", resolved["syntax.function"], "#4ec9b0")
  assert_eq("T3: diag.error = accent.danger", resolved["diag.error"], "#f44747")
  assert_eq("T3: diag.warn = accent.caution", resolved["diag.warn"], "#dcdcaa")
  assert_eq("T3: diff.add = accent.success", resolved["diff.add"], "#6a9955")

  -- Accent-skip: these should be fg, not any accent
  assert_eq("T3: syntax.comment = fg (accent-skip)", resolved["syntax.comment"], "#d4d4d4")
  assert_eq("T3: syntax.type = fg (accent-skip)", resolved["syntax.type"], "#d4d4d4")
  assert_eq("T3: syntax.operator = fg (accent-skip)", resolved["syntax.operator"], "#d4d4d4")

  -- Full-layer slots should derive from role→accent chain
  assert_eq("T3: syntax.constant = accent.caution", resolved["syntax.constant"], "#dcdcaa")
  assert_eq("T3: syntax.identifier = accent.info", resolved["syntax.identifier"], "#4fc1ff")

  print(string.format("  Tier 3: all accents drive roles and full slots ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 4: Standard — 16 colors (role layer independent)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 4: Standard (16 colors: full role layer) ===")
do
  local user = {
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    -- accent
    ["accent.danger"]  = "#f44747",
    ["accent.success"] = "#6a9955",
    ["accent.info"]    = "#4fc1ff",
    ["accent.caution"] = "#dcdcaa",
    ["accent.action"]  = "#4ec9b0",
    ["accent.control"] = "#c586c0",
    -- role (override accent-derived defaults)
    ["syntax.keyword"]  = "#569cd6",
    ["syntax.string"]   = "#ce9178",
    ["syntax.function"] = "#dcdcaa",
    ["syntax.comment"]  = "#6a9955",
    ["syntax.type"]     = "#4ec9b0",
    ["diag.error"]      = "#f44747",
    ["diag.warn"]       = "#cca700",
    ["diff.add"]        = "#4b5632",
  }
  local resolved = palette.resolve(user)

  -- Roles should be user-provided, not accent-derived
  assert_eq("T4: syntax.keyword = user", resolved["syntax.keyword"], "#569cd6")
  assert_neq("T4: syntax.keyword != accent.control", resolved["syntax.keyword"], "#c586c0")
  assert_eq("T4: syntax.string = user", resolved["syntax.string"], "#ce9178")
  assert_eq("T4: diag.warn = user", resolved["diag.warn"], "#cca700")

  -- Full-layer slots still inherit from accent (not role)
  assert_eq("T4: syntax.constant = accent.caution", resolved["syntax.constant"], "#dcdcaa")

  print(string.format("  Tier 4: roles independent from accents ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 5: Full — 27 colors (all functional slots)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 5: Full (27 colors: complete functional layer) ===")
do
  local user = {
    fg = "#d4d4d4", bg = "#1e1e1e",
    -- accent (6)
    ["accent.danger"]  = "#f44747", ["accent.success"] = "#6a9955",
    ["accent.info"]    = "#4fc1ff", ["accent.caution"] = "#dcdcaa",
    ["accent.action"]  = "#4ec9b0", ["accent.control"] = "#c586c0",
    -- role (8)
    ["syntax.keyword"] = "#569cd6", ["syntax.string"] = "#ce9178",
    ["syntax.function"] = "#dcdcaa", ["syntax.comment"] = "#6a9955",
    ["syntax.type"] = "#4ec9b0", ["diag.error"] = "#f44747",
    ["diag.warn"] = "#cca700", ["diff.add"] = "#4b5632",
    -- full (11) — non-UI functional slots
    ["syntax.constant"]   = "#b5cea8",
    ["syntax.identifier"] = "#9cdcfe",
    ["syntax.operator"]   = "#d4d4d4",
    ["syntax.preproc"]    = "#c586c0",
    ["syntax.special"]    = "#d7ba7d",
    ["diag.hint"]         = "#5a9957",
    ["diag.info"]         = "#4fc1ff",
    ["diag.ok"]           = "#6a9955",
    ["diff.change"]       = "#0078d4",
    ["diff.delete"]       = "#f44747",
  }
  local resolved = palette.resolve(user)

  -- All user-provided should be preserved
  assert_eq("T5: syntax.constant = user", resolved["syntax.constant"], "#b5cea8")
  assert_eq("T5: syntax.identifier = user", resolved["syntax.identifier"], "#9cdcfe")
  assert_eq("T5: syntax.preproc = user", resolved["syntax.preproc"], "#c586c0")
  assert_eq("T5: diff.change = user", resolved["diff.change"], "#0078d4")
  assert_eq("T5: diag.hint = user", resolved["diag.hint"], "#5a9957")

  -- Variants should still fall back to their parent full-layer color
  assert_eq("T5: syntax.constant.builtin = syntax.constant", resolved["syntax.constant.builtin"], "#b5cea8")
  assert_eq("T5: syntax.preproc.include = syntax.preproc", resolved["syntax.preproc.include"], "#c586c0")

  print(string.format("  Tier 5: all functional slots independent ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 6: Refined — 40+ colors (variant layer customization)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 6: Refined (40+ colors: variant-level control) ===")
do
  local user = {
    fg = "#d4d4d4", bg = "#1e1e1e",
    -- accent (6)
    ["accent.danger"]  = "#f44747", ["accent.success"] = "#6a9955",
    ["accent.info"]    = "#4fc1ff", ["accent.caution"] = "#dcdcaa",
    ["accent.action"]  = "#4ec9b0", ["accent.control"] = "#c586c0",
    -- role (8)
    ["syntax.keyword"] = "#569cd6", ["syntax.string"] = "#ce9178",
    ["syntax.function"] = "#dcdcaa", ["syntax.comment"] = "#6a9955",
    ["syntax.type"] = "#4ec9b0", ["diag.error"] = "#f44747",
    ["diag.warn"] = "#cca700", ["diff.add"] = "#4b5632",
    -- full (11)
    ["syntax.constant"]   = "#b5cea8", ["syntax.identifier"] = "#9cdcfe",
    ["syntax.operator"]   = "#d4d4d4", ["syntax.preproc"] = "#c586c0",
    ["syntax.special"]    = "#d7ba7d", ["diag.hint"] = "#5a9957",
    ["diag.info"] = "#4fc1ff", ["diag.ok"] = "#6a9955",
    ["diff.change"] = "#0078d4", ["diff.delete"] = "#f44747",
    -- variant: syntax (14)
    ["syntax.comment.doc"]          = "#7ec699",
    ["syntax.constant.builtin"]     = "#c8e6c9",
    ["syntax.constant.macro"]       = "#a0c4a0",
    ["syntax.function.builtin"]     = "#eedd99",
    ["syntax.function.method"]      = "#ccbb77",
    ["syntax.identifier.member"]    = "#88ccee",
    ["syntax.identifier.parameter"] = "#77bbdd",
    ["syntax.preproc.include"]      = "#dd99cc",
    ["syntax.preproc.macro"]        = "#cc88bb",
    ["syntax.string.escape"]        = "#ee8866",
    ["syntax.string.special"]       = "#dd7755",
    ["syntax.type.builtin"]         = "#55ddbb",
    ["syntax.type.definition"]      = "#44ccaa",
    ["syntax.type.module"]          = "#33bb99",
  }
  local resolved = palette.resolve(user)
  local total = count_resolved(resolved)

  assert_eq("T6: total slots filled", total, 75)

  -- Variant overrides should be preserved
  assert_eq("T6: syntax.comment.doc = user variant", resolved["syntax.comment.doc"], "#7ec699")
  assert_eq("T6: syntax.function.method = user variant", resolved["syntax.function.method"], "#ccbb77")
  assert_eq("T6: syntax.type.builtin = user variant", resolved["syntax.type.builtin"], "#55ddbb")
  assert_eq("T6: syntax.string.escape = user variant", resolved["syntax.string.escape"], "#ee8866")
  assert_eq("T6: syntax.identifier.parameter = user variant", resolved["syntax.identifier.parameter"], "#77bbdd")

  -- Parent should still be user-provided, not promoted from variant
  assert_eq("T6: syntax.comment still = user parent", resolved["syntax.comment"], "#6a9955")
  assert_eq("T6: syntax.function still = user parent", resolved["syntax.function"], "#dcdcaa")

  print(string.format("  Tier 6: variant-level customization working ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Bonus: Variant promotion (variant without parent)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Bonus: Variant promotion ===")
do
  local user = {
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["syntax.function.method"] = "#aabbcc",
    -- syntax.function NOT provided — should be promoted from variant
  }
  local resolved = palette.resolve(user)

  assert_eq("VP: syntax.function promoted from variant", resolved["syntax.function"], "#aabbcc")
  assert_eq("VP: syntax.function.method preserved", resolved["syntax.function.method"], "#aabbcc")
  -- syntax.function.builtin should also get the promoted value
  assert_eq("VP: syntax.function.builtin = promoted parent", resolved["syntax.function.builtin"], "#aabbcc")

  print(string.format("  Variant promotion working correctly ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Bonus: Config validation (invalid keys/values)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Bonus: Config validation ===")
do
  -- Test that merge validates and removes bad entries
  local merged = config.merge({
    palette = {
      fg = "#d4d4d4",
      bg = "#1e1e1e",
      ["syntax.keyword"] = "#569cd6",
      -- Invalid key
      ["syntax.nonexistent"] = "#ffffff",
      -- Invalid value
      ["syntax.string"] = "not-a-color",
    },
    style = "dark",
  })

  assert_eq("CV: valid fg preserved", merged.palette.fg, "#d4d4d4")
  assert_eq("CV: valid keyword preserved", merged.palette["syntax.keyword"], "#569cd6")
  assert_eq("CV: invalid key removed", merged.palette["syntax.nonexistent"], nil)
  assert_eq("CV: invalid value removed", merged.palette["syntax.string"], nil)

  -- Invalid style
  local merged2 = config.merge({ style = "invalid" })
  assert_eq("CV: invalid style corrected to dark", merged2.style, "dark")

  print(string.format("  Config validation working correctly ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Bonus: on_colors and on_highlights callbacks
-- ═══════════════════════════════════════════════════════════════
print("\n=== Bonus: Callback registration ===")
do
  local colors_called = false
  local highlights_called = false

  local merged = config.merge({
    on_colors = function(c)
      colors_called = true
    end,
    on_highlights = function(h, c)
      highlights_called = true
    end,
  })

  assert_eq("CB: on_colors is function", type(merged.on_colors), "function")
  assert_eq("CB: on_highlights is function", type(merged.on_highlights), "function")

  -- Invoke to verify they work
  merged.on_colors({})
  merged.on_highlights({}, {})
  assert_eq("CB: on_colors was called", colors_called, true)
  assert_eq("CB: on_highlights was called", highlights_called, true)

  print(string.format("  Callback registration working correctly ✓"))
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("Six-tier validation: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
