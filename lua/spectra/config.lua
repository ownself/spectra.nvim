--- Configuration module for spectra.nvim.
--- Handles default config, user config merging, and input validation.
--- @module spectra.config

local M = {}

--- Valid slot paths (all 67 from palette-slots.csv).
--- @type table<string, boolean>
M.VALID_SLOTS = {
  -- Layer 0: base (2)
  fg = true, bg = true,
  -- Layer 1: accent (6)
  ["accent.action"] = true, ["accent.caution"] = true, ["accent.control"] = true,
  ["accent.danger"] = true, ["accent.info"] = true, ["accent.success"] = true,
  -- Layer 2: role (8)
  ["diag.error"] = true, ["diag.warn"] = true, ["diff.add"] = true,
  ["syntax.comment"] = true, ["syntax.function"] = true, ["syntax.keyword"] = true,
  ["syntax.string"] = true, ["syntax.type"] = true,
  -- Layer 3: full (13)
  ["diag.hint"] = true, ["diag.info"] = true, ["diag.ok"] = true,
  ["diff.change"] = true, ["diff.delete"] = true,
  ["syntax.constant"] = true, ["syntax.identifier"] = true, ["syntax.operator"] = true,
  ["syntax.preproc"] = true, ["syntax.special"] = true,
  ["ui.search"] = true, ["ui.cursorline"] = true, ["ui.float"] = true,
  ["ui.linenr"] = true, ["ui.pmenu"] = true, ["ui.statusline"] = true, ["ui.visual"] = true,
  -- Layer 4: variant - syntax (22)
  ["syntax.comment.doc"] = true, ["syntax.constant.builtin"] = true,
  ["syntax.constant.character"] = true, ["syntax.constant.macro"] = true,
  ["syntax.delimiter"] = true, ["syntax.function.builtin"] = true,
  ["syntax.function.method"] = true, ["syntax.identifier.builtin"] = true,
  ["syntax.identifier.field"] = true, ["syntax.identifier.member"] = true,
  ["syntax.identifier.parameter"] = true, ["syntax.label"] = true,
  ["syntax.preproc.include"] = true, ["syntax.preproc.macro"] = true,
  ["syntax.string.escape"] = true, ["syntax.string.special"] = true,
  ["syntax.tag"] = true, ["syntax.type.builtin"] = true,
  ["syntax.type.constructor"] = true, ["syntax.type.definition"] = true,
  ["syntax.type.module"] = true, ["syntax.variable"] = true,
  -- Layer 4: variant - diag (10)
  ["diag.error.bg"] = true, ["diag.error.subtle"] = true,
  ["diag.hint.bg"] = true, ["diag.hint.subtle"] = true,
  ["diag.info.bg"] = true, ["diag.info.subtle"] = true,
  ["diag.ok.bg"] = true, ["diag.ok.subtle"] = true,
  ["diag.warn.bg"] = true, ["diag.warn.subtle"] = true,
  -- Layer 4: variant - diff (3)
  ["diff.add.bg"] = true, ["diff.change.bg"] = true, ["diff.delete.bg"] = true,
  -- Layer 4: variant - ui (7)
  ["ui.float.bg"] = true, ["ui.float.subtle"] = true,
  ["ui.pmenu.bg"] = true, ["ui.pmenu.subtle"] = true,
  ["ui.search.bg"] = true, ["ui.statusline.bg"] = true, ["ui.visual.bg"] = true,
}

--- Default configuration.
--- @type spectra.Config
M.defaults = {
  palette = {},
  style = "dark",
  theme = "default",
  default_theme = true,
  transparent = false,
  dark = nil,
  light = nil,
  plugins = {
    telescope = true,
    nvim_tree = true,
    gitsigns = true,
    indent_blankline = true,
  },
  on_colors = nil,
  on_highlights = nil,
}

--- Validate a hex color string.
--- @param value string
--- @return boolean
function M.validate_hex(value)
  if type(value) ~= "string" then
    return false
  end
  return value:match("^#%x%x%x%x%x%x$") ~= nil
end

--- Validate a slot path.
--- @param path string
--- @return boolean
function M.validate_slot_path(path)
  return M.VALID_SLOTS[path] == true
end

--- Find the closest valid slot path for a typo suggestion.
--- @param path string Invalid path
--- @return string|nil closest Closest valid path, or nil
function M.suggest_slot(path)
  local best, best_score = nil, 0
  for valid_path, _ in pairs(M.VALID_SLOTS) do
    -- Simple prefix match scoring
    local score = 0
    local min_len = math.min(#path, #valid_path)
    for i = 1, min_len do
      if path:sub(i, i) == valid_path:sub(i, i) then
        score = score + 1
      end
    end
    if score > best_score then
      best_score = score
      best = valid_path
    end
  end
  return best_score > #path * 0.5 and best or nil
end

--- Merge user configuration with defaults. Validates palette entries.
--- @param user_opts table User configuration
--- @return spectra.Config Merged and validated configuration
function M.merge(user_opts)
  local config = vim.tbl_deep_extend("force", {}, M.defaults, user_opts)

  -- Validate palette entries
  if config.palette then
    for path, value in pairs(config.palette) do
      if not M.validate_slot_path(path) then
        local suggestion = M.suggest_slot(path)
        local msg = string.format("Spectra: invalid palette path '%s'", path)
        if suggestion then
          msg = msg .. string.format(", did you mean '%s'?", suggestion)
        end
        vim.notify(msg, vim.log.levels.WARN)
        config.palette[path] = nil
      elseif not M.validate_hex(value) then
        vim.notify(
          string.format("Spectra: invalid color value '%s' for path '%s' (expected #RRGGBB)", tostring(value), path),
          vim.log.levels.WARN
        )
        config.palette[path] = nil
      end
    end
  end

  -- Validate dark/light palettes
  for _, variant in ipairs({ "dark", "light" }) do
    if config[variant] then
      for path, value in pairs(config[variant]) do
        if not M.validate_slot_path(path) then
          vim.notify(string.format("Spectra: invalid palette path '%s' in %s config", path, variant), vim.log.levels.WARN)
          config[variant][path] = nil
        elseif not M.validate_hex(value) then
          vim.notify(
            string.format("Spectra: invalid color value '%s' for path '%s' in %s config", tostring(value), path, variant),
            vim.log.levels.WARN
          )
          config[variant][path] = nil
        end
      end
    end
  end

  -- Validate style
  if config.style ~= "dark" and config.style ~= "light" and config.style ~= "auto" then
    vim.notify(
      string.format("Spectra: invalid style '%s', using 'dark'", tostring(config.style)),
      vim.log.levels.WARN
    )
    config.style = "dark"
  end

  return config
end

return M
