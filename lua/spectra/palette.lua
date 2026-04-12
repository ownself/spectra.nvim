--- Palette definition and fallback resolution engine for spectra.nvim.
--- Implements the 5-layer progressive palette (base → accent → role → full → variant)
--- with 75 slot definitions and the fallback lookup algorithm.
--- @module spectra.palette

local colors = require("spectra.colors")

local M = {}

--- Slot definitions: all 75 palette slots.
--- Each entry: { path, layer, category, required, fallback, final_fallback }
--- @type table[]
M.slots = {
  -- Layer 0: base (2) — required
  { path = "fg", layer = 0, category = "base", required = true, fallback = nil, final_fallback = "fg" },
  { path = "bg", layer = 0, category = "base", required = true, fallback = nil, final_fallback = "bg" },

  -- Layer 1: accent (6)
  { path = "accent.action",  layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },
  { path = "accent.caution", layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },
  { path = "accent.control", layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },
  { path = "accent.danger",  layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },
  { path = "accent.info",    layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },
  { path = "accent.success", layer = 1, category = "accent", required = false, fallback = "fg", final_fallback = "fg" },

  -- Layer 2: role (8)
  { path = "diag.error",       layer = 2, category = "diag",   required = false, fallback = "accent.danger",  final_fallback = "fg" },
  { path = "diag.warn",        layer = 2, category = "diag",   required = false, fallback = "accent.caution", final_fallback = "fg" },
  { path = "diff.add",         layer = 2, category = "diff",   required = false, fallback = "accent.success", final_fallback = "fg" },
  { path = "syntax.comment",   layer = 2, category = "syntax", required = false, fallback = "fg",             final_fallback = "fg" },  -- accent-skip
  { path = "syntax.function",  layer = 2, category = "syntax", required = false, fallback = "accent.action",  final_fallback = "fg" },
  { path = "syntax.keyword",   layer = 2, category = "syntax", required = false, fallback = "accent.control", final_fallback = "fg" },
  { path = "syntax.string",    layer = 2, category = "syntax", required = false, fallback = "accent.success", final_fallback = "fg" },
  { path = "syntax.type",      layer = 2, category = "syntax", required = false, fallback = "fg",             final_fallback = "fg" },  -- accent-skip

  -- Layer 3: full (13 syntax/diag/diff + 7 UI)
  { path = "diag.hint",          layer = 3, category = "diag",   required = false, fallback = "diag.info",       final_fallback = "fg" },
  { path = "diag.info",          layer = 3, category = "diag",   required = false, fallback = "accent.info",     final_fallback = "fg" },
  { path = "diag.ok",            layer = 3, category = "diag",   required = false, fallback = "diff.add",        final_fallback = "fg" },
  { path = "diff.change",        layer = 3, category = "diff",   required = false, fallback = "diag.info",       final_fallback = "fg" },
  { path = "diff.delete",        layer = 3, category = "diff",   required = false, fallback = "diag.error",      final_fallback = "fg" },
  { path = "syntax.constant",    layer = 3, category = "syntax", required = false, fallback = "accent.caution",  final_fallback = "fg" },
  { path = "syntax.identifier",  layer = 3, category = "syntax", required = false, fallback = "accent.info",     final_fallback = "fg" },
  { path = "syntax.operator",    layer = 3, category = "syntax", required = false, fallback = "fg",              final_fallback = "fg" },  -- accent-skip
  { path = "syntax.preproc",     layer = 3, category = "syntax", required = false, fallback = "syntax.keyword",  final_fallback = "fg" },
  { path = "syntax.special",     layer = 3, category = "syntax", required = false, fallback = "syntax.function", final_fallback = "fg" },
  { path = "ui.search",          layer = 3, category = "ui",     required = false, fallback = "accent.caution",  final_fallback = "bg" },
  { path = "ui.cursorline",      layer = 3, category = "ui",     required = false, fallback = "bg",              final_fallback = "bg" },
  { path = "ui.float",           layer = 3, category = "ui",     required = false, fallback = "bg",              final_fallback = "bg" },
  { path = "ui.linenr",          layer = 3, category = "ui",     required = false, fallback = "fg",              final_fallback = "fg" },
  { path = "ui.pmenu",           layer = 3, category = "ui",     required = false, fallback = "ui.float",        final_fallback = "bg" },
  { path = "ui.statusline",      layer = 3, category = "ui",     required = false, fallback = "bg",              final_fallback = "bg" },
  { path = "ui.visual",          layer = 3, category = "ui",     required = false, fallback = "bg",              final_fallback = "bg" },

  -- Layer 4: variant - syntax (22)
  { path = "syntax.comment.doc",          layer = 4, category = "syntax", required = false, fallback = "syntax.comment",    final_fallback = "fg" },
  { path = "syntax.constant.builtin",     layer = 4, category = "syntax", required = false, fallback = "syntax.constant",   final_fallback = "fg" },
  { path = "syntax.constant.character",   layer = 4, category = "syntax", required = false, fallback = "syntax.constant",   final_fallback = "fg" },
  { path = "syntax.constant.macro",       layer = 4, category = "syntax", required = false, fallback = "syntax.constant",   final_fallback = "fg" },
  { path = "syntax.delimiter",            layer = 4, category = "syntax", required = false, fallback = "fg",                final_fallback = "fg" },  -- accent-skip
  { path = "syntax.function.builtin",     layer = 4, category = "syntax", required = false, fallback = "syntax.function",   final_fallback = "fg" },
  { path = "syntax.function.method",      layer = 4, category = "syntax", required = false, fallback = "syntax.function",   final_fallback = "fg" },
  { path = "syntax.identifier.builtin",   layer = 4, category = "syntax", required = false, fallback = "syntax.identifier", final_fallback = "fg" },
  { path = "syntax.identifier.field",     layer = 4, category = "syntax", required = false, fallback = "syntax.identifier.member", final_fallback = "fg" },
  { path = "syntax.identifier.member",    layer = 4, category = "syntax", required = false, fallback = "syntax.identifier", final_fallback = "fg" },
  { path = "syntax.identifier.parameter", layer = 4, category = "syntax", required = false, fallback = "syntax.identifier", final_fallback = "fg" },
  { path = "syntax.label",               layer = 4, category = "syntax", required = false, fallback = "syntax.keyword",    final_fallback = "fg" },
  { path = "syntax.preproc.include",      layer = 4, category = "syntax", required = false, fallback = "syntax.preproc",    final_fallback = "fg" },
  { path = "syntax.preproc.macro",        layer = 4, category = "syntax", required = false, fallback = "syntax.preproc",    final_fallback = "fg" },
  { path = "syntax.string.escape",        layer = 4, category = "syntax", required = false, fallback = "syntax.string",     final_fallback = "fg" },
  { path = "syntax.string.special",       layer = 4, category = "syntax", required = false, fallback = "syntax.string",     final_fallback = "fg" },
  { path = "syntax.tag",                  layer = 4, category = "syntax", required = false, fallback = "syntax.keyword",    final_fallback = "fg" },
  { path = "syntax.variable",            layer = 4, category = "syntax", required = false, fallback = "fg",                final_fallback = "fg" },  -- accent-skip
  { path = "syntax.type.builtin",         layer = 4, category = "syntax", required = false, fallback = "syntax.type",       final_fallback = "fg" },
  { path = "syntax.type.constructor",     layer = 4, category = "syntax", required = false, fallback = "syntax.type",       final_fallback = "fg" },
  { path = "syntax.type.definition",      layer = 4, category = "syntax", required = false, fallback = "syntax.type",       final_fallback = "fg" },
  { path = "syntax.type.module",          layer = 4, category = "syntax", required = false, fallback = "syntax.type",       final_fallback = "fg" },

  -- Layer 4: variant - diag (10)
  { path = "diag.error.bg",     layer = 4, category = "diag", required = false, fallback = "diag.error", final_fallback = "fg" },
  { path = "diag.error.subtle", layer = 4, category = "diag", required = false, fallback = "diag.error", final_fallback = "fg" },
  { path = "diag.hint.bg",     layer = 4, category = "diag", required = false, fallback = "diag.hint",  final_fallback = "fg" },
  { path = "diag.hint.subtle", layer = 4, category = "diag", required = false, fallback = "diag.hint",  final_fallback = "fg" },
  { path = "diag.info.bg",     layer = 4, category = "diag", required = false, fallback = "diag.info",  final_fallback = "fg" },
  { path = "diag.info.subtle", layer = 4, category = "diag", required = false, fallback = "diag.info",  final_fallback = "fg" },
  { path = "diag.ok.bg",       layer = 4, category = "diag", required = false, fallback = "diag.ok",    final_fallback = "fg" },
  { path = "diag.ok.subtle",   layer = 4, category = "diag", required = false, fallback = "diag.ok",    final_fallback = "fg" },
  { path = "diag.warn.bg",     layer = 4, category = "diag", required = false, fallback = "diag.warn",  final_fallback = "fg" },
  { path = "diag.warn.subtle", layer = 4, category = "diag", required = false, fallback = "diag.warn",  final_fallback = "fg" },

  -- Layer 4: variant - diff (3)
  { path = "diff.add.bg",    layer = 4, category = "diff", required = false, fallback = "diff.add",    final_fallback = "fg" },
  { path = "diff.change.bg", layer = 4, category = "diff", required = false, fallback = "diff.change", final_fallback = "fg" },
  { path = "diff.delete.bg", layer = 4, category = "diff", required = false, fallback = "diff.delete", final_fallback = "fg" },

  -- Layer 4: variant - ui (7)
  { path = "ui.float.bg",      layer = 4, category = "ui", required = false, fallback = "ui.float",      final_fallback = "bg" },
  { path = "ui.float.subtle",  layer = 4, category = "ui", required = false, fallback = "ui.float",      final_fallback = "bg" },
  { path = "ui.pmenu.bg",      layer = 4, category = "ui", required = false, fallback = "ui.pmenu",      final_fallback = "bg" },
  { path = "ui.pmenu.subtle",  layer = 4, category = "ui", required = false, fallback = "ui.pmenu",      final_fallback = "bg" },
  { path = "ui.search.bg",     layer = 4, category = "ui", required = false, fallback = "ui.search",     final_fallback = "bg" },
  { path = "ui.statusline.bg", layer = 4, category = "ui", required = false, fallback = "ui.statusline", final_fallback = "bg" },
  { path = "ui.visual.bg",     layer = 4, category = "ui", required = false, fallback = "ui.visual",     final_fallback = "bg" },
}

