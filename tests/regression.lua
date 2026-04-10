local spectra = require("spectra")
local registry = require("spectra.registry")

local cases = {
  {
    requested = "dracula-colorful",
    canonical = "dracula-colorful",
    background = "dark",
    colors_name = "dracula-colorful",
    groups = {
      "Normal",
      "@variable.parameter",
      "@lsp.type.parameter",
      "CmpItemKindFunction",
      "RainbowDelimiterBlue",
    },
  },
  {
    requested = "catppuccin",
    canonical = "catppuccin-macchiato",
    background = "dark",
    colors_name = "catppuccin",
    groups = {
      "Normal",
      "@tag",
      "@lsp.type.enumMember",
      "FloatTitle",
      "MatchParen",
    },
  },
  {
    requested = "catppuccin-macchiato",
    canonical = "catppuccin-macchiato",
    background = "dark",
    colors_name = "catppuccin-macchiato",
    groups = {
      "Normal",
      "@tag.attribute",
      "@lsp.type.property",
      "PmenuSel",
      "DiagnosticWarn",
    },
  },
  {
    requested = "catppuccin-latte",
    canonical = "catppuccin-latte",
    background = "light",
    colors_name = "catppuccin-latte",
    groups = {
      "Normal",
      "@string",
      "@comment.todo",
      "FloatBorder",
      "Visual",
    },
  },
  {
    requested = "tokyonight",
    canonical = "tokyonight-storm",
    background = "dark",
    colors_name = "tokyonight",
    groups = {
      "Normal",
      "@tag",
      "@lsp.type.parameter",
      "FloatTitle",
      "MatchParen",
    },
  },
  {
    requested = "tokyonight-storm",
    canonical = "tokyonight-storm",
    background = "dark",
    colors_name = "tokyonight-storm",
    groups = {
      "Normal",
      "@function",
      "@lsp.type.property",
      "PmenuSel",
      "DiagnosticWarn",
    },
  },
  {
    requested = "tokyonight-day",
    canonical = "tokyonight-day",
    background = "light",
    colors_name = "tokyonight-day",
    groups = {
      "Normal",
      "@string",
      "@comment.todo",
      "FloatBorder",
      "Visual",
    },
  },
  {
    requested = "kanagawa",
    canonical = "kanagawa-wave",
    background = "dark",
    colors_name = "kanagawa",
    groups = {
      "Normal",
      "@tag",
      "@lsp.type.parameter",
      "FloatTitle",
      "MatchParen",
    },
  },
  {
    requested = "kanagawa-dragon",
    canonical = "kanagawa-dragon",
    background = "dark",
    colors_name = "kanagawa-dragon",
    groups = {
      "Normal",
      "@function",
      "@lsp.type.property",
      "PmenuSel",
      "DiagnosticWarn",
    },
  },
  {
    requested = "kanagawa-lotus",
    canonical = "kanagawa-lotus",
    background = "light",
    colors_name = "kanagawa-lotus",
    groups = {
      "Normal",
      "@string",
      "@comment.todo",
      "FloatBorder",
      "Visual",
    },
  },
}

local function expect(condition, message)
  if not condition then
    error(message)
  end
end

local function run_case(case)
  spectra.setup({ theme = case.requested })
  vim.cmd.colorscheme(case.requested)

  local resolved = registry.resolve(case.requested)

  expect(resolved.canonical == case.canonical, ("expected %s to resolve to %s, got %s"):format(case.requested, case.canonical, resolved.canonical))
  expect(vim.o.background == case.background, ("expected background %s for %s, got %s"):format(case.background, case.requested, vim.o.background))
  expect(vim.g.colors_name == case.colors_name, ("expected colors_name %s for %s, got %s"):format(case.colors_name, case.requested, tostring(vim.g.colors_name)))

  for _, group in ipairs(case.groups) do
    expect(vim.fn.hlexists(group) == 1, ("expected highlight group %s to exist for %s"):format(group, case.requested))
  end
end

local ok, err = pcall(function()
  for _, case in ipairs(cases) do
    run_case(case)
  end
end)

if not ok then
  vim.api.nvim_err_writeln("spectra regression failed: " .. err)
  vim.cmd("cq")
  return
end

print("spectra regression ok")
vim.cmd("qa")
