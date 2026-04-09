local M = {}

function M.get(C, R, O)
  local groups = {}
  local integrations = O.integrations or {}

  local modules = {
    cmp = "spectra.groups.integrations.cmp",
    blink = "spectra.groups.integrations.blink",
    gitsigns = "spectra.groups.integrations.gitsigns",
    rainbow_delimiters = "spectra.groups.integrations.rainbow_delimiters",
    nvimtree = "spectra.groups.integrations.nvimtree",
  }

  for key, module in pairs(modules) do
    if integrations[key] ~= false then
      groups = vim.tbl_extend("force", groups, require(module).get(C, R, O))
    end
  end

  return groups
end

return M
