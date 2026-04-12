--- Third-party plugin highlight group definitions.
--- Supports: telescope.nvim, nvim-tree.lua, gitsigns.nvim, indent-blankline.nvim
--- Each plugin's groups are conditionally included based on config.plugins toggles.
--- @module spectra.groups.plugins

local M = {}

--- Telescope highlight groups.
--- @param p table<string, string> Resolved palette
--- @return table<string, table>
local function telescope(p)
  return {
    TelescopeNormal       = { bg = p["ui.float"] },
    TelescopeBorder       = { fg = p["ui.linenr"], bg = p["ui.float"] },
    TelescopeTitle        = { fg = p.fg, bold = true },
    TelescopeSelection    = { bg = p["ui.cursorline"] },
    TelescopeSelectionCaret = { fg = p["accent.action"] },
    TelescopeMultiSelection = { fg = p["accent.info"] },
    TelescopeMatching     = { fg = p["accent.caution"], bold = true },
    TelescopePromptNormal = { bg = p["ui.float"] },
    TelescopePromptBorder = { fg = p["ui.linenr"], bg = p["ui.float"] },
    TelescopePromptTitle  = { fg = p.fg, bold = true },
    TelescopePromptPrefix = { fg = p["accent.action"] },
    TelescopePromptCounter = { fg = p["ui.linenr"] },
    TelescopeResultsNormal = { bg = p["ui.float"] },
    TelescopeResultsBorder = { fg = p["ui.linenr"], bg = p["ui.float"] },
    TelescopeResultsTitle  = { fg = p.fg, bold = true },
    TelescopePreviewNormal = { bg = p["ui.float"] },
    TelescopePreviewBorder = { fg = p["ui.linenr"], bg = p["ui.float"] },
    TelescopePreviewTitle  = { fg = p.fg, bold = true },
  }
end

--- nvim-tree highlight groups.
--- @param p table<string, string> Resolved palette
--- @return table<string, table>
local function nvim_tree(p)
  return {
    NvimTreeNormal        = { bg = p["ui.float"] },
    NvimTreeEndOfBuffer   = { fg = p["ui.float"] },
    NvimTreeRootFolder    = { fg = p["accent.action"], bold = true },
    NvimTreeFolderName    = { fg = p["syntax.function"] },
    NvimTreeFolderIcon    = { fg = p["accent.action"] },
    NvimTreeOpenedFolderName = { fg = p["syntax.function"], bold = true },
    NvimTreeEmptyFolderName  = { fg = p["ui.linenr"] },
    NvimTreeFileName      = { fg = p.fg },
    NvimTreeSpecialFile   = { fg = p["syntax.special"], underline = true },
    NvimTreeImageFile     = { fg = p["syntax.special"] },
    NvimTreeIndentMarker  = { fg = p["ui.linenr"] },
    NvimTreeGitDirty      = { fg = p["diff.change"] },
    NvimTreeGitNew        = { fg = p["diff.add"] },
    NvimTreeGitDeleted    = { fg = p["diff.delete"] },
    NvimTreeGitRenamed    = { fg = p["diff.change"] },
    NvimTreeGitStaged     = { fg = p["diff.add"] },
    NvimTreeGitMerge      = { fg = p["accent.caution"] },
    NvimTreeWindowPicker  = { fg = p.fg, bg = p["ui.visual"], bold = true },
  }
end

--- gitsigns highlight groups.
--- @param p table<string, string> Resolved palette
--- @return table<string, table>
local function gitsigns(p)
  return {
    GitSignsAdd              = { fg = p["diff.add"] },
    GitSignsChange           = { fg = p["diff.change"] },
    GitSignsDelete           = { fg = p["diff.delete"] },
    GitSignsAddNr            = { fg = p["diff.add"] },
    GitSignsChangeNr         = { fg = p["diff.change"] },
    GitSignsDeleteNr         = { fg = p["diff.delete"] },
    GitSignsAddLn            = { bg = p["diff.add.bg"] },
    GitSignsChangeLn         = { bg = p["diff.change.bg"] },
    GitSignsDeleteLn         = { bg = p["diff.delete.bg"] },
    GitSignsAddInline        = { bg = p["diff.add.bg"] },
    GitSignsChangeInline     = { bg = p["diff.change.bg"] },
    GitSignsDeleteInline     = { bg = p["diff.delete.bg"] },
    GitSignsCurrentLineBlame = { fg = p["ui.linenr"], italic = true },
  }
end

--- indent-blankline highlight groups.
--- @param p table<string, string> Resolved palette
--- @return table<string, table>
local function indent_blankline(p)
  return {
    IblIndent = { fg = p["ui.linenr"] },
    IblScope  = { fg = p["accent.action"] },
    -- Legacy v2 names (still used by some configs)
    IndentBlanklineChar             = { fg = p["ui.linenr"], nocombine = true },
    IndentBlanklineContextChar      = { fg = p["accent.action"], nocombine = true },
    IndentBlanklineSpaceChar        = { link = "IndentBlanklineChar" },
    IndentBlanklineSpaceCharBlankline = { link = "IndentBlanklineChar" },
  }
end

--- Generate plugin highlight groups from resolved palette.
--- Only includes groups for plugins enabled in config.plugins.
--- @param p table<string, string> Resolved palette
--- @param config table spectra.nvim config
--- @return table<string, table> HG definitions
function M.get(p, config)
  local groups = {}
  local plugins = config.plugins or {}

  local plugin_map = {
    telescope = telescope,
    nvim_tree = nvim_tree,
    gitsigns = gitsigns,
    indent_blankline = indent_blankline,
  }

  for name, generator in pairs(plugin_map) do
    if plugins[name] ~= false then
      local hgs = generator(p)
      for group, def in pairs(hgs) do
        groups[group] = def
      end
    end
  end

  return groups
end

return M
