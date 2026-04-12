--- Unit tests for spectra.palette module (T036).
--- Tests: 6 tier fallback resolution, accent-skip rules, variant promotion.

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
    print(string.format("  FAIL: %s — should differ but both '%s'", label, tostring(a)))
  end
end

local function assert_hex(label, value)
  if type(value) == "string" and value:match("^#%x%x%x%x%x%x$") then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — expected hex, got '%s'", label, tostring(value)))
  end
end

local function count(t)
  local n = 0
  for _ in pairs(t) do n = n + 1 end
  return n
end

-- ═══════════════════════════════════════════════════════════════
-- Slot metadata
-- ═══════════════════════════════════════════════════════════════
print("\n=== Slot metadata ===")
assert_eq("75 slots defined", #palette.slots, 75)
assert_eq("slot index built", palette._slot_index["fg"] ~= nil, true)
assert_eq("slot index correct", palette._slot_index["syntax.keyword"].layer, 2)

-- ═══════════════════════════════════════════════════════════════
-- Tier 1: Minimal (2 colors)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 1: 2 colors ===")
do
  local r = palette.resolve({ fg = "#aabbcc", bg = "#112233" })
  assert_eq("T1: total slots", count(r), 75)
  assert_eq("T1: fg", r.fg, "#aabbcc")
  assert_eq("T1: bg", r.bg, "#112233")
  -- All non-UI should fallback to fg
  assert_eq("T1: accent.danger = fg", r["accent.danger"], "#aabbcc")
  assert_eq("T1: syntax.keyword = fg", r["syntax.keyword"], "#aabbcc")
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 2: 4 colors (partial accent)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 2: 4 colors ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.danger"] = "#ff0000", ["accent.success"] = "#00ff00",
  })
  assert_eq("T2: diag.error = accent.danger", r["diag.error"], "#ff0000")
  assert_eq("T2: syntax.string = accent.success", r["syntax.string"], "#00ff00")
  assert_eq("T2: accent.info = fg (missing)", r["accent.info"], "#d4d4d4")
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 3: 8 colors (full accent)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 3: 8 colors ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.danger"] = "#f44747", ["accent.success"] = "#6a9955",
    ["accent.info"] = "#4fc1ff", ["accent.caution"] = "#dcdcaa",
    ["accent.action"] = "#4ec9b0", ["accent.control"] = "#c586c0",
  })
  assert_eq("T3: syntax.keyword = accent.control", r["syntax.keyword"], "#c586c0")
  assert_eq("T3: syntax.function = accent.action", r["syntax.function"], "#4ec9b0")
  assert_eq("T3: diag.error = accent.danger", r["diag.error"], "#f44747")
  assert_eq("T3: syntax.constant = accent.caution", r["syntax.constant"], "#dcdcaa")
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 4: 16 colors (role)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 4: 16 colors ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.danger"] = "#f44747", ["accent.success"] = "#6a9955",
    ["accent.info"] = "#4fc1ff", ["accent.caution"] = "#dcdcaa",
    ["accent.action"] = "#4ec9b0", ["accent.control"] = "#c586c0",
    ["syntax.keyword"] = "#569cd6", ["syntax.string"] = "#ce9178",
    ["syntax.function"] = "#dcdcaa", ["syntax.comment"] = "#6a9955",
    ["syntax.type"] = "#4ec9b0", ["diag.error"] = "#f44747",
    ["diag.warn"] = "#cca700", ["diff.add"] = "#4b5632",
  })
  assert_eq("T4: keyword independent", r["syntax.keyword"], "#569cd6")
  assert_neq("T4: keyword != accent.control", r["syntax.keyword"], "#c586c0")
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 5: 27 colors (full)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 5: 27 colors ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.danger"] = "#f44747", ["accent.success"] = "#6a9955",
    ["accent.info"] = "#4fc1ff", ["accent.caution"] = "#dcdcaa",
    ["accent.action"] = "#4ec9b0", ["accent.control"] = "#c586c0",
    ["syntax.keyword"] = "#569cd6", ["syntax.string"] = "#ce9178",
    ["syntax.function"] = "#dcdcaa", ["syntax.comment"] = "#6a9955",
    ["syntax.type"] = "#4ec9b0", ["diag.error"] = "#f44747",
    ["diag.warn"] = "#cca700", ["diff.add"] = "#4b5632",
    ["syntax.constant"] = "#b5cea8", ["syntax.identifier"] = "#9cdcfe",
    ["syntax.operator"] = "#d4d4d4", ["syntax.preproc"] = "#c586c0",
    ["syntax.special"] = "#d7ba7d", ["diag.hint"] = "#5a9957",
    ["diag.info"] = "#4fc1ff", ["diag.ok"] = "#6a9955",
    ["diff.change"] = "#0078d4", ["diff.delete"] = "#f44747",
  })
  assert_eq("T5: syntax.constant", r["syntax.constant"], "#b5cea8")
  assert_eq("T5: variant inherits parent", r["syntax.constant.builtin"], "#b5cea8")
