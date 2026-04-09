# 为 `spectra.nvim` 添加新主题

本文档说明如何为 `spectra.nvim` 添加一个新的内建主题。

当前可参考的实现是 [`dracula_colorful.lua`](../lua/spectra/themes/dracula_colorful.lua)。

## 概览

在 `spectra.nvim` 的第一阶段里，一个主题不需要重新实现整套 colorscheme 运行时。

引擎已经统一提供了：

- 编辑器 UI 高亮生成
- 基础语法高亮生成
- TreeSitter 高亮生成
- LSP diagnostics 和相关 UI 高亮
- semantic token 高亮
- 已支持插件的集成高亮
- 共享的 `after/queries` 语言增强规则

主题本身主要负责描述“颜色语义意图”。

## 新主题应该放在哪里

1. 在以下目录下创建主题文件：

```text
lua/spectra/themes/<theme_name>.lua
```

例如：

```text
lua/spectra/themes/gruvbox_soft.lua
```

2. 在下列文件中注册它：

[`lua/spectra/registry.lua`](../lua/spectra/registry.lua)

例如：

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

如果主题属于某个 family，应把具体 flavour 注册在 `themes` 中，再把 family 默认值注册到 `families`，而不是复制一份扁平的重复入口。

3. 如果你希望用户可以直接通过 `:colorscheme <name>` 加载它，还需要添加一个对应的入口文件：

```text
colors/<theme-name>.lua
```

例如：

```lua
require("spectra").load("gruvbox-soft")
```

## 主题文件格式

一个主题模块返回一个 table，核心由四部分组成：

- `meta`
- `palette`
- `roles`
- `overrides`

最小模板如下：

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
    gutter = "#202020",
    guide = "#303030",
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

## 字段说明

### `meta`

`meta` 用于定义主题的公开身份。

常用字段：

- `name`：引擎内部使用的主题名
- `colorscheme`：通过 `:colorscheme` 暴露给用户的名称
- `background`：通常是 `"dark"` 或 `"light"`

例如：

```lua
M.meta = {
  name = "dracula-colorful",
  colorscheme = "dracula-colorful",
  background = "dark",
}
```

### `palette()`

`palette()` 返回共享运行时所消费的原始颜色槽位。

共享运行时现在会优先消费 `roles()`，而 `palette()` 的稳定契约被收敛到了较少的一组低层颜色槽位：

- 背景类：`bg`、`bg_dark`、`bg_darker`、`bg_float`、`bg_cursorline`、`bg_selection`
- 前景类：`fg`、`fg_muted`、`fg_parameter`
- UI 辅助色：`subtle`、`gutter`、`guide`、`border`
- 分隔符色：`braces`、`brackets`、`parens`、`rainbow`
- 特殊值：`none`、`terminal`

你仍然可以定义额外 palette 键给主题内部使用，但新的共享模块应尽量避免直接依赖这些额外键，而是优先通过 `roles()` 表达语义。

## `roles(C, O)`

`roles()` 的作用，是把原始颜色翻译成语义角色。

这是主题表达自身风格的核心位置，例如：

- 注释应该是什么观感
- 参数是否需要和普通标识符区分开
- 字段和属性是否应该分色
- diagnostics 应该呈现怎样的视觉层次

共享运行时会把这些语义角色应用到 editor、TreeSitter、LSP、semantic tokens 和 integrations 各层。

推荐至少提供以下基础角色：

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

`overrides` 是可选项。只有在共享运行时不够表达你的主题意图时，才建议使用。

现在推荐按作用域来组织：

- `modules`
- `integrations`
- `languages`
- `all`

其中 `modules` 下可以继续使用共享模块名：

- `editor`
- `syntax`
- `treesitter`
- `lsp`
- `semantic_tokens`
- `integrations`

每个 provider 可以是一个函数：

```lua
function(C, R, O)
  return {
    GroupName = { fg = C.orange, bold = true },
  }
end
```

例如：

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

`languages` 目前作为未来的语言类别 override 扩展位保留下来。第一版不会引入很重的 DSL，但主题文件结构已经为后续演进预留好空间。

应尽量少用 overrides。如果一个颜色决策本质上属于语义角色，优先调整 `roles()`，而不是在 override 里打补丁。

## Fallback 顺序

引擎当前按以下顺序解析高亮：

1. language-specific override
2. semantic token override
3. TreeSitter capture mapping
4. semantic role mapping
5. base palette default

这意味着新主题一开始不需要覆盖每一个细节场景。

## 哪些能力默认是共享的

默认情况下，新主题会自动继承：

- 共享的 TreeSitter 高亮覆盖
- 共享的 semantic token 覆盖
- 共享的 LSP 高亮组
- 共享的插件集成高亮
- 共享的 `after/queries/<language>/highlights.scm` 文件

换句话说，query 文件属于框架级语义分类资产，而不是每个主题各自维护的配色定义。

## 推荐工作流

1. 复制 [`dracula_colorful.lua`](../lua/spectra/themes/dracula_colorful.lua) 作为新主题的起点。
2. 修改 `meta.name` 和 `meta.colorscheme`。
3. 替换掉 palette 中的颜色。
4. 调整 `roles()`，直到主题的语义层次正确。
5. 在 [`registry.lua`](../lua/spectra/registry.lua) 中注册新主题。
6. 如果需要直接 `:colorscheme` 支持，就添加 `colors/<theme-name>.lua`。
7. 运行一次 headless 检查：

```powershell
nvim --headless -u tests/minimal_init.lua "+colorscheme <theme-name>" "+qa"
```

8. 用 [`tests/fixtures`](../tests/fixtures/) 里的样例文件检查目标语言的表现。
9. 合并前再跑一次基础回归检查：

```powershell
nvim --headless -u tests/minimal_init.lua "+luafile tests/regression.lua"
```

## 实践建议

- 先只改 palette 和 roles。
- 没有明确语义需求时，不要一开始就添加每主题独立 query 文件。
- 优先追求语义一致性，而不是针对某一门语言做到过度特化。
- 如果一个主题需要大量 overrides 才能成立，通常意味着共享运行时需要继续改进，而不是主题本身应该继续堆补丁。

## 当前限制

- 一些低层 UI 和分隔符高亮仍然需要稳定 palette 槽位。
- 主题专属 query 资产在第一阶段是明确不支持的。
- 真正检验这套契约是否足够好的关键，是第二个内建主题落地时的体验。
