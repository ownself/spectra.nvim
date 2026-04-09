local M = {}

local registry = {
  themes = {
    ["dracula-colorful"] = {
      module = "spectra.themes.dracula_colorful",
    },
    ["catppuccin-mocha"] = {
      module = "spectra.themes.catppuccin_mocha",
      family = "catppuccin",
      flavour = "mocha",
    },
    ["catppuccin-macchiato"] = {
      module = "spectra.themes.catppuccin_macchiato",
      family = "catppuccin",
      flavour = "macchiato",
    },
    ["catppuccin-frappe"] = {
      module = "spectra.themes.catppuccin_frappe",
      family = "catppuccin",
      flavour = "frappe",
    },
    ["catppuccin-latte"] = {
      module = "spectra.themes.catppuccin_latte",
      family = "catppuccin",
      flavour = "latte",
    },
    ["tokyonight-moon"] = {
      module = "spectra.themes.tokyonight_moon",
      family = "tokyonight",
      flavour = "moon",
    },
    ["tokyonight-storm"] = {
      module = "spectra.themes.tokyonight_storm",
      family = "tokyonight",
      flavour = "storm",
    },
    ["tokyonight-night"] = {
      module = "spectra.themes.tokyonight_night",
      family = "tokyonight",
      flavour = "night",
    },
    ["tokyonight-day"] = {
      module = "spectra.themes.tokyonight_day",
      family = "tokyonight",
      flavour = "day",
    },
  },
  families = {
    catppuccin = {
      default = "catppuccin-macchiato",
      flavours = {
        "catppuccin-mocha",
        "catppuccin-macchiato",
        "catppuccin-frappe",
        "catppuccin-latte",
      },
    },
    tokyonight = {
      default = "tokyonight-moon",
      flavours = {
        "tokyonight-moon",
        "tokyonight-storm",
        "tokyonight-night",
        "tokyonight-day",
      },
    },
  },
  aliases = {
  },
}

local function get_theme_record(name)
  return registry.themes[name]
end

function M.resolve(name)
  local requested = name
  local family = registry.families[name]
  local canonical = family and family.default or registry.aliases[name] or name
  local theme = get_theme_record(canonical)

  if not theme then
    error("spectra.nvim: unknown theme '" .. tostring(name) .. "'")
  end

  local resolved_family = theme.family and registry.families[theme.family] or nil

  return {
    requested = requested,
    canonical = canonical,
    theme = vim.deepcopy(theme),
    family = resolved_family and vim.deepcopy(resolved_family) or nil,
    is_alias = requested ~= canonical,
  }
end

function M.get(name)
  local resolved = M.resolve(name)
  return require(resolved.theme.module)
end

function M.list()
  local names = {}

  for name in pairs(registry.themes) do
    table.insert(names, name)
  end

  for name in pairs(registry.aliases) do
    table.insert(names, name)
  end

  for name in pairs(registry.families) do
    table.insert(names, name)
  end

  table.sort(names)
  return names
end

function M.list_themes()
  local names = vim.tbl_keys(registry.themes)
  table.sort(names)
  return names
end

function M.list_families()
  local names = vim.tbl_keys(registry.families)
  table.sort(names)
  return names
end

function M.get_family(name)
  local family = registry.families[name]
  return family and vim.deepcopy(family) or nil
end

return M
