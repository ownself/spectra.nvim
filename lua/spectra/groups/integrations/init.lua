local M = {}

function M.get(C, R, O, context)
  local groups = {}
  local integrations = O.integrations or {}
  local overrides = context and context.overrides and context.overrides.integrations or {}

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

      local provider = overrides[key]
      if provider then
        local extra = type(provider) == "function" and provider(C, R, O) or provider
        groups = vim.tbl_extend("force", groups, extra or {})
      end
    end
  end

  return groups
end

return M
