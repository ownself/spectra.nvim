# Adding a Theme to `spectra.nvim`

This document describes how to add a new built-in theme to `spectra.nvim`.

The current reference implementation is [`dracula_colorful.lua`](../lua/spectra/themes/dracula_colorful.lua).

## Overview

In the first phase of `spectra.nvim`, a theme does not reimplement the whole colorscheme runtime.

The engine already owns:

- editor UI highlight generation
- base syntax highlight generation
- TreeSitter highlight generation
- LSP diagnostic and UI highlights
- semantic token highlights
- supported plugin integrations
- shared `after/queries` language refinements

A theme is mainly responsible for describing color intent.

## Where to Add a Theme

1. Create a new file under:

```text
lua/spectra/themes/<theme_name>.lua
```

Example:

```text
lua/spectra/themes/gruvbox_soft.lua
```

2. Register it in:

[`lua/spectra/registry.lua`](../lua/spectra/registry.lua)

Example:

```lua
local registry = {
  themes = {
    ["dracula-colorful"] = {
      module = "spectra.themes.dracula_colorful",
    },
    ["gruvbox-soft"] = {
      module = "spectra.themes.gruvbox_soft",
    },
  },
}
```

If the theme belongs to a family, register the canonical theme in `themes` and the family default in `families` instead of duplicating flat entries.

3. If you want users to load it directly with `:colorscheme <name>`, add a matching file under:

```text
colors/<theme-name>.lua
```

Example:

```lua
require("spectra").load("gruvbox-soft")
```

## Theme File Format

A theme module returns a table with four main parts:

- `meta`
- `palette`
- `roles`
- `overrides`

Minimal template:

```lua
local M = {}

function M.palette()
  return {
    bg = "#101010",
    bg_dark = "#0B0B0B",
    bg_darker = "#080808",
    bg_float = "#181818",
    bg_visual = "#2A2A2A",
    bg_cursorline = "#141414",
    bg_selection = "#2A2A2A",
    fg = "#EAEAEA",
    fg_muted = "#B8B8B8",
    fg_parameter = "#D0B0FF",
    comment = "#7FA0C8",
    subtle = "#7A7A7A",
    cyan = "#7DD3FC",
    green = "#86EFAC",
    orange = "#FDBA74",
    amber = "#FCD34D",
    pink = "#F9A8D4",
    purple = "#C4B5FD",
    red = "#F87171",
    yellow = "#FDE68A",
    sky = "#93C5FD",
    teal = "#5EEAD4",
    gutter = "#202020",
    guide = "#303030",
    border = "#505050",
    braces = "#93C5FD",
    brackets = "#86EFAC",
    parens = "#FDE68A",
    rainbow = {
      "#C4B5FD",
      "#F9A8D4",
      "#FDBA74",
      "#86EFAC",
      "#7DD3FC",
    },
    none = "NONE",
    terminal = {
      "#101010",
      "#F87171",
      "#86EFAC",
      "#FDE68A",
      "#C4B5FD",
      "#F9A8D4",
      "#7DD3FC",
      "#EAEAEA",
      "#606060",
      "#FB7185",
      "#A7F3D0",
      "#FDE68A",
      "#DDD6FE",
      "#FBCFE8",
      "#A5F3FC",
      "#FFFFFF",
    },
  }
end

function M.roles(C, O)
  local styles = O.styles or {}

  return {
    text = { fg = C.fg },
    identifier = { fg = C.fg_muted },
    local_variable = { fg = C.fg_muted },
    builtin_variable = { fg = "#C4B5FD" },
    comment = { fg = C.comment, italic = vim.tbl_contains(styles.comments or {}, "italic") },
    keyword = { fg = C.pink },
    preproc = { fg = C.pink },
    function_name = { fg = C.green },
    function_builtin = { fg = C.cyan },
    type = { fg = C.cyan },
    builtin_type = { fg = C.cyan },
    type_parameter = { fg = "#C4B5FD" },
    constructor = { fg = C.cyan },
    parameter = { fg = C.fg_parameter, italic = vim.tbl_contains(styles.parameters or {}, "italic") },
    label = { fg = C.subtle },
    field = { fg = C.orange },
    property = { fg = C.amber },
    constant = { fg = C.purple, bold = true },
    macro = { fg = C.purple },
    string = { fg = C.yellow },
    character = { fg = C.yellow },
    number = { fg = C.purple },
    escape = { fg = C.orange },
    regexp = { fg = C.pink },
    special = { fg = C.orange },
    tag = { fg = C.pink },
    attribute = { fg = C.green },
    operator = { fg = C.pink },
    module = { fg = C.cyan },
    uri = { fg = C.cyan, underline = true },
    todo = { fg = C.bg, bg = C.pink, bold = true },
    diagnostic_error = { fg = C.red },
    diagnostic_warn = { fg = C.orange },
    diagnostic_info = { fg = C.cyan },
    diagnostic_hint = { fg = C.sky },
    ui_border = { fg = C.border },
    ui_selection = { bg = C.bg_selection },
    ui_menu = { fg = C.fg, bg = C.bg_float },
  }
end

M.meta = {
  name = "gruvbox-soft",
  colorscheme = "gruvbox-soft",
  background = "dark",
}

M.overrides = {
  modules = {},
  integrations = {},
  languages = {},
}

return M
```

