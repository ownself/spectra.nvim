# spectra.nvim

A Neovim 0.12+ semantic colorscheme engine with first-class TreeSitter and LSP support.

The built-in themes currently include `dracula-colorful`, four Catppuccin flavours, four Tokyonight flavours, and three Kanagawa flavours.

## Goals

- keep the high-fidelity Rider-inspired `dracula-colorful` rendering
- share TreeSitter, LSP, semantic token, and integration support across themes
- let new themes plug into a role-first contract instead of copying the whole runtime
- provide a reusable theme engine with first-party built-in theme families

## First-Phase Scope

The current `spectra.nvim` phase delivers:

- a shared engine runtime under `lua/spectra/`
- a built-in theme registry
- `dracula-colorful` as the first built-in theme
- `catppuccin-mocha`, `catppuccin-macchiato`, `catppuccin-frappe`, and `catppuccin-latte` as a second built-in theme family
- `tokyonight-moon`, `tokyonight-storm`, `tokyonight-night`, and `tokyonight-day` as a third built-in theme family
- `kanagawa-wave`, `kanagawa-dragon`, and `kanagawa-lotus` as a fourth built-in theme family
- shared `after/queries` language refinements
- shared editor, syntax, TreeSitter, LSP, semantic token, and integration modules
- migrated fixtures and headless validation helpers

## Installation

Lazy.nvim example:

```lua
{
  dir = "ownself/spectra.nvim",
  name = "spectra.nvim",
  priority = 1000,
  config = function()
    require("spectra").setup({
      theme = "catppuccin-mocha",
      transparent_background = false,
      styles = {
        comments = { "italic" },
        parameters = { "italic" },
      },
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
```

## Theme Contract

Each built-in theme is expected to provide:

- `meta`: public identity and background mode
- `palette`: raw color slots and terminal colors
- `roles`: semantic role mapping derived from the palette
- `overrides`: optional scoped overrides for shared runtime modules

The engine owns the shared highlighting runtime. Themes primarily describe color intent rather than reimplementing the whole stack.

The registry now models three distinct concepts:

- canonical themes such as `dracula-colorful`, `catppuccin-macchiato`, `tokyonight-moon`, and `kanagawa-wave`
- theme families such as `catppuccin`, `tokyonight`, and `kanagawa`
- aliases that can resolve to canonical themes without duplicating theme definitions

`catppuccin` is resolved as a family-level name and currently defaults to `catppuccin-macchiato`.
`tokyonight` is resolved as a family-level name and currently defaults to `tokyonight-moon`.
`kanagawa` is resolved as a family-level name and currently defaults to `kanagawa-wave`.

For a step-by-step guide to adding a new built-in theme, see [docs/adding-a-theme.md](./docs/adding-a-theme.md).
中文版本见 [docs/adding-a-theme.zh-CN.md](./docs/adding-a-theme.zh-CN.md)。
架构导读见 [docs/architecture.zh-CN.md](./docs/architecture.zh-CN.md)。
Catppuccin family compatibility notes are documented in [docs/catppuccin-compat.md](./docs/catppuccin-compat.md)。
中文版本见 [docs/catppuccin-compat.zh-CN.md](./docs/catppuccin-compat.zh-CN.md)。
Tokyonight family compatibility notes are documented in [docs/tokyonight-compat.md](./docs/tokyonight-compat.md)。
中文版本见 [docs/tokyonight-compat.zh-CN.md](./docs/tokyonight-compat.zh-CN.md)。
Kanagawa family compatibility notes are documented in [docs/kanagawa-compat.md](./docs/kanagawa-compat.md)。
中文版本见 [docs/kanagawa-compat.zh-CN.md](./docs/kanagawa-compat.zh-CN.md)。

## Fallback Order

Highlight resolution follows this order:

1. language-specific override
2. semantic token override
3. TreeSitter capture mapping
4. semantic role mapping
5. base palette default

This keeps the shared query and semantic runtime intact while allowing themes to stay compact.

## Built-in Theme: dracula-colorful

`dracula-colorful` still uses Rider `Dracula Colorful` as the primary semantic reference.

Intentional departures from `dracula.vim` remain:

- comments are brighter blue to match Rider's comment rendering
- identifiers and parameters use a muted foreground instead of classic Dracula white or orange
- fields and properties are orange
- classes, interfaces, and namespaces are cyan
- constants and static symbols are purple

## Built-in Theme Family: Catppuccin

The following Catppuccin flavours are available:

- `catppuccin-mocha`
- `catppuccin-macchiato`
- `catppuccin-frappe`
- `catppuccin-latte`

These flavours reuse the shared `spectra` runtime while importing the original Catppuccin flavour palettes and family-level semantic intent.

Family default:

- `:colorscheme catppuccin` loads `catppuccin-macchiato`

Example:

```lua
require("spectra").setup({
  theme = "catppuccin-latte",
})
vim.cmd.colorscheme("catppuccin-latte")
```

For differences from the source `catppuccin.nvim` plugin, see [docs/catppuccin-compat.md](./docs/catppuccin-compat.md).
中文说明见 [docs/catppuccin-compat.zh-CN.md](./docs/catppuccin-compat.zh-CN.md)。

## Built-in Theme Family: Tokyonight

The following Tokyonight flavours are available:

- `tokyonight-moon`
- `tokyonight-storm`
- `tokyonight-night`
- `tokyonight-day`

These flavours also reuse the shared `spectra` runtime while importing Tokyonight-inspired palette identity and semantic intent.

Family default:

- `:colorscheme tokyonight` loads `tokyonight-moon`

Example:

```lua
require("spectra").setup({
  theme = "tokyonight",
})
vim.cmd.colorscheme("tokyonight")
```

For differences from the source `tokyonight.nvim` plugin, see [docs/tokyonight-compat.md](./docs/tokyonight-compat.md).
中文说明见 [docs/tokyonight-compat.zh-CN.md](./docs/tokyonight-compat.zh-CN.md)。

## Built-in Theme Family: Kanagawa

The following Kanagawa flavours are available:

- `kanagawa-wave`
- `kanagawa-dragon`
- `kanagawa-lotus`

These flavours reuse the shared `spectra` runtime while preserving Kanagawa-inspired palette identity, semantic layering, and the original dark/light family split.

Family default:

- `:colorscheme kanagawa` loads `kanagawa-wave`

Example:

```lua
require("spectra").setup({
  theme = "kanagawa",
})
vim.cmd.colorscheme("kanagawa")
```

For differences from the source `kanagawa.nvim` plugin, see [docs/kanagawa-compat.md](./docs/kanagawa-compat.md).
中文说明见 [docs/kanagawa-compat.zh-CN.md](./docs/kanagawa-compat.zh-CN.md)。

## Known Fidelity Gaps

- IntelliJ exposes token categories that Neovim cannot represent uniformly.
- Semantic token fidelity depends on the language server.
- Some Rider visuals come from IDE behavior rather than colorscheme data.

## Development

Architecture walkthrough:

- start with [docs/architecture.zh-CN.md](./docs/architecture.zh-CN.md)

Minimal headless check:

```powershell
nvim --headless -u tests/minimal_init.lua "+colorscheme dracula-colorful" "+qa"
```

Baseline regression suite:

```powershell
nvim --headless -u tests/minimal_init.lua "+luafile tests/regression.lua"
```

The regression suite currently checks:

- canonical theme loading
- family default resolution for `catppuccin`
- family default resolution for `tokyonight`
- family default resolution for `kanagawa`
- background mode for dark and light themes
- a stable set of shared highlight groups across runtime modules
