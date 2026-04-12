# Spectra 插件架构与功能文档

## 目录

- [项目概览](#项目概览)
- [文件结构](#文件结构)
- [核心流程](#核心流程)
- [模块详解](#模块详解)
  - [入口 init.lua](#入口-initlua)
  - [配置 config.lua](#配置-configlua)
  - [调色板 palette.lua](#调色板-palettelua)
  - [颜色工具 colors.lua](#颜色工具-colorslua)
  - [默认主题 themes/default.lua](#默认主题-themesdefaultlua)
  - [高亮组模块 groups/](#高亮组模块-groups)
- [调色板系统](#调色板系统)
  - [五层渐进式架构](#五层渐进式架构)
  - [67 色槽总览](#67-色槽总览)
  - [回退链机制](#回退链机制)
  - [特殊规则](#特殊规则)
- [高亮组系统](#高亮组系统)
  - [七层 HG 回退树](#七层-hg-回退树)
  - [各模块 HG 数量](#各模块-hg-数量)
- [配置选项](#配置选项)
- [主题复刻指南](#主题复刻指南)

---

## 项目概览

Spectra 是一个 Neovim 0.12+ ColorScheme 插件。核心设计理念：

- **渐进式配置**：用户可提供 2 到 67 个颜色，系统自动补全缺失部分
- **语义命名**：使用 `danger/success/info` 等语义名，而非 `red/green/blue` 色相名
- **自动派生**：UI 色从 `bg` 自动计算，诊断/diff 的背景色自动混合生成
- **零配置可用**：内置默认主题，`setup({})` 即可获得完整配色

## 文件结构

```
spectra/
├── colors/
│   └── spectra.lua                 # Neovim colorscheme 入口（:colorscheme spectra）
├── lua/spectra/
│   ├── init.lua                    # 模块入口：setup() + load() API
│   ├── config.lua                  # 配置合并、验证、色槽路径校验
│   ├── palette.lua                 # 调色板解析引擎（67 色槽 + 回退链）
│   ├── colors.lua                  # 颜色工具函数（hex/rgb/hsl + shift/invert/mute/blend）
│   ├── themes/
│   │   └── default.lua             # 内置默认主题（dark + light 各 16 色）
│   └── groups/
│       ├── editor.lua              # EditorBasic HG（Normal, CursorLine, Pmenu 等 53 组）
│       ├── syntax.lua              # VimSyntax HG（Comment, String, Function 等 35 组）
│       ├── treesitter.lua          # TreeSitter HG（@keyword, @function 等 54 组）
│       ├── lsp.lua                 # LSP 语义令牌 HG（@lsp.type.* 等 32 组）
│       ├── diagnostic.lua          # Diagnostic HG（DiagnosticError 等 32 组）
│       ├── diff.lua                # Diff HG（diffAdded 等 3 组）
│       └── plugins.lua             # 第三方插件 HG（telescope/nvim-tree/gitsigns/ibl 共 55 组）
└── tests/
    ├── unit/                       # 单元测试（colors, palette, config）
    └── integration/                # 集成测试（加载、性能、场景验证）
```

## 核心流程

用户调用 `require("spectra").setup(opts)` + `vim.cmd("colorscheme spectra")` 后，执行流程如下：

```
用户配置 opts
    │
    ▼
┌─────────────────────────────────────────────────────┐
│  setup(opts)                                        │
│  config.merge(opts) → 验证色槽路径 + 验证 hex 值    │
│  → 存储到 M._config                                │
└──────────────────────┬──────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────┐
│  colors/spectra.lua → load()                        │
│                                                     │
│  1. 确定 style（dark / light / auto）               │
│  2. 加载默认主题 base_palette（16 色）               │
│  3. 用户 palette 覆盖到 base 之上                    │
│  4. 应用 dark/light 子配置覆盖                       │
│  5. palette.resolve() → 填满 67 色槽                │
│  6. on_colors 回调（可修改 resolved palette）        │
│  7. 逐模块收集 HG 定义                              │
│     editor → syntax → treesitter → lsp              │
│     → diagnostic → diff → plugins                   │
│  8. on_highlights 回调（可修改 HG 定义）             │
│  9. nvim_set_hl() 逐个应用                          │
│ 10. style="auto" 时注册 OptionSet autocmd           │
└─────────────────────────────────────────────────────┘
```

## 模块详解

### 入口 init.lua

**文件**：`lua/spectra/init.lua`

公开 API：

| 函数 | 说明 |
|------|------|
| `M.setup(opts)` | 合并用户配置，存储到 `M._config` |
| `M.load()` | 执行完整的主题加载流程 |

内部状态：

| 字段 | 类型 | 说明 |
|------|------|------|
| `M._config` | `table\|nil` | 合并后的配置 |
| `M._loaded` | `boolean` | 是否已加载 |
| `M._augroup` | `number\|nil` | `style="auto"` 时的 autocmd group ID |

关键行为：

- `load()` 如果发现 `_config` 为 nil，会自动调用 `setup({})`，保证裸 `:colorscheme spectra` 也能工作
- `default_theme == false` 时跳过默认主题加载，用户 palette 直接作为基底
- `transparent == true` 时，editor.lua 中 Normal、CursorLine、SignColumn 等组的 bg 被设为 nil
- `style="auto"` 时注册 `OptionSet` autocmd 监听 `background` 变化，自动重新加载

### 配置 config.lua

**文件**：`lua/spectra/config.lua`

主要功能：

1. **VALID_SLOTS** — 67 个合法色槽路径的查找表
2. **defaults** — 默认配置模板
3. **validate_hex(value)** — 验证 `#RRGGBB` 格式
4. **validate_slot_path(path)** — 验证色槽路径是否合法
5. **suggest_slot(path)** — 拼写错误时推荐最接近的合法路径
6. **merge(user_opts)** — 深度合并配置 + 验证所有 palette 条目

验证行为：无效的色槽路径或颜色值会被移除并发出 `vim.notify` 警告，不会中断加载。

### 调色板 palette.lua

**文件**：`lua/spectra/palette.lua`

这是整个插件最核心的模块，实现五层渐进式回退机制。

**resolve(user_palette)** 函数的 7 个步骤：

| 步骤 | 说明 |
|------|------|
| Step 1 | 种子化：设置 fg/bg 基础色（用户值或默认值） |
| Step 2 | 复制所有用户提供的颜色到 resolved 表 |
| Step 3 | 变体提升：如果用户给了 variant 但没给 parent，variant 提升为 parent |
| Step 4 | 回退链解析：按 layer 顺序（0→4），逐个未解析的非 UI 色槽走回退链 |
| Step 5 | UI 自动派生：从 bg 计算 cursorline/float/pmenu/statusline/visual/search/linenr |
| Step 6 | UI 变体派生：.bg 通过 shift、.subtle 通过 mute 从 parent 派生 |
| Step 7 | diag/diff 变体派生：.bg 通过 blend(bg, parent, 0.15)，.subtle 通过 blend(fg, parent, 0.4) |

### 颜色工具 colors.lua

**文件**：`lua/spectra/colors.lua`

提供颜色空间转换和 UI 色派生函数：

| 函数 | 用途 | 典型用法 |
|------|------|----------|
| `hex_to_rgb(hex)` | `#RRGGBB` → RGB [0,1] | 内部转换 |
| `rgb_to_hex(r,g,b)` | RGB → `#RRGGBB` | 内部转换 |
| `rgb_to_hsl(r,g,b)` | RGB → HSL | 亮度调整前的转换 |
| `hsl_to_rgb(h,s,l)` | HSL → RGB | 亮度调整后的转换 |
| `luminance(hex)` | WCAG 相对亮度 | 判断深色/浅色 |
| `is_dark(hex)` | 亮度 < 0.5 ？ | 决定 UI 色派生方向 |
| `shift(hex, amount)` | 微调亮度 ±amount | CursorLine、NormalFloat（+6% L） |
| `invert(hex, amount)` | 反向调整亮度 | StatusLine、Visual（+18% L） |
| `mute(hex, s_factor, l_amount)` | 降饱和度 + 拉灰 | LineNr（S×0.5, L→中间） |
| `blend(hex1, hex2, factor)` | 线性混合两色 | diag.error.bg = blend(bg, red, 0.15) |

### 默认主题 themes/default.lua

**文件**：`lua/spectra/themes/default.lua`

提供 dark 和 light 两套预设调色板，各 16 色，覆盖 Layer 0-2：

**Dark 主题**（灵感来自 VS Code Dark+）：

| 层 | 色槽 | 颜色 | 视觉 |
|----|------|------|------|
| 0 | fg | #d4d4d4 | 浅灰 |
| 0 | bg | #1e1e1e | 深灰 |
| 1 | accent.danger | #f44747 | 红 |
| 1 | accent.success | #6a9955 | 绿 |
| 1 | accent.info | #4fc1ff | 青 |
| 1 | accent.caution | #dcdcaa | 黄 |
| 1 | accent.action | #4ec9b0 | 蓝绿 |
| 1 | accent.control | #c586c0 | 紫 |
| 2 | syntax.keyword | #569cd6 | 蓝 |
| 2 | syntax.string | #ce9178 | 橙 |
| 2 | syntax.function | #dcdcaa | 黄 |
| 2 | syntax.comment | #6a9955 | 灰绿 |
| 2 | syntax.type | #4ec9b0 | 蓝绿 |
| 2 | diag.error | #f44747 | 红 |
| 2 | diag.warn | #cca700 | 暗黄 |
| 2 | diff.add | #4b5632 | 暗绿 |

当用户只提供 2 色（fg + bg）时，其余 14 色来自默认主题，再加上回退链和 UI 自动派生填满全部 67 色槽。设置 `default_theme = false` 可禁用此行为。

### 高亮组模块 groups/

每个模块导出 `M.get(p, config)` 函数，接收 resolved palette 和 config，返回 `{ [group_name] = definition }` 表。

#### editor.lua（53 组）

覆盖 Neovim 核心编辑器 UI：

| 类别 | 包含的组 |
|------|----------|
| Root | Normal |
| Cursor/Selection | CursorLine, CursorColumn, ColorColumn, Visual, VisualNOS |
| Search | Search, IncSearch, CurSearch, Substitute |
| Popup | Pmenu, PmenuSel, PmenuMatch, PmenuSbar, PmenuThumb 等 10 组 |
| Float | NormalFloat, FloatBorder, FloatTitle, FloatFooter |
| StatusLine | StatusLine, StatusLineNC, TabLine, TabLineSel, TabLineFill, WinBar 等 |
| Sign/LineNr | SignColumn, FoldColumn, LineNr, CursorLineNr 等 |
| NonText | NonText, EndOfBuffer, Whitespace, Conceal |
| Messages | Title, Directory, ErrorMsg, WarningMsg, MoreMsg 等 |
| Separators | WinSeparator, VertSplit |
| Misc | Folded, Cursor, TermCursor, MatchParen |
| Diff | DiffAdd, DiffChange, DiffDelete, DiffText, Added, Changed, Removed |

`transparent = true` 时，Normal、CursorLine、CursorColumn、ColorColumn、SignColumn、StatusLine、StatusLineNC、Folded 的 bg 被设为 nil。

#### syntax.lua（35 组）

传统 Vim 语法高亮，直接映射 palette 色槽：

| 根组 | 色槽 | 子组（link） |
|------|------|-------------|
| Comment | syntax.comment | — |
| String | syntax.string | — |
| Constant | syntax.constant | Boolean, Character, Number, Float |
| Function | syntax.function | — |
| Identifier | syntax.identifier | — |
| Statement | syntax.keyword | Keyword, Conditional, Repeat, Label, Exception |
| Operator | syntax.operator | Delimiter |
| PreProc | syntax.preproc | Include, Define, Macro, PreCondit |
| Type | syntax.type | StorageClass, Structure, Typedef |
| Special | syntax.special | SpecialChar, Tag, Debug, SpecialComment |

Statement 设有 `bold = true`，Comment 设有 `italic = true`。

#### treesitter.lua（54 组）

TreeSitter 捕获组，大部分 link 到 VimSyntax 等价组：

```
@keyword    → Keyword（→ Statement）
@function   → Function
@string     → String
@comment    → Comment
@type       → Type
@variable   → 直接使用 syntax.identifier（不 link）
@property   → Identifier
```

**14 个条件变体覆盖**：当用户显式提供了 Layer 4 变体色且与父色不同时，对应 TreeSitter 组获得独立 fg 而非 link。例如：

```lua
-- 如果 syntax.function.builtin ≠ syntax.function
if p["syntax.function.builtin"] ~= p["syntax.function"] then
  groups["@function.builtin"] = { fg = p["syntax.function.builtin"] }
end
```

支持的变体覆盖列表：

| 变体色槽 | 覆盖的 TreeSitter 组 |
|----------|---------------------|
| syntax.function.method | @function.method |
| syntax.function.builtin | @function.builtin |
| syntax.constant.builtin | @constant.builtin |
| syntax.constant.macro | @constant.macro |
| syntax.type.builtin | @type.builtin |
| syntax.type.definition | @type.definition |
| syntax.type.module | @module |
| syntax.string.escape | @string.escape |
| syntax.string.special | @string.special |
| syntax.comment.doc | @comment.documentation |
| syntax.identifier.member | @property |
| syntax.identifier.parameter | @variable.parameter |
| syntax.preproc.include | @attribute |
| syntax.preproc.macro | @attribute.builtin |

#### lsp.lua（32 组）

LSP 语义令牌，全部 link 到 TreeSitter 或编辑器组：

```
@lsp.type.function  → @function
@lsp.type.variable  → @variable
@lsp.type.keyword   → @keyword
@lsp.type.parameter → @variable.parameter
@lsp.mod.deprecated → DiagnosticDeprecated
LspReferenceText    → Visual
LspInlayHint        → NonText
LspCodeLens         → NonText
```

#### diagnostic.lua（32 组）

5 级诊断 × 6 种显示形式 + 2 个特殊组：

| 级别 | Base | Underline | Floating | Sign | VirtualText | VirtualLines |
|------|------|-----------|----------|------|-------------|--------------|
| Error | DiagnosticError | DiagnosticUnderlineError | → base | → base | → base | → base |
| Warn | DiagnosticWarn | DiagnosticUnderlineWarn | → base | → base | → base | → base |
| Info | DiagnosticInfo | DiagnosticUnderlineInfo | → base | → base | → base | → base |
| Hint | DiagnosticHint | DiagnosticUnderlineHint | → base | → base | → base | → base |
| Ok | DiagnosticOk | DiagnosticUnderlineOk | → base | → base | → base | → base |

特殊：`DiagnosticDeprecated`（strikethrough）、`DiagnosticUnnecessary`（→ Comment）

#### diff.lua（3 组）

VimSyntax 传统 diff 组，link 到 editor.lua 中的 Added/Changed/Removed。

#### plugins.lua（55 组）

4 个插件的条件加载：

| 插件 | 配置键 | 组数 | 主要使用的色槽 |
|------|--------|------|---------------|
| telescope.nvim | `plugins.telescope` | 18 | ui.float, ui.cursorline, accent.action/caution/info |
| nvim-tree.lua | `plugins.nvim_tree` | 18 | ui.float, syntax.function, diff.*, accent.* |
| gitsigns.nvim | `plugins.gitsigns` | 13 | diff.add/change/delete 及其 .bg 变体 |
| indent-blankline.nvim | `plugins.indent_blankline` | 6 | ui.linenr, accent.action |

通过 `config.plugins[name] ~= false` 控制开关，默认全部启用。

## 调色板系统

### 五层渐进式架构

```
Layer 0  base (2)      ─── fg, bg
                              │
Layer 1  accent (6)    ─── danger, success, info, caution, action, control
                              │
Layer 2  role (8)      ─── syntax.keyword, syntax.string, syntax.function,
                           syntax.comment*, syntax.type*,
                           diag.error, diag.warn, diff.add
                              │
Layer 3  full (20)     ─── syntax.constant, syntax.identifier, syntax.operator*,
                           syntax.special, syntax.preproc,
                           diag.info, diag.hint, diag.ok,
                           diff.change, diff.delete, ui.search,
                           ui.cursorline†, ui.float†, ui.linenr†,
                           ui.pmenu†, ui.statusline†, ui.visual†
                              │
Layer 4  variant (34)  ─── syntax.function.builtin, syntax.type.module,
                           diag.error.bg†, diag.error.subtle†, ...
                           ui.float.bg†, ui.visual.bg†, ...

* = accent-skip（跳过 accent 层，直接回退到 fg）
† = 自动派生（从 bg 或 parent 计算）
```

### 67 色槽总览

| 层 | 类别 | 数量 | 色槽 |
|----|------|------|------|
| 0 | base | 2 | fg, bg |
| 1 | accent | 6 | accent.{danger, success, info, caution, action, control} |
| 2 | syntax | 5 | syntax.{keyword, string, function, comment, type} |
| 2 | diag | 2 | diag.{error, warn} |
| 2 | diff | 1 | diff.add |
| 3 | syntax | 5 | syntax.{constant, identifier, operator, special, preproc} |
| 3 | diag | 3 | diag.{info, hint, ok} |
| 3 | diff | 2 | diff.{change, delete} |
| 3 | ui | 7 | ui.{search, cursorline, float, linenr, pmenu, statusline, visual} |
| 4 | syntax | 14 | syntax.{comment.doc, constant.builtin, constant.macro, function.builtin, function.method, identifier.member, identifier.parameter, preproc.include, preproc.macro, string.escape, string.special, type.builtin, type.definition, type.module} |
| 4 | diag | 10 | diag.{error,warn,info,hint,ok}.{bg,subtle} |
| 4 | diff | 3 | diff.{add,change,delete}.bg |
| 4 | ui | 7 | ui.{float.bg, float.subtle, pmenu.bg, pmenu.subtle, search.bg, statusline.bg, visual.bg} |

### 回退链机制

每个色槽有一条回退链，解析时逐级查找直到找到已存在的颜色：

```
syntax.function.method → syntax.function → accent.action → fg
syntax.constant.builtin → syntax.constant → accent.caution → fg
diag.hint → diag.info → accent.info → fg
diff.delete → diag.error → accent.danger → fg
ui.pmenu → ui.float → bg（自动派生）
```

### 特殊规则

**Accent-skip（跳过 accent 层）**

3 个色槽的回退链跳过 accent，直接回退到 fg：

| 色槽 | 回退到 | 原因 |
|------|--------|------|
| syntax.comment | fg | 注释应该是低调的，不该继承任何强调色 |
| syntax.type | fg | 类型在许多主题中是独立色系 |
| syntax.operator | fg | 运算符通常使用前景色或独立色 |

**变体提升（Variant Promotion）**

如果用户提供了 Layer 4 的 variant 色但没有提供其 parent，variant 的值会提升为 parent：

```lua
-- 用户只提供 syntax.function.method = "#ff69b4"
-- 未提供 syntax.function
-- → syntax.function 也被设为 "#ff69b4"
```

**UI 自动派生**

7 个 UI 色槽从 bg 自动计算（如果用户未显式提供）：

| 色槽 | 派生方式 | 参数 |
|------|----------|------|
| ui.cursorline | shift(bg, ±6%) | 微调亮度 |
| ui.float | shift(bg, ±7.8%) | 略大于 cursorline |
| ui.pmenu | shift(ui.float, ±3%) | 在 float 基础上再偏移 |
| ui.statusline | invert(bg, 18%) | 反向亮度 |
| ui.visual | invert(bg, 14.4%) | 反向亮度（略小于 statusline） |
| ui.search | accent.caution 值 | 直接使用强调色 |
| ui.linenr | mute(fg, S×0.5, L→中间) | 降饱和 + 拉灰 |

深色主题向亮调整，浅色主题向暗调整。

**diag/diff 变体自动派生**

| 后缀 | 派生方式 | 用途 |
|------|----------|------|
| .bg | blend(bg, parent, 0.15) | 诊断/diff 行背景色（淡淡的色调） |
| .subtle | blend(fg, parent, 0.4) | 虚拟文本等弱化显示 |

## 高亮组系统

### 七层 HG 回退树

```
L0  Normal (root)
 ├── L1  EditorBasic (53 groups)
 │       UI 组件：CursorLine, Pmenu, StatusLine, SignColumn ...
 │       Diff 组件：DiffAdd, DiffChange, Added, Changed ...
 │
 ├── L2  VimSyntax (35 groups)
 │       Comment, String, Function, Statement, Type, Special ...
 │   │
 │   ├── L3  TreeSitter (54 groups)
 │   │       @keyword → Keyword, @function → Function ...
 │   │       14 个条件变体覆盖（当 variant ≠ parent 时独立着色）
 │   │   │
 │   │   └── L4  LSP (32 groups)
 │   │           @lsp.type.function → @function ...
 │   │
 │   └── L5  Diagnostic (32 groups)
 │           DiagnosticError, DiagnosticUnderlineWarn ...
 │
 └── L6  Diff (3 groups)
         diffAdded → Added, diffChanged → Changed ...
```

### 各模块 HG 数量

| 模块 | 组数 | 定义方式 |
|------|------|----------|
| editor.lua | 53 | 直接 palette 映射 + link |
| syntax.lua | 35 | 根组直接映射，子组 link |
| treesitter.lua | 54 | 大部分 link 到 VimSyntax，14 个条件覆盖 |
| lsp.lua | 32 | 全部 link 到 TreeSitter/Editor |
| diagnostic.lua | 32 | 5 级 × 6 形式 + 2 特殊 |
| diff.lua | 3 | link 到 editor.lua 的 Added/Changed/Removed |
| plugins.lua | 55 | 4 个插件各自独立 |
| **合计** | **264** | — |

## 配置选项

```lua
require("spectra").setup({
  -- 调色板：2 到 67 个颜色，键为色槽路径，值为 "#RRGGBB"
  palette = {},

  -- 风格："dark" | "light" | "auto"
  -- "auto" 时跟随 vim.o.background，并注册 OptionSet 自动切换
  style = "dark",

  -- 是否使用内置默认主题作为基底（true = 16 色基底，false = 纯回退链）
  default_theme = true,

  -- 终端透明：移除 Normal 等组的 bg
  transparent = false,

  -- dark/light 子调色板覆盖（style="auto" 时按方向叠加）
  dark = nil,   -- { ["syntax.keyword"] = "#569cd6", ... }
  light = nil,  -- { ["syntax.keyword"] = "#0000ff", ... }

  -- 插件开关（默认全部启用，设为 false 禁用）
  plugins = {
    telescope = true,
    nvim_tree = true,
    gitsigns = true,
    indent_blankline = true,
  },

  -- 回调：在 palette 解析后、HG 生成前调用，可修改 resolved palette
  on_colors = nil,  -- function(colors) colors.fg = "#ffffff" end

  -- 回调：在 HG 生成后、应用前调用，可修改/新增 HG 定义
  on_highlights = nil,  -- function(groups, colors) groups.Normal = { fg = "#fff" } end
})
```

## 主题复刻指南

将已有主题的颜色映射到 Spectra 的色槽体系，只需识别以下对应关系：

### 必须映射（Layer 0-1，8 色）

| 概念 | 色槽 |
|------|------|
| 前景色 | `fg` |
| 背景色 | `bg` |
| 错误/危险色 | `accent.danger` |
| 成功/添加色 | `accent.success` |
| 信息/链接色 | `accent.info` |
| 警告/搜索色 | `accent.caution` |
| 动作/函数色 | `accent.action` |
| 控制/关键字色 | `accent.control` |

### 推荐映射（Layer 2，+8 色 = 16 色）

| 概念 | 色槽 |
|------|------|
| 关键字色（如果与 accent.control 不同） | `syntax.keyword` |
| 字符串色 | `syntax.string` |
| 函数名色 | `syntax.function` |
| 注释色 | `syntax.comment` |
| 类型色 | `syntax.type` |
| 诊断错误色 | `diag.error` |
| 诊断警告色 | `diag.warn` |
| Diff 添加背景色 | `diff.add` |

### 精细映射（Layer 3-4，额外提供差异化颜色）

只在目标主题中相应概念使用了**与 parent 不同的颜色**时才需要提供：

```lua
-- 常量和标识符有独立色
["syntax.constant"]   = "#BD93F9",
["syntax.identifier"] = "#B9BCD1",

-- 内建函数与普通函数颜色不同
["syntax.function.builtin"] = "#8BE9FD",

-- 参数有独立色（如 Catppuccin 的 maroon、Dracula 的淡紫）
["syntax.identifier.parameter"] = "#D8A0F0",

-- UI 色有明确指定
["ui.cursorline"] = "#1E1F29",
["ui.float"]      = "#3A3D4C",
```

### 无法复刻的特性

当前 67 色槽结构不支持的主题特性：

- 彩虹括号（需要 rainbow 色数组）
- Markdown 标题分级配色（h1-h6 各不同色）
- 语言特定覆盖（如 CSS 属性用蓝色、HTML 标签用红色）
- 语义令牌的修饰符变体（如 readonly 变量加粗）

这些可通过 `on_highlights` 回调手动补充：

```lua
on_highlights = function(groups, colors)
  groups["@markup.heading.1.markdown"] = { fg = "#f38ba8", bold = true }
  groups["@markup.heading.2.markdown"] = { fg = "#fab387", bold = true }
end,
```
