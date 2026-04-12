--- Unit tests for spectra.colors module (T035).
--- Tests: hex↔rgb↔hsl conversion precision, shift/invert/mute computation,
--- boundary values (#000000, #ffffff), and edge cases.

local colors = require("spectra.colors")

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

local function assert_near(label, got, expected, tolerance)
  tolerance = tolerance or 0.01
  if math.abs(got - expected) <= tolerance then
    pass_count = pass_count + 1
  else
    fail_count = fail_count + 1
    print(string.format("  FAIL: %s — expected ~%s, got %s (tol=%s)", label, tostring(expected), tostring(got), tostring(tolerance)))
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
-- hex_to_rgb
-- ═══════════════════════════════════════════════════════════════
print("\n=== hex_to_rgb ===")
do
  local r, g, b = colors.hex_to_rgb("#000000")
  assert_near("black r", r, 0)
  assert_near("black g", g, 0)
  assert_near("black b", b, 0)

  r, g, b = colors.hex_to_rgb("#ffffff")
  assert_near("white r", r, 1)
  assert_near("white g", g, 1)
  assert_near("white b", b, 1)

  r, g, b = colors.hex_to_rgb("#ff0000")
  assert_near("red r", r, 1)
  assert_near("red g", g, 0)
  assert_near("red b", b, 0)

  r, g, b = colors.hex_to_rgb("#808080")
  assert_near("gray r", r, 0.502, 0.01)
  assert_near("gray g", g, 0.502, 0.01)
  assert_near("gray b", b, 0.502, 0.01)
end

-- ═══════════════════════════════════════════════════════════════
-- rgb_to_hex
-- ═══════════════════════════════════════════════════════════════
print("\n=== rgb_to_hex ===")
do
  assert_eq("black", colors.rgb_to_hex(0, 0, 0), "#000000")
  assert_eq("white", colors.rgb_to_hex(1, 1, 1), "#ffffff")
  assert_eq("red", colors.rgb_to_hex(1, 0, 0), "#ff0000")
  assert_eq("green", colors.rgb_to_hex(0, 1, 0), "#00ff00")
  assert_eq("blue", colors.rgb_to_hex(0, 0, 1), "#0000ff")

  -- Clamping
  assert_eq("clamp high", colors.rgb_to_hex(1.5, -0.1, 0.5), "#ff0080")
end

-- ═══════════════════════════════════════════════════════════════
-- rgb↔hsl roundtrip
-- ═══════════════════════════════════════════════════════════════
print("\n=== rgb↔hsl roundtrip ===")
do
  local test_colors = {
    { 1, 0, 0 },       -- red
    { 0, 1, 0 },       -- green
    { 0, 0, 1 },       -- blue
    { 1, 1, 0 },       -- yellow
    { 0.5, 0.5, 0.5 }, -- gray
    { 0.2, 0.4, 0.8 }, -- arbitrary
  }

  for i, rgb in ipairs(test_colors) do
    local h, s, l = colors.rgb_to_hsl(rgb[1], rgb[2], rgb[3])
    local r2, g2, b2 = colors.hsl_to_rgb(h, s, l)
    assert_near("roundtrip " .. i .. " r", r2, rgb[1])
    assert_near("roundtrip " .. i .. " g", g2, rgb[2])
    assert_near("roundtrip " .. i .. " b", b2, rgb[3])
  end
end

-- ═══════════════════════════════════════════════════════════════
-- hex roundtrip
-- ═══════════════════════════════════════════════════════════════
print("\n=== hex roundtrip ===")
do
  local test_hexes = { "#d4d4d4", "#1e1e1e", "#f44747", "#569cd6", "#6a9955", "#ce9178" }
  for _, h in ipairs(test_hexes) do
    local r, g, b = colors.hex_to_rgb(h)
    local result = colors.rgb_to_hex(r, g, b)
    assert_eq("roundtrip " .. h, result, h)
  end
end

-- ═══════════════════════════════════════════════════════════════
-- luminance
-- ═══════════════════════════════════════════════════════════════
print("\n=== luminance ===")
do
  assert_near("black luminance", colors.luminance("#000000"), 0, 0.001)
  assert_near("white luminance", colors.luminance("#ffffff"), 1, 0.001)
  -- Mid-gray should be approximately 0.2 (due to sRGB nonlinearity)
  local gray_lum = colors.luminance("#808080")
  assert_true("gray luminance > 0.1", gray_lum > 0.1)
  assert_true("gray luminance < 0.5", gray_lum < 0.5)
end

-- ═══════════════════════════════════════════════════════════════
-- is_dark
-- ═══════════════════════════════════════════════════════════════
print("\n=== is_dark ===")
do
  assert_eq("black is dark", colors.is_dark("#000000"), true)
  assert_eq("white is not dark", colors.is_dark("#ffffff"), false)
  assert_eq("#1e1e1e is dark", colors.is_dark("#1e1e1e"), true)
  assert_eq("#d4d4d4 is not dark", colors.is_dark("#d4d4d4"), false)
end

-- ═══════════════════════════════════════════════════════════════
-- shift
-- ═══════════════════════════════════════════════════════════════
print("\n=== shift ===")
do
  -- Shift up should increase lightness
  local shifted_up = colors.shift("#1e1e1e", 0.06)
  local _, _, l_orig = colors.rgb_to_hsl(colors.hex_to_rgb("#1e1e1e"))
  local _, _, l_shifted = colors.rgb_to_hsl(colors.hex_to_rgb(shifted_up))
  assert_true("shift +0.06 increases L", l_shifted > l_orig)

  -- Shift down should decrease lightness
  local shifted_down = colors.shift("#d4d4d4", -0.06)
  _, _, l_orig = colors.rgb_to_hsl(colors.hex_to_rgb("#d4d4d4"))
  _, _, l_shifted = colors.rgb_to_hsl(colors.hex_to_rgb(shifted_down))
  assert_true("shift -0.06 decreases L", l_shifted < l_orig)

  -- Boundary: shift #000000 up should not stay black
  local shifted_black = colors.shift("#000000", 0.1)
  assert_true("shift black up", shifted_black ~= "#000000")

  -- Boundary: shift #ffffff down should not stay white
  local shifted_white = colors.shift("#ffffff", -0.1)
  assert_true("shift white down", shifted_white ~= "#ffffff")

  -- Boundary: shift #000000 down should clamp at black
  local clamped = colors.shift("#000000", -0.1)
  assert_eq("shift black down clamps", clamped, "#000000")

  -- Boundary: shift #ffffff up should clamp at white
  local clamped2 = colors.shift("#ffffff", 0.1)
  assert_eq("shift white up clamps", clamped2, "#ffffff")
end

-- ═══════════════════════════════════════════════════════════════
-- invert
-- ═══════════════════════════════════════════════════════════════
print("\n=== invert ===")
do
  -- Dark color: invert should lighten
  local inverted = colors.invert("#1e1e1e", 0.18)
  local _, _, l_inv = colors.rgb_to_hsl(colors.hex_to_rgb(inverted))
  local _, _, l_orig = colors.rgb_to_hsl(colors.hex_to_rgb("#1e1e1e"))
  assert_true("invert dark → lighter", l_inv > l_orig)

  -- Light color: invert should darken
  local inverted2 = colors.invert("#d4d4d4", 0.18)
  local _, _, l_inv2 = colors.rgb_to_hsl(colors.hex_to_rgb(inverted2))
  local _, _, l_orig2 = colors.rgb_to_hsl(colors.hex_to_rgb("#d4d4d4"))
  assert_true("invert light → darker", l_inv2 < l_orig2)

  -- Boundary: pure black
  local inv_black = colors.invert("#000000", 0.18)
  assert_true("invert #000000 valid hex", inv_black:match("^#%x%x%x%x%x%x$") ~= nil)

  -- Boundary: pure white
  local inv_white = colors.invert("#ffffff", 0.18)
  assert_true("invert #ffffff valid hex", inv_white:match("^#%x%x%x%x%x%x$") ~= nil)
end

-- ═══════════════════════════════════════════════════════════════
-- mute
-- ═══════════════════════════════════════════════════════════════
print("\n=== mute ===")
do
  -- Mute should reduce saturation
  local muted = colors.mute("#ff0000", 0.5, 0.25)
  local _, s_muted, _ = colors.rgb_to_hsl(colors.hex_to_rgb(muted))
  assert_true("mute reduces saturation", s_muted < 1.0)

  -- Mute a dark color: should move lightness toward 0.5
  local dark_muted = colors.mute("#1e1e1e", 0.5, 0.25)
  local _, _, l_dark_orig = colors.rgb_to_hsl(colors.hex_to_rgb("#1e1e1e"))
  local _, _, l_dark_muted = colors.rgb_to_hsl(colors.hex_to_rgb(dark_muted))
  assert_true("muted dark L closer to 0.5", math.abs(l_dark_muted - 0.5) < math.abs(l_dark_orig - 0.5))

  -- Mute gray (#808080) should stay gray-ish
  local muted_gray = colors.mute("#808080", 0.5, 0.25)
  assert_true("muted gray valid hex", muted_gray:match("^#%x%x%x%x%x%x$") ~= nil)

  -- Boundary
  local muted_black = colors.mute("#000000", 0.5, 0.25)
  assert_true("muted black valid hex", muted_black:match("^#%x%x%x%x%x%x$") ~= nil)
end

-- ═══════════════════════════════════════════════════════════════
-- blend
-- ═══════════════════════════════════════════════════════════════
print("\n=== blend ===")
do
  -- blend(a, b, 0) = a
  assert_eq("blend factor=0", colors.blend("#ff0000", "#0000ff", 0), "#ff0000")

  -- blend(a, b, 1) = b
  assert_eq("blend factor=1", colors.blend("#ff0000", "#0000ff", 1), "#0000ff")

  -- blend(a, b, 0.5) = midpoint
  local mid = colors.blend("#000000", "#ffffff", 0.5)
  assert_eq("blend midpoint", mid, "#808080")

  -- blend black+white at 0.15
  local tinted = colors.blend("#000000", "#ffffff", 0.15)
  assert_true("blend 15% tint valid", tinted:match("^#%x%x%x%x%x%x$") ~= nil)
end

-- ═══════════════════════════════════════════════════════════════
-- Summary
-- ═══════════════════════════════════════════════════════════════
print(string.format("\n══════════════════════════════════════"))
print(string.format("colors_spec: %d passed, %d failed", pass_count, fail_count))
print(string.format("══════════════════════════════════════"))

if fail_count > 0 then
  vim.cmd("cquit 1")
else
  print("ALL TESTS PASSED")
  vim.cmd("quit")
end
