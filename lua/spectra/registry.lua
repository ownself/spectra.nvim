local M = {}

local builtin_themes = {
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
