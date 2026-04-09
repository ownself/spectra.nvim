local M = {}

local builtin_themes = {
  ["catppuccin"] = "spectra.themes.catppuccin_macchiato",
  ["catppuccin-frappe"] = "spectra.themes.catppuccin_frappe",
  ["catppuccin-latte"] = "spectra.themes.catppuccin_latte",
  ["catppuccin-macchiato"] = "spectra.themes.catppuccin_macchiato",
  ["catppuccin-mocha"] = "spectra.themes.catppuccin_mocha",
  ["dracula-colorful"] = "spectra.themes.dracula_colorful",
}

function M.get(name)
  local module_name = builtin_themes[name]

  if not module_name then
    error("spectra.nvim: unknown theme '" .. tostring(name) .. "'")
  end

  return require(module_name)
end

function M.list()
  return vim.tbl_keys(builtin_themes)
end

return M
