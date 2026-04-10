# `spectra.nvim` 架构导读

这份文档面向准备系统阅读 `spectra.nvim` 实现的开发者。目标不是逐文件罗列，而是先解释插件的设计边界、核心抽象和推荐阅读顺序，让你带着“为什么这样分层”的视角去看代码。

## 1. 先建立整体心智模型

`spectra.nvim` 可以理解为一个“语义优先”的 Neovim colorscheme 引擎，而不是单一主题。

它把主题插件拆成了两层：

- 共享引擎层：负责生成 editor、syntax、TreeSitter、LSP、semantic token、插件 integrations 等高亮组
- 主题描述层：负责提供 palette、semantic roles 和少量必要 overrides

核心思想是：

1. 不为每个主题复制整套高亮运行时
2. 优先复用共享语义模型，而不是让共享模块直接依赖某个主题家族的私有颜色名
3. 允许不同主题家族在同一引擎里保留自己的气质

你可以把它理解成：

- `spectra` 负责“高亮系统如何工作”
- 各个主题文件负责“这个主题希望语义上长成什么样”

## 2. 代码结构总览

建议先记住这几个目录的职责：

- `lua/spectra/init.lua`
  - 引擎入口，负责 setup、load、theme resolve、组装共享模块、应用 overrides
- `lua/spectra/registry.lua`
  - 主题注册表，管理 canonical theme、theme family 和 family default
- `lua/spectra/themes/`
  - 内建主题定义。这里不是 colorscheme loader，而是主题契约实现
- `lua/spectra/groups/`
  - 共享高亮生成器，按 editor / syntax / treesitter / lsp / semantic_tokens / integrations 分层
- `lua/spectra/groups/integrations/`
  - 各插件的共享高亮映射
- `lua/spectra/util/`
  - 低层工具，如颜色混合、role 回退、批量应用高亮
- `colors/`
  - `:colorscheme xxx` 的薄入口
- `after/queries/`
  - 引擎级 TreeSitter query 修正，不属于某个主题私有资产
- `tests/`
  - 最小启动配置、回归测试、若干人工观察脚本

## 3. 推荐阅读顺序

如果你第一次读这个项目，建议按下面顺序：

### 第一轮：看运行时主链路

1. [lua/spectra/init.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\init.lua)
2. [lua/spectra/registry.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\registry.lua)
3. [lua/spectra/util/theme.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\util\theme.lua)
4. [lua/spectra/util/highlighter.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\util\highlighter.lua)

这一轮的目标是理解：

- `setup()` 只是保存配置，不生成高亮
- `load()` 才是完整的加载动作
- `registry.resolve()` 如何把 family 名解析到 canonical theme
- `get_groups()` 如何把共享模块一层层合并起来

### 第二轮：看共享高亮模块如何消费主题语义

1. [lua/spectra/groups/editor.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\editor.lua)
2. [lua/spectra/groups/syntax.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\syntax.lua)
3. [lua/spectra/groups/treesitter.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\treesitter.lua)
4. [lua/spectra/groups/semantic_tokens.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\semantic_tokens.lua)
5. [lua/spectra/groups/lsp.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\lsp.lua)
6. [lua/spectra/groups/integrations/init.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\integrations\init.lua)

这一轮重点看两个问题：

- 哪些高亮决策来自 `roles`
- 哪些地方仍然依赖稳定 palette slot

你会发现 `spectra` 的策略不是彻底抛弃 palette，而是尽量让“语义性决策”先走 roles，只有少量 UI/分隔符/底色场景继续依赖 palette。

### 第三轮：看一个主题如何接入引擎

建议按这个顺序看：

1. [lua/spectra/themes/dracula_colorful.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\dracula_colorful.lua)
2. [lua/spectra/themes/catppuccin.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\catppuccin.lua)
3. [lua/spectra/themes/tokyonight.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\tokyonight.lua)
4. [lua/spectra/themes/kanagawa.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\kanagawa.lua)

原因是：

- `dracula_colorful.lua` 最直接，适合看主题契约的最小形态
- `catppuccin.lua` 展示了“家族主题 + flavour palette 适配”的第一种模式
- `tokyonight.lua` 展示了更完整的 family integration 和 override 分层
- `kanagawa.lua` 展示了近期接入时如何继续沿用这个契约，并做少量风格精修

如果你已经理解前两轮，再看这些主题文件，会比较容易区分：

