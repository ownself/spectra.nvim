--- Diff highlight group definitions (L6 VimSyntax diff groups).
--- Source: hg-mapping.csv — diffAdded/diffChanged/diffRemoved (VimSyntax tradition).
--- Note: DiffAdd/DiffChange/DiffDelete/DiffText/Added/Changed/Removed are in editor.lua
--- because they appear in EditorBasic source in the CSV. This module covers the
--- remaining VimSyntax-tradition diff groups.
--- @module spectra.groups.diff

local M = {}

--- Generate VimSyntax diff highlight groups from resolved palette.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  return {
    diffAdded   = { link = "Added" },
    diffChanged = { link = "Changed" },
    diffRemoved = { link = "Removed" },
  }
end

return M
