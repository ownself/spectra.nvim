# Highlight Classification Index

输入来源：`highlight_default.txt`。

这套文档按统一规则把当前 Neovim session 中 `:highlight` 输出的组拆成多个部分，便于逐步阅读和维护。

## Parts

- [Part 1: Core Editor UI](./01-core-editor-ui.md)
- [Part 2: Core Syntax And Vim Internals](./02-core-syntax-and-vim-internals.md)
- [Part 3: TreeSitter](./03-treesitter.md)
- [Part 4: LSP And Diagnostics](./04-lsp-and-diagnostics.md)
- [Part 5: Supported Integrations](./05-supported-integrations.md)
- [Part 6: External Plugin Groups](./06-external-plugin-groups.md)
- [Part 7: DevIcons](./07-devicons.md)

## Notes

- `必设置 / 可选 / 不必要` 是站在 `spectra.nvim` 这种共享主题框架的角度做的工程化分类，不是 Neovim 官方强制级别。
- 动态实例组、状态栏自动拼接组、通知系统实例组，统一倾向归入 `不必要`。
- 受支持插件集成统一归入 `可选`，因为它们有价值，但不属于没有就无法使用主题的基础路径。

## Counts

| Part | Entries |
| --- | ---: |
| Part 1: Core Editor UI | 243 |
| Part 2: Core Syntax And Vim Internals | 176 |
| Part 3: TreeSitter | 58 |
| Part 4: LSP And Diagnostics | 64 |
| Part 5: Supported Integrations | 219 |
| Part 6: External Plugin Groups | 343 |
| Part 7: DevIcons | 651 |