## Field Reference

### `meta`

`meta` defines the public identity of the theme.

Expected fields:

- `name`: internal theme name used by the engine
- `colorscheme`: name exposed through `:colorscheme`
- `background`: usually `"dark"` or `"light"`

Example:

```lua
M.meta = {
  name = "dracula-colorful",
  colorscheme = "dracula-colorful",
  background = "dark",
}
```

### `palette()`

`palette()` returns the raw color slots consumed by the shared runtime.

The shared runtime now prefers semantic roles first. The stable palette contract is intentionally narrower and mainly covers low-level UI and delimiter needs:

- backgrounds: `bg`, `bg_dark`, `bg_darker`, `bg_float`, `bg_cursorline`, `bg_selection`
- foregrounds: `fg`, `fg_muted`, `fg_parameter`
- UI support: `subtle`, `gutter`, `guide`, `border`
- delimiter colors: `braces`, `brackets`, `parens`, `rainbow`
- special values: `none`, `terminal`

Extra palette keys are still allowed, but new shared modules should avoid depending on them when the same decision can be expressed through `roles()`.

## `roles(C, O)`

`roles()` translates raw palette values into semantic intent.

This is the main place where a theme expresses its character:

- how comments should look
- whether parameters differ from identifiers
- whether fields and properties should diverge
- how diagnostics should read visually

The shared runtime consumes these semantic roles and applies them across editor, TreeSitter, LSP, semantic tokens, and integrations.

Recommended base roles:

- `text`
- `identifier`
- `local_variable`
- `builtin_variable`
- `comment`
- `keyword`
- `preproc`
- `function_name`
- `function_builtin`
- `type`
- `builtin_type`
- `type_parameter`
- `constructor`
- `parameter`
- `label`
- `field`
- `property`
- `constant`
- `macro`
- `string`
- `character`
- `number`
- `escape`
- `regexp`
- `special`
- `tag`
- `attribute`
- `operator`
- `module`
- `uri`
- `todo`
- `diagnostic_error`
- `diagnostic_warn`
- `diagnostic_info`
- `diagnostic_hint`
- `ui_border`
- `ui_selection`
- `ui_menu`

## `overrides`

`overrides` is optional. Use it only when the shared runtime is not enough.

Supported keys are now separated by scope:

- `modules`
- `integrations`
- `languages`
- `all`

`modules` accepts the shared module names:

- `editor`
- `syntax`
- `treesitter`
- `lsp`
- `semantic_tokens`
- `integrations`

Each provider can be a function:

```lua
function(C, R, O)
  return {
    GroupName = { fg = C.orange, bold = true },
  }
end
```

Example:

```lua
M.overrides = {
  modules = {
    editor = function(C)
      return {
        FloatTitle = { fg = C.orange, bold = true },
      }
    end,
  },
  integrations = {
    cmp = function(C)
      return {
        CmpItemKindFunction = { fg = C.orange, bold = true },
      }
    end,
  },
}
```

`languages` is reserved for future language-category overrides. The current runtime normalizes and carries it forward so theme files do not need another shape change later, but the first pass does not add a heavy language override DSL.

Use overrides sparingly. If a color decision belongs to a semantic role, prefer changing `roles()` instead.

## Fallback Order

The engine resolves highlighting in this order:

1. language-specific override
2. semantic token override
3. TreeSitter capture mapping
4. semantic role mapping
5. base palette default

This means a new theme does not need to define every specialized case up front.

## What Stays Shared

By default, a new theme automatically inherits:

- shared TreeSitter group coverage
- shared semantic token coverage
- shared LSP groups
- shared plugin integrations
- shared `after/queries/<language>/highlights.scm` files

In other words, the query files are framework assets, not per-theme color definitions.

## Recommended Workflow

1. Copy [`dracula_colorful.lua`](../lua/spectra/themes/dracula_colorful.lua) to a new theme file.
2. Rename `meta.name` and `meta.colorscheme`.
3. Replace the palette with your new colors.
4. Adjust `roles()` until the semantic relationships feel right.
5. Register the theme in [`registry.lua`](../lua/spectra/registry.lua).
6. Add `colors/<theme-name>.lua` if you want direct `:colorscheme` support.
7. Run a headless check:

```powershell
nvim --headless -u tests/minimal_init.lua "+colorscheme <theme-name>" "+qa"
```

8. Inspect target languages with the fixture files in [`tests/fixtures`](../tests/fixtures/).
9. Run the baseline regression suite before merging:

```powershell
nvim --headless -u tests/minimal_init.lua "+luafile tests/regression.lua"
```

## Practical Advice

- Start by changing palette and roles only.
- Do not add per-theme query files unless there is a clear semantic need.
- Prefer semantic consistency over one-language perfection.
- If you need many overrides to make a theme work, the shared runtime may need improvement rather than the theme needing more patching.

## Current Limitations

- Some low-level UI and delimiter groups still rely on stable palette slots.
- Theme-specific query assets are intentionally out of scope for the first phase.
- The second built-in theme will be the real test of whether the current contract is wide enough.
