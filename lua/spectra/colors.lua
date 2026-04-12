--- Color utility functions for spectra.nvim.
--- Handles hex/RGB/HSL conversions and UI color derivation.
--- @module spectra.colors

local M = {}

--- Parse "#RRGGBB" to {r, g, b} floats in [0, 1].
--- @param hex string "#RRGGBB" color string
--- @return number r, number g, number b
function M.hex_to_rgb(hex)
  hex = hex:gsub("^#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return r, g, b
end

--- Convert {r, g, b} floats in [0, 1] to "#RRGGBB".
--- @param r number Red [0, 1]
--- @param g number Green [0, 1]
--- @param b number Blue [0, 1]
--- @return string hex "#RRGGBB"
function M.rgb_to_hex(r, g, b)
  r = math.max(0, math.min(1, r))
  g = math.max(0, math.min(1, g))
  b = math.max(0, math.min(1, b))
  return string.format("#%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

--- Convert RGB to HSL.
--- @param r number Red [0, 1]
--- @param g number Green [0, 1]
--- @param b number Blue [0, 1]
--- @return number h Hue [0, 360)
--- @return number s Saturation [0, 1]
--- @return number l Lightness [0, 1]
function M.rgb_to_hsl(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local l = (max + min) / 2
  local h, s

  if max == min then
    h = 0
    s = 0
  else
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)

    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end

    h = h * 60
  end

  return h, s, l
end

--- Helper for HSL to RGB conversion.
local function hue_to_rgb(p, q, t)
  if t < 0 then t = t + 1 end
  if t > 1 then t = t - 1 end
  if t < 1 / 6 then return p + (q - p) * 6 * t end
  if t < 1 / 2 then return q end
  if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
  return p
end

--- Convert HSL to RGB.
--- @param h number Hue [0, 360)
--- @param s number Saturation [0, 1]
--- @param l number Lightness [0, 1]
--- @return number r, number g, number b
function M.hsl_to_rgb(h, s, l)
  if s == 0 then
    return l, l, l
  end

  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  local hNorm = h / 360

  local r = hue_to_rgb(p, q, hNorm + 1 / 3)
  local g = hue_to_rgb(p, q, hNorm)
  local b = hue_to_rgb(p, q, hNorm - 1 / 3)

  return r, g, b
end

--- Calculate relative luminance of a hex color (WCAG formula).
--- @param hex string "#RRGGBB"
--- @return number luminance [0, 1]
function M.luminance(hex)
  local r, g, b = M.hex_to_rgb(hex)

  -- Linearize sRGB
  local function linearize(c)
    return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
  end

  return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
end

--- Determine if a color is dark (luminance < 0.5).
--- @param hex string "#RRGGBB"
--- @return boolean
function M.is_dark(hex)
  return M.luminance(hex) < 0.5
end

--- Shift lightness of a color. Positive = lighter, negative = darker.
--- Used for subtle background variations (e.g. CursorLine, NormalFloat).
--- @param hex string "#RRGGBB"
--- @param amount number Lightness adjustment [-1, 1], typical: 0.05 to 0.08
--- @return string hex "#RRGGBB"
function M.shift(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)
  l = math.max(0, math.min(1, l + amount))
  r, g, b = M.hsl_to_rgb(h, s, l)
  return M.rgb_to_hex(r, g, b)
end

--- Invert lightness direction with a given amount. Larger shift than shift().
--- Used for StatusLine, Visual, etc.
--- @param hex string "#RRGGBB"
--- @param amount number Lightness adjustment, typical: 0.15 to 0.20
--- @return string hex "#RRGGBB"
function M.invert(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)
  -- For dark themes lighten, for light themes darken
  if l < 0.5 then
    l = math.min(1, l + amount)
  else
    l = math.max(0, l - amount)
  end
  r, g, b = M.hsl_to_rgb(h, s, l)
  return M.rgb_to_hex(r, g, b)
end

--- Mute a color: reduce saturation and adjust lightness toward middle.
--- Used for secondary text (e.g. LineNr, comments when no dedicated color).
--- @param hex string "#RRGGBB"
--- @param s_factor number Saturation multiplier [0, 1], typical: 0.5
--- @param l_amount number Lightness shift toward 0.5, typical: 0.15 to 0.30
--- @return string hex "#RRGGBB"
function M.mute(hex, s_factor, l_amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)
  s = s * s_factor
  -- Move lightness toward 0.5 (middle gray)
  if l < 0.5 then
    l = math.min(0.5, l + l_amount)
  else
    l = math.max(0.5, l - l_amount)
  end
  r, g, b = M.hsl_to_rgb(h, s, l)
  return M.rgb_to_hex(r, g, b)
end

--- Blend two colors together.
--- @param hex1 string "#RRGGBB" first color
--- @param hex2 string "#RRGGBB" second color
--- @param factor number Blend factor [0, 1]. 0 = hex1, 1 = hex2
--- @return string hex "#RRGGBB"
function M.blend(hex1, hex2, factor)
  local r1, g1, b1 = M.hex_to_rgb(hex1)
  local r2, g2, b2 = M.hex_to_rgb(hex2)
  local r = r1 + (r2 - r1) * factor
  local g = g1 + (g2 - g1) * factor
  local b = b1 + (b2 - b1) * factor
  return M.rgb_to_hex(r, g, b)
end

return M