end

-- ═══════════════════════════════════════════════════════════════
-- Tier 6: 40+ colors (variant)
-- ═══════════════════════════════════════════════════════════════
print("\n=== Tier 6: 40+ colors ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["syntax.function"] = "#dcdcaa",
    ["syntax.function.method"] = "#ccbb77",
    ["syntax.function.builtin"] = "#eedd99",
  })
  assert_eq("T6: variant preserved", r["syntax.function.method"], "#ccbb77")
  assert_eq("T6: parent preserved", r["syntax.function"], "#dcdcaa")
end

-- ═══════════════════════════════════════════════════════════════
-- Accent-skip rules
-- ═══════════════════════════════════════════════════════════════
print("\n=== Accent-skip ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.control"] = "#c586c0",
    ["accent.info"] = "#4fc1ff",
  })
  -- comment, type, operator should skip accent → fallback directly to fg
  assert_eq("skip: syntax.comment = fg", r["syntax.comment"], "#d4d4d4")
  assert_eq("skip: syntax.type = fg", r["syntax.type"], "#d4d4d4")
  assert_eq("skip: syntax.operator = fg", r["syntax.operator"], "#d4d4d4")
  -- But keyword should use accent.control
  assert_eq("no-skip: syntax.keyword = accent.control", r["syntax.keyword"], "#c586c0")
end

-- ═══════════════════════════════════════════════════════════════
-- Variant promotion
-- ═══════════════════════════════════════════════════════════════
print("\n=== Variant promotion ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["syntax.function.method"] = "#aabbcc",
    -- syntax.function NOT provided
  })
  assert_eq("promote: syntax.function = variant", r["syntax.function"], "#aabbcc")
  assert_eq("promote: syntax.function.method", r["syntax.function.method"], "#aabbcc")
  assert_eq("promote: syntax.function.builtin = promoted", r["syntax.function.builtin"], "#aabbcc")
end

-- ═══════════════════════════════════════════════════════════════
-- UI auto-derivation
-- ═══════════════════════════════════════════════════════════════
print("\n=== UI auto-derivation ===")
do
  local r = palette.resolve({ fg = "#d4d4d4", bg = "#1e1e1e" })
  assert_hex("ui.cursorline", r["ui.cursorline"])
  assert_hex("ui.float", r["ui.float"])
  assert_hex("ui.pmenu", r["ui.pmenu"])
  assert_hex("ui.statusline", r["ui.statusline"])
  assert_hex("ui.visual", r["ui.visual"])
  assert_hex("ui.search", r["ui.search"])
  assert_hex("ui.linenr", r["ui.linenr"])
  -- All should differ from bg
  assert_neq("cursorline != bg", r["ui.cursorline"], "#1e1e1e")
  assert_neq("statusline != bg", r["ui.statusline"], "#1e1e1e")
end

-- ═══════════════════════════════════════════════════════════════
-- Diag/diff variant auto-derivation
-- ═══════════════════════════════════════════════════════════════
print("\n=== Diag/diff variant derivation ===")
do
  local r = palette.resolve({
    fg = "#d4d4d4", bg = "#1e1e1e",
    ["accent.danger"] = "#f44747",
  })
  -- .bg should be a tinted bg, not the raw diag color
  assert_hex("diag.error.bg", r["diag.error.bg"])
  assert_neq("diag.error.bg != diag.error", r["diag.error.bg"], r["diag.error"])
  assert_neq("diag.error.bg != bg", r["diag.error.bg"], r.bg)

  -- .subtle should be a muted blend
  assert_hex("diag.error.subtle", r["diag.error.subtle"])
  assert_neq("diag.error.subtle != diag.error", r["diag.error.subtle"], r["diag.error"])
end

-- ═══════════════════════════════════════════════════════════════
-- palette.get helper
-- ═══════════════════════════════════════════════════════════════
print("\n=== palette.get ===")
do
  local r = palette.resolve({ fg = "#aabbcc", bg = "#112233" })
  assert_eq("get existing", palette.get(r, "fg"), "#aabbcc")
  assert_eq("get missing returns fg", palette.get(r, "nonexistent"), "#aabbcc")
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("palette_spec: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
