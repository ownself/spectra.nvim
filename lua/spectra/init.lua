--- spectra.nvim: A progressive palette colorscheme for Neovim 0.12+
--- @module spectra

local M = {}

--- @type spectra.Config|nil
M._config = nil

--- @type boolean
M._loaded = false

--- @type number|nil Autocmd group ID
M._augroup = nil

--- Built-in theme registry: short name → Lua module path.
--- @type table<string, string>
M.themes = {
  ["default"]    = "spectra.themes.default",
  ["dracula"]    = "spectra.themes.dracula_colorful",
  ["catppuccin"] = "spectra.themes.catppuccin_macchiato",
  ["tokyonight"] = "spectra.themes.tokyonight_storm",
  ["kanagawa"]   = "spectra.themes.kanagawa_wave",
}

--- Configure spectra.nvim with user options.
--- Can be called before `:colorscheme spectra`. If not called, defaults are used.
--- @param opts? spectra.Config User configuration table
function M.setup(opts)
  local config = require("spectra.config")
  M._config = config.merge(opts or {})
end

--- Resolve a theme module from name.
--- @param theme_name string Theme name
--- @return table theme_mod Theme module with .dark/.light tables
local function resolve_theme(theme_name)
  local mod_path = M.themes[theme_name]
  if mod_path then
    return require(mod_path)
  end
  local ok, mod = pcall(require, "spectra.themes." .. theme_name)
  if ok then
    return mod
  end
  vim.notify(string.format("Spectra: theme '%s' not found, using default", theme_name), vim.log.levels.WARN)
  return require("spectra.themes.default")
end

--- Apply the colorscheme. Called by `colors/spectra.lua`.
function M.load()
  if not M._config then
    M.setup({})
  end

  -- Clear existing highlights
  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.g.colors_name = "spectra"
  vim.o.termguicolors = true

  -- Resolve palette with fallback chain
  local palette = require("spectra.palette")
  local config = M._config

  -- Determine style (dark/light)
  local style = config.style or "dark"
  if style == "auto" then
    style = vim.o.background or "dark"
  end

  -- Load base theme palette
  local user_palette
  if config.default_theme == false then
    user_palette = vim.tbl_extend("force", {}, config.palette or {})
  else
    local theme_name = config.theme or "default"
    local theme_mod = resolve_theme(theme_name)
    local base_palette = style == "light" and theme_mod.light or theme_mod.dark
    user_palette = vim.tbl_extend("force", base_palette, config.palette or {})
  end

  -- Apply style-specific overrides
  if style == "light" and config.light then
    user_palette = vim.tbl_extend("force", user_palette, config.light)
  elseif style == "dark" and config.dark then
    user_palette = vim.tbl_extend("force", user_palette, config.dark)
  end

  vim.o.background = style

  -- Resolve full palette (fills all 75 slots via fallback chain)
  local resolved = palette.resolve(user_palette)

  -- on_colors callback
  if config.on_colors then
    config.on_colors(resolved)
  end

  -- Generate highlight groups
  local groups = {}

  local function collect(module_name)
    local ok, mod = pcall(require, "spectra.groups." .. module_name)
    if ok and mod.get then
      local hgs = mod.get(resolved, config)
      for group, def in pairs(hgs) do
        groups[group] = def
      end
    end
  end

  collect("editor")
  collect("syntax")
  collect("treesitter")
  collect("lsp")
  collect("diagnostic")
  collect("diff")

  -- Conditionally load plugin highlights
  if config.plugins then
    local plugins_ok, plugins_mod = pcall(require, "spectra.groups.plugins")
    if plugins_ok and plugins_mod.get then
      local plugin_hgs = plugins_mod.get(resolved, config)
      for group, def in pairs(plugin_hgs) do
        groups[group] = def
      end
    end
  end

  -- on_highlights callback
  if config.on_highlights then
    config.on_highlights(groups, resolved)
  end

  -- Apply all highlight groups
  for group, def in pairs(groups) do
    vim.api.nvim_set_hl(0, group, def)
  end

  -- Set up autocmd for background switching (only when style="auto")
  if M._augroup then
    vim.api.nvim_del_augroup_by_id(M._augroup)
    M._augroup = nil
  end

  if config.style == "auto" then
    M._augroup = vim.api.nvim_create_augroup("Spectra", { clear = true })
    vim.api.nvim_create_autocmd("OptionSet", {
      group = M._augroup,
      pattern = "background",
      callback = function()
        M.load()
      end,
    })
  end

  M._loaded = true
end

--- Switch to a different built-in theme at runtime.
--- @param theme_name string Theme name (e.g. "dracula", "catppuccin")
function M.switch(theme_name)
  if not M._config then
    M.setup({})
  end
  M._config.theme = theme_name
  M._config.default_theme = true
  M.load()
end

--- Register the :Spectra user command.
function M._register_command()
  vim.api.nvim_create_user_command("Spectra", function(opts)
    local arg = opts.args
    if arg == "" then
      -- No argument: list available themes and current
      local current = M._config and M._config.theme or "default"
      local names = {}
      for name in pairs(M.themes) do
        table.insert(names, name)
      end
      table.sort(names)
      local lines = {}
      for _, name in ipairs(names) do
        local marker = name == current and " *" or ""
        table.insert(lines, "  " .. name .. marker)
      end
      vim.notify("Spectra themes (* = current):\n" .. table.concat(lines, "\n"), vim.log.levels.INFO)
    else
      M.switch(arg)
    end
  end, {
    nargs = "?",
    complete = function()
      local names = {}
      for name in pairs(M.themes) do
        table.insert(names, name)
      end
      table.sort(names)
      return names
    end,
    desc = "Switch spectra.nvim theme",
  })
end

-- Register command on module load
M._register_command()

return M