- 哪些是主题身份
- 哪些是共享引擎要求的稳定接口
- 哪些是为了保真而加的 targeted overrides

### 第四轮：看 query 和测试层

1. `after/queries/<language>/highlights.scm`
2. [tests/minimal_init.lua](D:\Temp\ColorScheme\spectra.nvim\tests\minimal_init.lua)
3. [tests/regression.lua](D:\Temp\ColorScheme\spectra.nvim\tests\regression.lua)

这一轮的重点是理解：

- 为什么 query 文件被视为“引擎资产”而不是“主题资产”
- 哪些语言差异是靠 capture 修正解决的
- 回归测试实际上在保证什么

## 4. 运行时主流程

一次典型的主题加载，大致按下面流程走：

1. 用户调用 `require("spectra").setup(opts)`
2. 用户执行 `:colorscheme <name>`，由 `colors/<name>.lua` 进入 `require("spectra").load(name)`
3. `load()` 调用 `registry.resolve()` 得到 canonical theme
4. 主题模块返回：
   - `meta`
   - `palette`
   - `roles`
   - `overrides`
5. `get_groups()` 依次调用共享模块：
   - `editor`
   - `syntax`
   - `treesitter`
   - `lsp`
   - `semantic_tokens`
   - `integrations`
6. 再叠加主题 overrides
7. 通过 `vim.api.nvim_set_hl()` 批量下发高亮组
8. 最后设置 terminal colors

这条链路里最重要的设计点是：

- 共享模块先生成“基础世界”
- 主题只在必要处覆盖

这保证了新主题的接入成本不会随着支持的编辑器特性变多而线性失控。

## 5. 主题契约为什么这样设计

主题契约的核心字段是：

- `meta`
- `palette()`
- `roles(C, O)`
- `overrides`

### `meta`

定义主题公开身份，例如：

- 对外 colorscheme 名
- dark / light 背景
- family / flavour 元信息

### `palette()`

提供共享运行时仍然需要的稳定色槽，例如：

- 背景层级
- 前景层级
- border / gutter / guide
- rainbow / terminal

这层解决的是“引擎还有哪些低层 UI 颜色必须知道”的问题。

### `roles(C, O)`

这是最关键的抽象。它把 palette 转换成语义角色，例如：

- keyword
- function_name
- type
- parameter
- property
- constant
- diagnostic_error

共享模块尽量只关心“我要渲染的是 parameter 还是 property”，而不是“这个主题里的 parameter 到底应该取哪个家族色名”。

### `overrides`

当共享运行时给不出足够好的效果时，再做最小范围补丁。

`spectra.nvim` 的设计倾向是：

- 先改 `roles`
- 不够再加 `modules` override
- 还不够再考虑 integration 级别 override

只有当多个主题都频繁在同一处 override，才说明共享运行时可能需要重构。

## 6. 为什么要把 shared groups 拆成多个模块

`lua/spectra/groups/` 里的分层不是为了目录好看，而是为了把变化速率不同的东西拆开。

例如：

- `editor.lua`
  - 更偏 Neovim UI 基础层
- `syntax.lua`
  - 更偏传统 Vim 语法组
- `treesitter.lua`
  - 更偏现代 capture 体系
- `semantic_tokens.lua`
  - 更偏 LSP 语义层
- `integrations/`
  - 更偏生态插件兼容层

这几个层的变化来源并不一样：

- 有的是 Neovim 核心行为
- 有的是 parser / query
- 有的是 LSP server
- 有的是第三方插件 API

拆开后更容易回答一个问题：

“这次颜色不对，应该改主题 roles、共享 treesitter 映射，还是 integration 模块？”

## 7. TreeSitter 和 semantic token 的边界

这个项目很重视现代高亮，但也明确承认两者各有边界：

- TreeSitter 负责语法结构捕获
- semantic token 负责语言服务器提供的语义信息

`spectra` 的 fallback 顺序是：

1. language-specific override
2. semantic token override
3. TreeSitter capture mapping
4. semantic role mapping
5. base palette default

这个顺序的意义是：

- 更具体的信息优先
- 更抽象、更稳定的主题语义作为兜底

因此你在调色时经常会遇到这样的问题：

- 一个元素在某语言里颜色不同，到底是 feature 还是 bug？

答案通常取决于它最终落在哪条链路上，而不是单看主题文件。

## 8. 为什么 `after/queries` 是引擎资产

项目当前故意把 `after/queries` 视为共享引擎层的一部分，而不是“每个主题一套 query”。

