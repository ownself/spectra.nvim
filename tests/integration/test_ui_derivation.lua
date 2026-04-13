--- Integration test: UI color auto-derivation (T026/T027 — US4).
--- Verifies:
---   (1) Dark bg: UI areas visually distinguishable (CursorLine/Float/Pmenu/StatusLine/Visual)
---   (2) Light bg: derivation direction reversed correctly
---   (3) Extreme values: pure black #000000 and pure white #ffffff don't overflow

local palette = require("spectra.palette")
local colors = require("spectra.colors")

local pass_count = 0
local fail_count = 0

local function assert_true(label, cond)
  if cond then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s", label))
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

local function get_lightness(hex)
  local r, g, b = colors.hex_to_rgb(hex)
  local _, _, l = colors.rgb_to_hsl(r, g, b)
  return l
end

local function all_distinct(label, values)
  -- Check that all values are distinct from each other
  local seen = {}
  local dupes = {}
  for name, val in pairs(values) do
    if seen[val] then
      table.insert(dupes, string.format("%s = %s = %s", name, seen[val], val))
    end
    seen[val] = name
  end
  if #dupes == 0 then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — duplicates: %s", label, table.concat(dupes, ", ")))
  end
end

-- ═══════════════════════════════════════════════════════════════
-- Test 1: Dark theme UI derivation
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 1: Dark theme UI derivation ===")
do
  local resolved = palette.resolve({
    fg = "#d4d4d4",
    bg = "#1e1e1e",
  })

  -- All UI slots should be valid hex
  assert_hex("dark: ui.cursorline", resolved["ui.cursorline"])
  assert_hex("dark: ui.float", resolved["ui.float"])
  assert_hex("dark: ui.pmenu", resolved["ui.pmenu"])
  assert_hex("dark: ui.statusline", resolved["ui.statusline"])
  assert_hex("dark: ui.visual", resolved["ui.visual"])
  assert_hex("dark: ui.search", resolved["ui.search"])
  assert_hex("dark: ui.linenr", resolved["ui.linenr"])

  -- All UI bg colors should be LIGHTER than bg (dark theme shifts up)
  local bg_l = get_lightness(resolved.bg)
  assert_true("dark: cursorline > bg lightness",
    get_lightness(resolved["ui.cursorline"]) > bg_l)
  assert_true("dark: float > bg lightness",
    get_lightness(resolved["ui.float"]) > bg_l)
  assert_true("dark: pmenu > bg lightness",
    get_lightness(resolved["ui.pmenu"]) > bg_l)
  assert_true("dark: statusline > bg lightness",
    get_lightness(resolved["ui.statusline"]) > bg_l)
  assert_true("dark: visual > bg lightness",
    get_lightness(resolved["ui.visual"]) > bg_l)

  -- Visual hierarchy: statusline < cursorline < float (statusline is subtler than cursorline)
  local cl_l = get_lightness(resolved["ui.cursorline"])
  local fl_l = get_lightness(resolved["ui.float"])
  local sl_l = get_lightness(resolved["ui.statusline"])
  assert_true("dark: cursorline < float lightness", cl_l < fl_l)
  assert_true("dark: statusline < cursorline lightness", sl_l < cl_l)
  assert_true("dark: statusline < float lightness", sl_l < fl_l)

  -- All main UI areas should be distinct from each other
  all_distinct("dark: UI areas distinct", {
    bg = resolved.bg,
    cursorline = resolved["ui.cursorline"],
    float = resolved["ui.float"],
    statusline = resolved["ui.statusline"],
    visual = resolved["ui.visual"],
  })

  -- LineNr should be dimmer (lower contrast) than fg
  local fg_l = get_lightness(resolved.fg)
  local ln_l = get_lightness(resolved["ui.linenr"])
  assert_true("dark: linenr closer to 0.5 than fg",
    math.abs(ln_l - 0.5) < math.abs(fg_l - 0.5))

  print("  Dark theme UI derivation ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 2: Light theme UI derivation
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 2: Light theme UI derivation ===")
do
  local resolved = palette.resolve({
    fg = "#333333",
    bg = "#ffffff",
  })

  assert_hex("light: ui.cursorline", resolved["ui.cursorline"])
  assert_hex("light: ui.float", resolved["ui.float"])
  assert_hex("light: ui.statusline", resolved["ui.statusline"])

  -- All UI bg colors should be DARKER than bg (light theme shifts down)
  local bg_l = get_lightness(resolved.bg)
  assert_true("light: cursorline < bg lightness",
    get_lightness(resolved["ui.cursorline"]) < bg_l)
  assert_true("light: float < bg lightness",
    get_lightness(resolved["ui.float"]) < bg_l)
  assert_true("light: statusline < bg lightness",
    get_lightness(resolved["ui.statusline"]) < bg_l)
  assert_true("light: visual < bg lightness",
    get_lightness(resolved["ui.visual"]) < bg_l)

  -- Visual hierarchy: statusline > cursorline > float (statusline is subtler than cursorline)
  local cl_l = get_lightness(resolved["ui.cursorline"])
  local fl_l = get_lightness(resolved["ui.float"])
  local sl_l = get_lightness(resolved["ui.statusline"])
  assert_true("light: cursorline > float lightness", cl_l > fl_l)
  assert_true("light: statusline > cursorline lightness", sl_l > cl_l)
  assert_true("light: cursorline > float lightness (repeat order)", cl_l > fl_l)

  -- All distinct
  all_distinct("light: UI areas distinct", {
    bg = resolved.bg,
    cursorline = resolved["ui.cursorline"],
    float = resolved["ui.float"],
    statusline = resolved["ui.statusline"],
    visual = resolved["ui.visual"],
  })

  print("  Light theme UI derivation ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 3: Extreme dark — pure black #000000
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 3: Extreme dark (pure black bg) ===")
do
  local resolved = palette.resolve({
    fg = "#ffffff",
    bg = "#000000",
  })

  -- All should still be valid hex (no NaN, no overflow)
  assert_hex("black: ui.cursorline", resolved["ui.cursorline"])
  assert_hex("black: ui.float", resolved["ui.float"])
  assert_hex("black: ui.pmenu", resolved["ui.pmenu"])
  assert_hex("black: ui.statusline", resolved["ui.statusline"])
  assert_hex("black: ui.visual", resolved["ui.visual"])
  assert_hex("black: ui.linenr", resolved["ui.linenr"])

  -- CursorLine should be slightly lighter than pure black
  assert_true("black: cursorline > #000000",
    get_lightness(resolved["ui.cursorline"]) > 0)

  -- StatusLine should still be lighter than pure black
  assert_true("black: statusline lighter than pure black",
    get_lightness(resolved["ui.statusline"]) > 0)

  print("  Extreme dark ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 4: Extreme light — pure white #ffffff
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 4: Extreme light (pure white bg) ===")
do
  local resolved = palette.resolve({
    fg = "#000000",
    bg = "#ffffff",
  })

  assert_hex("white: ui.cursorline", resolved["ui.cursorline"])
  assert_hex("white: ui.float", resolved["ui.float"])
  assert_hex("white: ui.statusline", resolved["ui.statusline"])
  assert_hex("white: ui.visual", resolved["ui.visual"])
  assert_hex("white: ui.linenr", resolved["ui.linenr"])

  -- CursorLine should be slightly darker than pure white
  assert_true("white: cursorline < 1.0 lightness",
    get_lightness(resolved["ui.cursorline"]) < 1)

  -- StatusLine should still be darker than pure white
  assert_true("white: statusline darker than pure white",
    get_lightness(resolved["ui.statusline"]) < 1)

  print("  Extreme light ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 5: Variant UI slots derived correctly
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 5: UI variant slots ===")
do
  local resolved = palette.resolve({
    fg = "#d4d4d4",
    bg = "#1e1e1e",
  })

  -- .bg variants should be slightly shifted from parent
  assert_hex("variant: ui.float.bg", resolved["ui.float.bg"])
  assert_hex("variant: ui.pmenu.bg", resolved["ui.pmenu.bg"])
  assert_hex("variant: ui.search.bg", resolved["ui.search.bg"])
  assert_hex("variant: ui.statusline.bg", resolved["ui.statusline.bg"])
  assert_hex("variant: ui.visual.bg", resolved["ui.visual.bg"])

  -- .subtle variants should be muted
  assert_hex("variant: ui.float.subtle", resolved["ui.float.subtle"])
  assert_hex("variant: ui.pmenu.subtle", resolved["ui.pmenu.subtle"])

  -- .bg should differ from parent
  assert_true("variant: float.bg != float",
    resolved["ui.float.bg"] ~= resolved["ui.float"])
  assert_true("variant: pmenu.bg != pmenu",
    resolved["ui.pmenu.bg"] ~= resolved["ui.pmenu"])

  print("  UI variant slots ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Test 6: Diag/diff variant slots derived correctly
-- ═══════════════════════════════════════════════════════════════
print("\n=== Test 6: Diag/diff variant slots ===")
do
  local resolved = palette.resolve({
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    ["accent.danger"] = "#f44747",
    ["accent.success"] = "#6a9955",
  })

  -- .bg variants: blend diagnostic color with bg (low opacity background tint)
  assert_hex("variant: diag.error.bg", resolved["diag.error.bg"])
  assert_hex("variant: diag.warn.bg", resolved["diag.warn.bg"])
  assert_hex("variant: diff.add.bg", resolved["diff.add.bg"])

  -- .subtle variants: blend with fg (muted version)
  assert_hex("variant: diag.error.subtle", resolved["diag.error.subtle"])

  -- .bg should be close to bg (low opacity tint), not close to the diag color
  local bg_l = get_lightness(resolved.bg)
  local err_bg_l = get_lightness(resolved["diag.error.bg"])
  local err_l = get_lightness(resolved["diag.error"])
  assert_true("variant: diag.error.bg closer to bg than diag.error",
    math.abs(err_bg_l - bg_l) < math.abs(err_l - bg_l))

  print("  Diag/diff variant slots ✓")
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("UI derivation (US4): %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
