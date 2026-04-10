# Kanagawa Compatibility in `spectra.nvim`

This document explains how the built-in Kanagawa family in `spectra.nvim` relates to the upstream `kanagawa.nvim` plugin.

The current built-in flavours are:

- `kanagawa-wave`
- `kanagawa-dragon`
- `kanagawa-lotus`

The family-level entry `kanagawa` resolves to `kanagawa-wave`.

## What Is Closely Matched

- The three core Kanagawa flavour identities are preserved as separate built-in themes.
- `wave` and `dragon` remain dark themes, while `lotus` keeps its light background mode.
- The family default behaves consistently: `:colorscheme kanagawa` loads `kanagawa-wave`.
- Shared `spectra` support for TreeSitter, LSP, semantic tokens, and integrations applies to all Kanagawa flavours.

## What Is Partially Matched

- Semantic color intent is adapted into the `spectra` role-first runtime rather than copied group-for-group from upstream.
- Editor UI groups, syntax groups, TreeSitter groups, and semantic token groups are tuned to read as Kanagawa, but they still pass through shared `spectra` generators.
- Plugin integration styling follows the shared `spectra` integration layer, so Kanagawa-specific plugin refinements from upstream may differ.

## What Is Intentionally Different

- `spectra.nvim` does not reproduce the full `kanagawa.nvim` configuration surface in this phase.
- Theme behavior is constrained by `spectra`'s shared fallback chain and stable role contract.
- No Kanagawa-specific `after/queries` assets are introduced; query refinements remain shared engine assets.

## Current Gaps

- Some upstream plugin-specific highlight nuances are not reproduced exactly.
- Some palette emphasis choices are approximated so they fit the shared `spectra` role model.
- Advanced Kanagawa options such as compile-time caching, per-theme override DSLs, or broader integration coverage remain out of scope.

## Coverage Summary

- Palette fidelity: strong family-level match for `wave`, `dragon`, and `lotus`
- TreeSitter coverage: shared `spectra` coverage with Kanagawa-specific semantic tuning
- LSP and semantic token coverage: shared `spectra` coverage with Kanagawa-oriented overrides
- Plugin integrations: shared `spectra` integration styling, not a full upstream reproduction

This means the Kanagawa family in `spectra.nvim` should be understood as a Kanagawa-inspired built-in family running on the shared `spectra` engine, not as a byte-for-byte embed of the upstream plugin.
