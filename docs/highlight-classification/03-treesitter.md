# Part 3: TreeSitter

覆盖 TreeSitter captures，包括基础 captures、兼容别名与语言特化 captures。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 必设置

### TreeSitter 基础

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `@attribute` | links to Macro | 06-links: 通过链接复用 `Macro` 的定义。 | 属性标注 / annotation。 |
| `@attribute.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 属性标注 / annotation，修饰: builtin。 |
| `@boolean` | links to Boolean | 06-links: 通过链接复用 `Boolean` 的定义。 | 布尔值。 |
| `@character` | links to Character | 06-links: 通过链接复用 `Character` 的定义。 | 字符。 |
| `@character.special` | links to SpecialChar | 06-links: 通过链接复用 `SpecialChar` 的定义。 | 字符，修饰: special。 |
| `@comment` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | 注释。 |
| `@comment.error` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | 注释，修饰: error。 |
| `@comment.note` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | 注释，修饰: note。 |
| `@comment.todo` | links to Todo | 06-links: 通过链接复用 `Todo` 的定义。 | 注释，修饰: todo。 |
| `@comment.warning` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | 注释，修饰: warning。 |
| `@constant` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | 常量。 |
| `@constant.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 常量，修饰: builtin。 |
| `@constructor` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 构造器。 |
| `@diff` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | diff 标记。 |
| `@diff.delta` | links to Changed | 06-links: 通过链接复用 `Changed` 的定义。 | diff 标记，修饰: delta。 |
| `@diff.minus` | links to Removed | 06-links: 通过链接复用 `Removed` 的定义。 | diff 标记，修饰: minus。 |
| `@diff.plus` | links to Added | 06-links: 通过链接复用 `Added` 的定义。 | diff 标记，修饰: plus。 |
| `@function` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | 函数。 |
| `@function.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 函数，修饰: builtin。 |
| `@keyword` | links to Keyword | 06-links: 通过链接复用 `Keyword` 的定义。 | 关键字。 |
| `@markup` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 标记文本。 |
| `@markup.heading` | links to Title | 06-links: 通过链接复用 `Title` 的定义。 | 标记文本，修饰: heading。 |
| `@markup.heading.1.delimiter.vimdoc` | cterm=underdouble,nocombine gui=underdouble,nocombine guifg=bg guibg=bg guisp=fg | 02-special-alias: 当前组引用了 `fg`、`bg`、`NONE` 这类特殊别名值。 | 标记文本，修饰: heading, 1, delimiter, vimdoc。 |
| `@markup.heading.2.delimiter.vimdoc` | cterm=underline,nocombine gui=underline,nocombine guifg=bg guibg=bg guisp=fg | 02-special-alias: 当前组引用了 `fg`、`bg`、`NONE` 这类特殊别名值。 | 标记文本，修饰: heading, 2, delimiter, vimdoc。 |
| `@markup.italic` | cterm=italic gui=italic | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 标记文本，修饰: italic。 |
| `@markup.link` | links to Underlined | 06-links: 通过链接复用 `Underlined` 的定义。 | 标记文本，修饰: link。 |
| `@markup.strikethrough` | cterm=strikethrough gui=strikethrough | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 标记文本，修饰: strikethrough。 |
| `@markup.strong` | cterm=bold gui=bold | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 标记文本，修饰: strong。 |
| `@markup.underline` | cterm=underline gui=underline | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 标记文本，修饰: underline。 |
| `@module` | links to Structure | 06-links: 通过链接复用 `Structure` 的定义。 | 模块 / 命名空间。 |
| `@module.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 模块 / 命名空间，修饰: builtin。 |
| `@number` | links to Number | 06-links: 通过链接复用 `Number` 的定义。 | 数字。 |
| `@number.float` | links to Float | 06-links: 通过链接复用 `Float` 的定义。 | 数字，修饰: float。 |
| `@operator` | links to Operator | 06-links: 通过链接复用 `Operator` 的定义。 | 运算符。 |
| `@property` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | 属性。 |
| `@string` | links to String | 06-links: 通过链接复用 `String` 的定义。 | 字符串。 |
| `@string.escape` | links to @string.special | 06-links: 通过链接复用 `@string.special` 的定义。 | 字符串，修饰: escape。 |
| `@string.regexp` | links to @string.special | 06-links: 通过链接复用 `@string.special` 的定义。 | 字符串，修饰: regexp。 |
| `@string.special` | links to SpecialChar | 06-links: 通过链接复用 `SpecialChar` 的定义。 | 字符串，修饰: special。 |
| `@string.special.url` | links to Underlined | 06-links: 通过链接复用 `Underlined` 的定义。 | 字符串，修饰: special, url。 |
| `@tag` | links to Tag | 06-links: 通过链接复用 `Tag` 的定义。 | 标签。 |
| `@tag.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 标签，修饰: builtin。 |
| `@type` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | 类型。 |
| `@type.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 类型，修饰: builtin。 |
| `@variable` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 变量。 |
| `@variable.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 变量，修饰: builtin。 |
| `@variable.parameter.builtin` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 变量，修饰: parameter, builtin。 |

## 可选

### TreeSitter 基础

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `@ibl` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | TreeSitter 捕获。 |
| `@ibl.indent.char.1` | cterm=nocombine gui=nocombine | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | TreeSitter 捕获，修饰: indent, char, 1。 |
| `@ibl.scope.char.1` | cterm=nocombine gui=nocombine guifg=#4f5258 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | TreeSitter 捕获，修饰: scope, char, 1。 |
| `@ibl.scope.underline.1` | cterm=underline gui=underline guisp=#4f5258 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | TreeSitter 捕获，修饰: scope, underline, 1。 |
| `@ibl.whitespace.char.1` | cterm=nocombine gui=nocombine | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | TreeSitter 捕获，修饰: whitespace, char, 1。 |
| `@label` | links to Label | 06-links: 通过链接复用 `Label` 的定义。 | 标签。 |
| `@lsp` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | TreeSitter 捕获。 |
| `@punctuation` | links to Delimiter | 06-links: 通过链接复用 `Delimiter` 的定义。 | 标点 / 分隔符。 |
| `@punctuation.special` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 标点 / 分隔符，修饰: special。 |

## 不必要

### TreeSitter 基础

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `@none` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | TreeSitter 捕获占位组，通常无需主题单独设置。 |
| `@spell` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | TreeSitter 拼写检查占位组，通常交由 spell 相关高亮处理。 |
