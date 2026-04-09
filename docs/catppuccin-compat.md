# Catppuccin Compatibility Notes for `spectra.nvim`

This document describes how the Catppuccin flavours are integrated into `spectra.nvim` and where they differ from the source `catppuccin.nvim` plugin.

Supported built-in flavours:

- `catppuccin-mocha`
- `catppuccin-macchiato`
- `catppuccin-frappe`
- `catppuccin-latte`

## Summary

The `spectra.nvim` Catppuccin flavours are implemented as built-in themes on top of the shared `spectra` runtime.

That means:

- flavour palettes are imported directly from the Catppuccin palette definitions
- semantic role mappings are family-level and shared across the four flavours
- editor, syntax, TreeSitter, LSP, semantic token, and plugin integration support still come from the `spectra` engine
- only a minimal set of Catppuccin-specific overrides is added where the shared runtime would otherwise drift too far from Catppuccin visual intent

## Matched Well

These areas are intentionally close to the source Catppuccin flavours:

- flavour palette identity for `mocha`, `macchiato`, `frappe`, and `latte`
- light vs dark background mode, including `latte` loading as a light theme
- core semantic color intent:
  - keywords use Catppuccin mauve-family accents
  - functions use Catppuccin blue-family accents
  - types use yellow-family accents
  - strings use green-family accents
  - parameters use maroon accents
  - fields and properties use lavender-family accents
  - comments use overlay tones
- core editor presentation for each flavour through direct colorscheme entrypoints such as `:colorscheme catppuccin-mocha`

## Partially Matched

These areas are supported, but their exact behaviour still follows the shared `spectra` engine more than the original Catppuccin plugin:

- TreeSitter coverage:
  - the Catppuccin flavours inherit `spectra`'s shared modern capture coverage
  - a targeted override layer adjusts notable Catppuccin categories such as tags, attributes, parameters, constants, markdown headings, and selected CSS/HTML cases
- semantic token behaviour:
  - the flavours inherit `spectra`'s shared semantic token model
  - a small override layer adjusts selected Catppuccin-oriented cases such as enum members, readonly variables, properties, and parameters
- plugin integrations:
  - the flavours work with the integrations already supported by `spectra`
  - the resulting colours are Catppuccin-like, but they are not a full reproduction of the much broader original `catppuccin.nvim` integration matrix

## Intentionally Not Fully Matched

These differences are currently intentional:

- `spectra.nvim` does not attempt to duplicate the full internal implementation of `catppuccin.nvim`
- `spectra.nvim` keeps one shared TreeSitter query asset set instead of introducing Catppuccin-specific query files
- some UI details still follow shared `spectra` runtime conventions rather than the exact Catppuccin plugin implementation
- many long-tail plugin integrations from `catppuccin.nvim` are still outside the scope of `spectra.nvim`

## Notable Missing or Deferred Details

The following items are still deferred or incomplete relative to the source Catppuccin plugin:

- the original Catppuccin plugin's large integration matrix is not fully ported
- Catppuccin-specific query assets are not provided; the flavours rely on shared `spectra` query refinements
- some less central highlight categories still inherit generalized `spectra` slot behaviour rather than hand-tuned Catppuccin values
- no promise is made yet that every source Catppuccin highlight group has a one-to-one equivalent in `spectra`

## Why This Tradeoff Exists

The point of these flavours is to validate that `spectra` can host a second theme family without forking its runtime per theme.

That requires keeping:

- one shared engine
- one shared fallback model
- one shared query strategy

instead of embedding a mostly separate copy of `catppuccin.nvim`.

## Validation Performed

The following checks were completed during integration:

- all four flavours load through direct colorscheme names
- `catppuccin-latte` correctly switches Neovim background mode to `light`
- key highlight groups such as TreeSitter parameter captures and completion-item function groups are present after theme load
- the implementation does not introduce theme-specific query assets

## Practical Reading of the Result

If you want:

- Catppuccin palettes and flavour identity inside the `spectra` engine
- unified TreeSitter, LSP, semantic token, and integration support across theme families

then this integration is the intended result.

If you want:

- the full original Catppuccin plugin behaviour
- every original integration and internal nuance reproduced exactly

then there is still follow-up work to do, and those gaps should be treated as explicit future enhancements rather than hidden regressions.