这样做的收益是：

- 新主题不需要复制 query 资产
- 主题接入成本可控
- 多主题之间的语义覆盖范围更一致

代价是：

- 某些主题如果想极端贴近原版，就不能依赖“专属 query 魔改”
- 需要在共享 query 和主题 overrides 之间做更克制的取舍

这也是为什么当前文档一再强调：

- 优先语义一致性
- 不轻易添加主题专属 query

## 9. family 主题是怎么组织的

现在的 registry 支持三种概念：

- canonical theme
- family
- alias

以 Kanagawa 为例：

- canonical themes:
  - `kanagawa-wave`
  - `kanagawa-dragon`
  - `kanagawa-lotus`
- family:
  - `kanagawa`
- family default:
  - `kanagawa -> kanagawa-wave`

这样做有几个好处：

- 用户可以用 family 名拿默认 flavour
- 回归测试可以同时覆盖 family 入口和 canonical 入口
- 主题实现里仍然保留 family / flavour 元信息，便于文档和未来扩展

## 10. 测试层在保证什么

当前测试策略偏“稳定接口回归”，而不是截图级视觉比对。

[tests/regression.lua](D:\Temp\ColorScheme\spectra.nvim\tests\regression.lua) 主要检查：

- canonical theme 能否加载
- family default 能否正确解析
- dark / light 背景模式是否正确
- 一组关键高亮组是否存在

这意味着它更擅长防止：

- 注册表坏了
- loader 坏了
- 某层共享模块漏注册了
- 某个 theme family 接入时破坏了基础路径

但它不直接保证：

- 颜色值与上游逐项一致
- 每个语言的视觉 fidelity 都完美

所以你在做主题细修时，通常需要：

1. 跑 regression 保证没把系统打坏
2. 再做人工观察确认风格是否接近预期

## 11. 读代码时最容易踩的误区

### 误区一：看到某个颜色不对，就直接改共享模块

很多情况下应该先问：

- 这是共享语义错了？
- 还是当前主题 roles 没表达好？
- 还是某语言 capture 更具体，应该去看 query / semantic token？

### 误区二：把 palette 当成主题 API 的全部

在 `spectra.nvim` 里，palette 只是输入之一。真正更重要的是语义角色映射。

### 误区三：把 query 当成主题私有修补点

当前设计并不鼓励“某个主题一套 query”。如果一个问题只在单个主题出现，优先考虑 roles 或 targeted overrides。

### 误区四：认为 `colors/` 就是主题实现

`colors/` 只是 loader 入口，真正的设计重点在 `lua/spectra/`。

## 12. 如果你准备继续演进这个项目

建议你以后做改动时，按下面顺序思考：

1. 这是引擎问题，还是主题问题？
2. 能否先通过 `roles()` 表达？
3. 如果要 override，范围能否收敛在单个模块？
4. 如果多个主题都在同一点 override，是否应该回到共享运行时重构？
5. 是否需要补 regression，还是只需要补文档和人工验证？

## 13. 建议的二次阅读路径

如果你第一轮读完后准备深入某个方向，可以按兴趣继续：

### 想研究“如何新增主题”

先看：

- [docs/adding-a-theme.md](D:\Temp\ColorScheme\spectra.nvim\docs\adding-a-theme.md)
- [lua/spectra/themes/catppuccin.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\catppuccin.lua)
- [lua/spectra/themes/kanagawa.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\themes\kanagawa.lua)

### 想研究“为什么某个语言颜色不对”

先看：

- [lua/spectra/groups/treesitter.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\treesitter.lua)
- [lua/spectra/groups/semantic_tokens.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\semantic_tokens.lua)
- `after/queries/<language>/highlights.scm`

### 想研究“插件集成怎么扩展”

先看：

- [lua/spectra/groups/integrations/init.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\integrations\init.lua)
- 一个具体 integration，例如 [cmp.lua](D:\Temp\ColorScheme\spectra.nvim\lua\spectra\groups\integrations\cmp.lua)
- 对应主题里有没有 integration override

## 14. 最后一句话总结

`spectra.nvim` 的设计并不是“把多个主题塞进一个仓库”，而是“先定义一套共享语义高亮引擎，再让主题以契约的方式接入”。

如果你带着这个前提去读代码，很多看似分散的文件其实都在服务同一个目标：让不同主题家族共享尽可能多的运行时，同时尽量不丢掉各自的风格身份。
