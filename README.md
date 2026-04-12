# spectra.nvim

A progressive palette colorscheme for Neovim 0.12+.

spectra.nvim uses a **5-layer fallback palette** — provide as few as 2 colors (`fg` + `bg`) and get a complete, coherent theme. Add more colors to progressively refine the result.

## Features

- **Progressive palette**: 2 colors produce a usable theme; 75 slots give full control
- **5-layer fallback chain**: base → accent → role → full → variant
- **Built-in themes**: `default`, `dracula-colorful`, `catppuccin-macchiato`, `tokyonight-storm`, `kanagawa-wave`
- **Transparent background** support
- **Dark / Light / Auto** style switching
- **Callbacks** for runtime color and highlight customization
- TreeSitter, LSP, Diagnostic highlight support
- Plugin integrations (Telescope, NvimTree, Gitsigns, indent-blankline)

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "your-username/spectra.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("spectra").setup({})
    vim.cmd("colorscheme spectra")
  end,
}
```

## Quick Start

```lua
-- Minimal: just 2 colors
require("spectra").setup({
  palette = {
    fg = "#d4d4d4",
    bg = "#1e1e1e",
  },
})
vim.cmd("colorscheme spectra")
```

## Using Built-in Themes

```lua
require("spectra").setup({
  theme = "dracula-colorful",  -- or "catppuccin-macchiato", "tokyonight-storm", "kanagawa-wave"
})
vim.cmd("colorscheme spectra")
```

Available themes:

| Theme | Description |
|---|---|
| `default` | Neutral dark theme |
| `dracula-colorful` | Vibrant Dracula variant |
| `catppuccin-macchiato` | Catppuccin Macchiato flavour |
| `tokyonight-storm` | Tokyo Night Storm variant |
| `kanagawa-wave` | Kanagawa Wave variant |

## Configuration

```lua
require("spectra").setup({
  -- Style: "dark", "light", or "auto" (follows vim.o.background)
  style = "dark",

  -- Built-in theme name
  theme = "default",

  -- Set false to skip loading the base theme, only use your palette
  default_theme = true,

  -- Transparent background (for transparent terminals)
  transparent = false,

  -- Override palette colors (merged on top of the theme)
  palette = {
    fg = "#d4d4d4",
    bg = "#1e1e1e",
    ["syntax.keyword"] = "#569cd6",
    ["syntax.function"] = "#dcdcaa",
  },

  -- Style-specific overrides
  dark = {
    ["syntax.comment"] = "#6a9955",
  },
  light = {
    ["syntax.comment"] = "#008000",
  },

  -- Plugin integrations
  plugins = {
    telescope = true,
    nvim_tree = true,
    gitsigns = true,
    indent_blankline = true,
  },

  -- Callback: modify resolved colors before highlight generation
  on_colors = function(colors)
    colors["syntax.comment"] = "#888888"
  end,

  -- Callback: modify highlight groups after generation
  on_highlights = function(highlights, colors)
    highlights.Comment = { fg = colors["syntax.comment"], italic = false }
  end,
})
```

## Palette Layers

The palette is organized in 5 layers. Each layer falls back to the layer above it when a color is not provided.

### Layer 0 — Base (2 slots)

`fg`, `bg`

### Layer 1 — Accent (6 slots)

Semantic accent colors that drive all downstream layers.

`accent.danger`, `accent.success`, `accent.info`, `accent.caution`, `accent.action`, `accent.control`

### Layer 2 — Role (8 slots)

Syntax and diagnostic role colors, derived from accents.

`syntax.keyword`, `syntax.string`, `syntax.function`, `syntax.comment`, `syntax.type`, `diag.error`, `diag.warn`, `diff.add`

### Layer 3 — Full (20 slots)

Complete functional colors for syntax, diagnostics, diffs, and UI.

**Syntax**: `syntax.constant`, `syntax.identifier`, `syntax.special`, `syntax.operator`, `syntax.preproc`

**Diagnostic**: `diag.info`, `diag.hint`, `diag.ok`

**Diff**: `diff.change`, `diff.delete`

**UI**: `ui.cursorline`, `ui.float`, `ui.visual`, `ui.linenr`, `ui.pmenu`, `ui.statusline`, `ui.search`

### Layer 4 — Variant (39 slots)

Fine-grained overrides for specific sub-categories.

**Syntax variants**: `syntax.function.builtin`, `syntax.function.method`, `syntax.type.builtin`, `syntax.type.module`, `syntax.type.constructor`, `syntax.constant.builtin`, `syntax.constant.character`, `syntax.constant.macro`, `syntax.identifier.member`, `syntax.identifier.parameter`, `syntax.identifier.builtin`, `syntax.identifier.field`, `syntax.string.escape`, `syntax.string.special`, `syntax.comment.doc`, `syntax.preproc.include`, `syntax.preproc.macro`, `syntax.tag`, `syntax.label`, `syntax.delimiter`, `syntax.variable`, `syntax.type.definition`

**Diagnostic/Diff variants**: `diag.error.bg`, `diag.error.subtle`, `diag.warn.bg`, `diag.warn.subtle`, `diag.info.bg`, `diag.info.subtle`, `diag.hint.bg`, `diag.hint.subtle`, `diag.ok.bg`, `diag.ok.subtle`, `diff.add.bg`, `diff.change.bg`, `diff.delete.bg`

**UI variants**: `ui.float.bg`, `ui.float.subtle`, `ui.pmenu.bg`, `ui.pmenu.subtle`, `ui.search.bg`, `ui.statusline.bg`, `ui.visual.bg`

## Progressive Example

```lua
-- Tier 1: Just fg + bg → all 75 slots auto-derived
{ fg = "#c0caf5", bg = "#1a1b26" }

-- Tier 3: Add 6 accents → syntax, diagnostics, diffs all follow
{
  fg = "#c0caf5", bg = "#1a1b26",
  ["accent.danger"]  = "#f7768e",
  ["accent.success"] = "#9ece6a",
  ["accent.info"]    = "#7aa2f7",
  ["accent.caution"] = "#e0af68",
  ["accent.action"]  = "#7aa2f7",
  ["accent.control"] = "#bb9af7",
}

-- Tier 6: Override specific variants for fine control
{
  fg = "#c0caf5", bg = "#1a1b26",
  ["accent.control"] = "#bb9af7",
  ["syntax.keyword"] = "#bb9af7",
  ["syntax.function.builtin"] = "#7dcfff",
  ["syntax.type.builtin"] = "#73daca",
  ["syntax.string.escape"] = "#f7768e",
}
```

## License

MIT
