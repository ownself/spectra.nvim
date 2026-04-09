# `spectra.nvim` 中的 Catppuccin 兼容性说明

本文档说明 `catppuccin` 四个 flavour 在 `spectra.nvim` 中是如何集成的，以及它们与原版 `catppuccin.nvim` 插件相比有哪些差异。

当前支持的内建 flavour：

- `catppuccin-mocha`
- `catppuccin-macchiato`
- `catppuccin-frappe`
- `catppuccin-latte`

## 概要

`spectra.nvim` 中的 Catppuccin flavour，是作为内建主题构建在共享 `spectra` 运行时之上的。

这意味着：

- flavour 的 palette 直接来源于 Catppuccin 的原始 palette 定义
- semantic role 映射按“主题家族”层面统一设计，并在四个 flavour 间共享
- editor、syntax、TreeSitter、LSP、semantic token 和 plugin integration 支持仍然来自 `spectra` 引擎
- 只有在共享运行时明显偏离 Catppuccin 视觉意图时，才增加了少量 Catppuccin 专属 override

## 复现得比较好的部分

以下内容刻意尽量贴近原版 Catppuccin flavour：

- `mocha`、`macchiato`、`frappe`、`latte` 四个 flavour 的 palette 身份
- light / dark 背景模式，包括 `latte` 作为浅色主题正确加载
- 核心语义配色意图：
  - keywords 使用 Catppuccin 的 mauve 系
  - functions 使用 Catppuccin 的 blue 系
  - types 使用 yellow 系
  - strings 使用 green 系
  - parameters 使用 maroon 系
  - fields 和 properties 使用 lavender 系
  - comments 使用 overlay 系
- 每个 flavour 的核心编辑器观感，可通过 `:colorscheme catppuccin-mocha` 之类入口直接加载

## 部分复现的部分

以下部分已经支持，但其具体行为仍然更偏向 `spectra` 的共享运行时，而不是原版 Catppuccin 插件的完整内部实现：

- TreeSitter 覆盖：
  - Catppuccin flavour 继承了 `spectra` 的共享现代 capture 覆盖
  - 并通过定向 override 调整了一些比较关键的 Catppuccin 类别，例如 tags、attributes、parameters、constants、markdown headings，以及部分 CSS / HTML 情况
- semantic token 行为：
  - flavour 继承了 `spectra` 的共享 semantic token 模型
  - 同时通过少量 override 调整了一些更接近 Catppuccin 的情况，例如 enum members、readonly variables、properties 和 parameters
- plugin integrations：
  - flavour 可以复用 `spectra` 当前已经支持的 integrations
  - 最终效果会有明显的 Catppuccin 气质，但还不是对原版 `catppuccin.nvim` 更大 integration 矩阵的完整复刻

## 明确没有追求完全一致的部分

以下差异在当前阶段是有意为之的：

- `spectra.nvim` 不打算复制 `catppuccin.nvim` 的完整内部实现
- `spectra.nvim` 继续使用一套共享 TreeSitter query 资产，而不是引入 Catppuccin 专属 query 文件
- 某些 UI 细节仍然遵循 `spectra` 共享运行时的通用约定，而不是逐项复制 Catppuccin 插件的具体实现
- `catppuccin.nvim` 中大量长尾 plugin integrations 目前仍不在 `spectra.nvim` 的范围内

## 目前仍缺失或延后的细节

相对于原版 Catppuccin 插件，以下内容当前仍属于延后项或未完全补齐项：

- 原版 Catppuccin 的大规模 integration 矩阵尚未完整迁移
- 没有提供 Catppuccin 专属 query 资产；当前 flavour 仍依赖 `spectra` 的共享 query 细化规则
- 某些不那么核心的高亮类别仍然沿用 `spectra` 的通用槽位行为，而不是专门手工调到 Catppuccin 原版值
- 目前还不能承诺每一个原版 Catppuccin 高亮组，在 `spectra` 中都存在一一对应的等价实现

## 为什么要做这样的取舍

引入这四个 flavour 的核心目的，是验证 `spectra` 能否在“不为每个主题单独分叉运行时”的前提下，承载第二个主题家族。

这要求我们保留：

- 一套共享引擎
- 一套共享 fallback 模型
- 一套共享 query 策略

而不是在仓库里塞进一份几乎独立的 `catppuccin.nvim` 副本。

## 已完成的验证

集成过程中已完成以下检查：

- 四个 flavour 都可以通过各自的 colorscheme 名称直接加载
- `catppuccin-latte` 可以正确把 Neovim background 切换到 `light`
- 关键高亮组，例如 TreeSitter parameter captures 和 completion-item function groups，在主题加载后都存在
- 实现中没有引入 Catppuccin 专属 query 资产

## 应该如何理解当前结果

如果你想要的是：

- 在 `spectra` 引擎中使用 Catppuccin palette 与 flavour 身份
- 在不同主题家族之间复用统一的 TreeSitter、LSP、semantic token 和 integration 支持

那么当前这版集成就是目标结果。

如果你想要的是：

- 原版 Catppuccin 插件的完整行为
- 每一个原版 integration 和内部细节都逐项完全一致

那么后续仍然还有继续打磨的空间，这些差距应当被视为明确的后续增强项，而不是隐藏的回归问题。
