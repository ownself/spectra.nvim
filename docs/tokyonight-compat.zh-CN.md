# `spectra.nvim` 中的 Tokyonight 兼容性说明

本文档说明 `spectra.nvim` 内建的 Tokyonight family 与上游 `tokyonight.nvim` 插件之间的关系。

当前内建 flavour 包括：

- `tokyonight-moon`
- `tokyonight-storm`
- `tokyonight-night`
- `tokyonight-day`

family 级入口 `tokyonight` 默认会解析到 `tokyonight-moon`。

## 哪些部分复现得比较好

- Tokyonight 的四个 flavour 都以独立内建主题身份保留下来。
- 每个 flavour 都使用各自的 Tokyonight 风格 palette 和背景模式。
- family 默认行为已经接通：`:colorscheme tokyonight` 会加载 `tokyonight-moon`。
- `spectra` 共享的 TreeSitter、LSP、semantic token 和 integration 支持会统一覆盖到所有 Tokyonight flavour。

## 哪些部分属于部分复现

- 主题语义是通过 `spectra` 的 role-first 运行时重新映射的，而不是逐组照搬上游实现。
- 编辑器 UI、基础语法、TreeSitter 和 semantic token 高亮都尽量调整为 Tokyonight 风格，但最终仍然经过共享 `spectra` 生成器。
- 插件集成样式沿用 `spectra` 的共享 integration 层，因此某些上游 Tokyonight 的插件细节可能不会完全一致。

## 哪些差异是当前阶段有意保留的

- 第一阶段不会完整复制 `tokyonight.nvim` 的全部配置面。
- 主题行为仍受 `spectra` 共享 fallback 链和稳定 role 契约约束。
- 当前没有引入 Tokyonight 专属 `after/queries` 资产，query 细化依然属于引擎级共享资产。

## 当前仍存在的缺口

- 一些上游插件级高亮细节还没有做到完全一致。
- 某些 palette 强调关系为了适配共享 role 模型做了近似处理。
- 超出当前 `spectra` 主题契约的 Tokyonight 高级选项仍然暂不支持。

## 覆盖状态总结

- palette 复现：family 级别匹配度较高
- TreeSitter 覆盖：使用共享 `spectra` 能力，并叠加 Tokyonight 风格 roles
- LSP 与 semantic token 覆盖：使用共享 `spectra` 能力，并补充 Tokyonight 语义 override
- 插件集成：沿用共享 `spectra` integration 样式，并非完全照搬上游实现

因此，`spectra.nvim` 中的 Tokyonight 更准确的理解应是：运行在共享 `spectra` 引擎之上的 Tokyonight 风格内建 family，而不是把上游插件逐字节嵌入进来。