--- Build a lookup table: path → slot definition
--- @type table<string, table>
M._slot_index = {}
for _, slot in ipairs(M.slots) do
  M._slot_index[slot.path] = slot
end

--- Default fg/bg colors used when user provides none.
M.DEFAULT_FG = "#d4d4d4"
M.DEFAULT_BG = "#1e1e1e"

--- UI derivation parameters.
--- Tuned for visual hierarchy: CursorLine barely visible → Float subtle →
--- Pmenu distinct → Visual/StatusLine clearly contrasting.
--- @type table
M.UI_PARAMS = {
  shift_amount = 0.06,   -- CursorLine/NormalFloat: +5~8% L (subtle bg shift)
  invert_amount = 0.18,  -- StatusLine/Visual: +15~20% L (larger contrast)
  mute_s_factor = 0.5,   -- LineNr: S×0.5 (reduce saturation)
  mute_l_amount = 0.30,  -- LineNr: L shift toward middle (subdued text)
}

--- Resolve a complete palette from user-provided partial colors.
--- Implements the 5-layer fallback: variant → full → role → accent → base.
--- Also handles accent-skip rules, variant promotion, and UI auto-derivation.
--- @param user_palette table<string, string> Partial palette from user
--- @return table<string, string> resolved Complete 75-slot palette (path → "#RRGGBB")
function M.resolve(user_palette)
  local resolved = {}

  -- Step 1: Seed base colors (fg/bg) with user values or defaults
  resolved.fg = user_palette.fg or M.DEFAULT_FG
  resolved.bg = user_palette.bg or M.DEFAULT_BG

  -- Step 2: Copy all user-provided values
  for path, value in pairs(user_palette) do
    if M._slot_index[path] then
      resolved[path] = value
    end
  end

  -- Step 3: Variant promotion — if user provided a variant but not its parent,
  -- promote the variant to also serve as the parent.
  for _, slot in ipairs(M.slots) do
    if slot.layer == 4 and resolved[slot.path] and slot.fallback then
      if not resolved[slot.fallback] then
        resolved[slot.fallback] = resolved[slot.path]
      end
    end
  end

  -- Step 4: Resolve all non-UI slots via fallback chain.
  -- Process in layer order (0 → 1 → 2 → 3 → 4) to ensure parents resolve first.
  -- Skip diag/diff layer-4 .bg/.subtle variants — Step 7 auto-derives those.
  for _, slot in ipairs(M.slots) do
    local is_auto_variant = slot.layer == 4
      and (slot.category == "diag" or slot.category == "diff")
      and (slot.path:match("%.bg$") or slot.path:match("%.subtle$"))
    if not resolved[slot.path] and slot.category ~= "ui" and not is_auto_variant then
      -- Walk the fallback chain
      local current = slot.fallback
      while current do
        if resolved[current] then
          resolved[slot.path] = resolved[current]
          break
        end
        local parent_slot = M._slot_index[current]
        current = parent_slot and parent_slot.fallback or nil
      end
      -- If still unresolved, use final_fallback
      if not resolved[slot.path] then
        resolved[slot.path] = resolved[slot.final_fallback] or resolved.fg
      end
    end
  end

  -- Step 5: Auto-derive UI colors from bg.
  local bg = resolved.bg
  local is_dark = colors.is_dark(bg)
  local params = M.UI_PARAMS
  local shift_dir = is_dark and 1 or -1

  -- ui.cursorline: subtle bg shift
  if not resolved["ui.cursorline"] then
    resolved["ui.cursorline"] = colors.shift(bg, shift_dir * params.shift_amount)
  end

  -- ui.float: slightly different bg shift
  if not resolved["ui.float"] then
    resolved["ui.float"] = colors.shift(bg, shift_dir * params.shift_amount * 1.3)
  end

  -- ui.pmenu: from ui.float (slightly shifted further)
  if not resolved["ui.pmenu"] then
    resolved["ui.pmenu"] = colors.shift(resolved["ui.float"], shift_dir * params.shift_amount * 0.5)
  end

  -- ui.statusline: moderate bg shift (same direction as cursorline, larger amount)
  if not resolved["ui.statusline"] then
    resolved["ui.statusline"] = colors.shift(bg, shift_dir * params.shift_amount * 0.5)
  end

  -- ui.visual: inverted bg (different amount from statusline)
  if not resolved["ui.visual"] then
    resolved["ui.visual"] = colors.invert(bg, params.invert_amount * 0.8)
  end

  -- ui.search: use accent.caution color as bg, or fall back to inverted bg
  if not resolved["ui.search"] then
    if resolved["accent.caution"] then
      resolved["ui.search"] = resolved["accent.caution"]
    else
      resolved["ui.search"] = colors.invert(bg, params.invert_amount * 1.2)
    end
  end

  -- ui.linenr: muted fg
  if not resolved["ui.linenr"] then
    resolved["ui.linenr"] = colors.mute(resolved.fg, params.mute_s_factor, params.mute_l_amount)
  end

  -- Step 6: Auto-derive UI variant slots
  for _, slot in ipairs(M.slots) do
    if slot.layer == 4 and slot.category == "ui" and not resolved[slot.path] then
      local parent = slot.fallback
      if resolved[parent] then
        -- .bg variants: slightly shift the parent
        if slot.path:match("%.bg$") then
          resolved[slot.path] = colors.shift(resolved[parent], shift_dir * params.shift_amount * 0.4)
        -- .subtle variants: mute the parent
        elseif slot.path:match("%.subtle$") then
          resolved[slot.path] = colors.mute(resolved[parent], 0.7, 0.1)
        else
          resolved[slot.path] = resolved[parent]
        end
      else
        resolved[slot.path] = resolved[slot.final_fallback] or resolved.bg
      end
    end
  end

  -- Step 7: Auto-derive diag/diff variant slots (.bg and .subtle)
  for _, slot in ipairs(M.slots) do
    if slot.layer == 4 and (slot.category == "diag" or slot.category == "diff") and not resolved[slot.path] then
      local parent = slot.fallback
      local parent_color = resolved[parent] or resolved.fg
      if slot.path:match("%.bg$") then
        -- .bg: blend the diagnostic/diff color with bg at low opacity
        resolved[slot.path] = colors.blend(resolved.bg, parent_color, 0.15)
      elseif slot.path:match("%.subtle$") then
        -- .subtle: blend with fg for muted version
        resolved[slot.path] = colors.blend(resolved.fg, parent_color, 0.4)
      else
        resolved[slot.path] = parent_color
      end
    end
  end

  return resolved
end

--- Get a resolved color for a specific slot path.
--- @param resolved table<string, string> Resolved palette
--- @param path string Slot path
--- @return string hex "#RRGGBB" color value
function M.get(resolved, path)
  return resolved[path] or resolved.fg
end

return M
