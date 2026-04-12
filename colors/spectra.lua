-- Spectra ColorScheme for Neovim 0.12+
-- Entry point: loaded by `:colorscheme spectra`

if vim.fn.has("nvim-0.12") ~= 1 then
  vim.notify(
    "Spectra requires Neovim 0.12 or later. Current version: " .. vim.version().major .. "." .. vim.version().minor,
    vim.log.levels.ERROR
  )
  return
end

require("spectra").load()
