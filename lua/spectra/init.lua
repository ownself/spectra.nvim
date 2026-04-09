local M = {}

local default_options = {
  theme = "dracula-colorful",
  transparent_background = false,
  dim_inactive = false,
  styles = {
    comments = {},
    keywords = {},
    functions = {},
    parameters = {},
    fields = {},
    types = {},
  },
  integrations = {
    cmp = true,
    blink = true,
    gitsigns = true,
    rainbow_delimiters = true,
    nvimtree = true,
  },
}

local shared_modules = {
  "editor",
  "syntax",
  "treesitter",
  "lsp",
  "semantic_tokens",
  "integrations",
}

local fallback_order = {
  "language-specific override",
  "semantic token override",
  "TreeSitter capture mapping",
  "semantic role mapping",
  "base palette default",
}

M.options = vim.deepcopy(default_options)

local function get_registry()
  return require("spectra.registry")
end

local function resolve_theme(name)
  return get_registry().resolve(name or M.options.theme)
end

local function get_theme(name)
  local resolved = resolve_theme(name)
  return get_registry().get(resolved.canonical), resolved
end

local function merge_groups(groups, new_groups)
  return vim.tbl_extend("force", groups, new_groups or {})
end

local function normalize_overrides(theme)
  local raw = theme.overrides or {}
  local modules = raw.modules and vim.deepcopy(raw.modules) or {}
  local legacy_module_keys = {
    editor = true,
    syntax = true,
    treesitter = true,
    lsp = true,
    semantic_tokens = true,
    integrations = true,
  }

  for _, module_name in ipairs(shared_modules) do
    if legacy_module_keys[module_name] and type(raw[module_name]) == "function" then
      modules[module_name] = raw[module_name]
    end
  end

  return {
    modules = modules,
    integrations = raw.integrations and vim.deepcopy(raw.integrations) or {},
    languages = raw.languages and vim.deepcopy(raw.languages) or {},
    all = raw.all,
  }
end

local function apply_theme_overrides(groups, overrides, palette, roles, options)
  local module_overrides = overrides.modules or {}

  for _, module_name in ipairs(shared_modules) do
    local provider = module_overrides[module_name]
    if provider then
      local extra = type(provider) == "function" and provider(palette, roles, options) or provider
      groups = merge_groups(groups, extra)
    end
  end

  if overrides.all then
    groups = merge_groups(groups, overrides.all(palette, roles, options))
  end

  return groups
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(default_options), opts or {})
end

function M.get_fallback_order()
  return vim.deepcopy(fallback_order)
end

function M.resolve_theme(name)
  return resolve_theme(name)
end

function M.get_theme(name)
  local theme = get_theme(name)
  return theme
end

function M.get_groups(name)
  local theme, resolved = get_theme(name)
  local palette = theme.palette(M.options)
  local roles = theme.roles(palette, M.options)
  local overrides = normalize_overrides(theme)
  local groups = {}
  local context = {
    theme = theme,
    resolution = resolved,
    overrides = overrides,
  }

  for _, module_name in ipairs(shared_modules) do
    local module = require("spectra.groups." .. module_name)
    groups = merge_groups(groups, module.get(palette, roles, M.options, context))
  end

  groups = apply_theme_overrides(groups, overrides, palette, roles, M.options)

  return groups, palette, roles, theme, resolved
end

function M.load(name)
  if vim.fn.has("nvim-0.12") == 0 then
    vim.notify("spectra.nvim requires Neovim 0.12+", vim.log.levels.ERROR)
    return
  end

  local requested_name = name or M.options.theme
  local theme, resolved = get_theme(requested_name)

  if name then
    M.options.theme = name
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.o.background = theme.meta.background or "dark"
  vim.g.colors_name = resolved.requested or theme.meta.colorscheme or theme.meta.name

  local groups, palette = M.get_groups(resolved.canonical)
  require("spectra.util.highlighter").apply(groups)

  if palette.terminal then
    for i = 0, 15 do
      vim.g["terminal_color_" .. i] = palette.terminal[i + 1]
    end
  end
end

return M
