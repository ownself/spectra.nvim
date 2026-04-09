# Tokyonight Compatibility in `spectra.nvim`

This document explains how the built-in Tokyonight family in `spectra.nvim` relates to the upstream `tokyonight.nvim` plugin.

The current built-in flavours are:

- `tokyonight-moon`
- `tokyonight-storm`
- `tokyonight-night`
- `tokyonight-day`

The family-level entry `tokyonight` resolves to `tokyonight-moon`.

## What Is Closely Matched

- The four Tokyonight flavour identities are preserved as separate built-in themes.
- Each flavour uses its own Tokyonight-derived palette and background mode.
- The family default behaves consistently: `:colorscheme tokyonight` loads `tokyonight-moon`.
- Shared `spectra` support for TreeSitter, LSP, semantic tokens, and integrations applies to all Tokyonight flavours.

## What Is Partially Matched

- Semantic color intent is adapted into the `spectra` role-first runtime rather than copied group-for-group from upstream.
- Editor UI groups, syntax groups, TreeSitter groups, and semantic token groups are tuned to read as Tokyonight, but still pass through shared `spectra` generators.
- Plugin integration styling follows the shared `spectra` integration layer, so plugin-specific Tokyonight refinements may differ from upstream.

## What Is Intentionally Different

- `spectra.nvim` does not reproduce the full `tokyonight.nvim` configuration surface in this phase.
- Theme behavior is constrained by `spectra`'s shared fallback chain and stable role contract.
- No Tokyonight-specific `after/queries` assets are introduced; query refinements remain shared engine assets.

## Current Gaps

- Some upstream plugin-specific highlight nuances are not reproduced exactly.
- Some palette emphasis choices are approximated so they fit the shared `spectra` role model.
- Advanced Tokyonight options outside the current `spectra` theme contract are still out of scope.

## Coverage Summary

- Palette fidelity: strong family-level match
- TreeSitter coverage: shared `spectra` coverage with Tokyonight role tuning
- LSP and semantic token coverage: shared `spectra` coverage with Tokyonight-specific semantic overrides
- Plugin integrations: shared `spectra` integration styling, not a full upstream reproduction

This means the Tokyonight family in `spectra.nvim` should be understood as a Tokyonight-inspired built-in family running on the shared `spectra` engine, not as a byte-for-byte embed of the upstream plugin.
