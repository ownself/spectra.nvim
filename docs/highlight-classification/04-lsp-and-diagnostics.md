# Part 4: LSP And Diagnostics

覆盖 Diagnostic、LSP UI、LSP semantic token 与旧式兼容诊断组。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 必设置

### LSP UI / 引用 / 辅助

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `LspCodeLens` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | LSP CodeLens 文本与分隔。 |
| `LspCodeLensSeparator` | links to LspCodeLens | 06-links: 通过链接复用 `LspCodeLens` 的定义。 | LSP CodeLens 文本与分隔。 |
| `LspInlayHint` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | LSP 内联提示。 |
| `LspReferenceRead` | links to LspReferenceText | 06-links: 通过链接复用 `LspReferenceText` 的定义。 | LSP 引用高亮，用于光标下 symbol 的读写引用范围。 |
| `LspReferenceTarget` | links to LspReferenceText | 06-links: 通过链接复用 `LspReferenceText` 的定义。 | LSP 引用高亮，用于光标下 symbol 的读写引用范围。 |
| `LspReferenceText` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | LSP 引用高亮，用于光标下 symbol 的读写引用范围。 |
| `LspReferenceWrite` | links to LspReferenceText | 06-links: 通过链接复用 `LspReferenceText` 的定义。 | LSP 引用高亮，用于光标下 symbol 的读写引用范围。 |
| `LspSignatureActiveParameter` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | 函数签名提示中当前激活参数。 |

### LSP semantic token

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `@lsp.type.class` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.class。 |
| `@lsp.type.comment` | links to @comment | 06-links: 通过链接复用 `@comment` 的定义。 | LSP semantic token 组，语义路径: type.comment。 |
| `@lsp.type.decorator` | links to @attribute | 06-links: 通过链接复用 `@attribute` 的定义。 | LSP semantic token 组，语义路径: type.decorator。 |
| `@lsp.type.enum` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.enum。 |
| `@lsp.type.enumMember` | links to @constant | 06-links: 通过链接复用 `@constant` 的定义。 | LSP semantic token 组，语义路径: type.enumMember。 |
| `@lsp.type.event` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.event。 |
| `@lsp.type.function` | links to @function | 06-links: 通过链接复用 `@function` 的定义。 | LSP semantic token 组，语义路径: type.function。 |
| `@lsp.type.interface` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.interface。 |
| `@lsp.type.keyword` | links to @keyword | 06-links: 通过链接复用 `@keyword` 的定义。 | LSP semantic token 组，语义路径: type.keyword。 |
| `@lsp.type.macro` | links to @constant.macro | 06-links: 通过链接复用 `@constant.macro` 的定义。 | LSP semantic token 组，语义路径: type.macro。 |
| `@lsp.type.method` | links to @function.method | 06-links: 通过链接复用 `@function.method` 的定义。 | LSP semantic token 组，语义路径: type.method。 |
| `@lsp.type.modifier` | links to @type.qualifier | 06-links: 通过链接复用 `@type.qualifier` 的定义。 | LSP semantic token 组，语义路径: type.modifier。 |
| `@lsp.type.namespace` | links to @module | 06-links: 通过链接复用 `@module` 的定义。 | LSP semantic token 组，语义路径: type.namespace。 |
| `@lsp.type.number` | links to @number | 06-links: 通过链接复用 `@number` 的定义。 | LSP semantic token 组，语义路径: type.number。 |
| `@lsp.type.operator` | links to @operator | 06-links: 通过链接复用 `@operator` 的定义。 | LSP semantic token 组，语义路径: type.operator。 |
| `@lsp.type.parameter` | links to @variable.parameter | 06-links: 通过链接复用 `@variable.parameter` 的定义。 | LSP semantic token 组，语义路径: type.parameter。 |
| `@lsp.type.property` | links to @property | 06-links: 通过链接复用 `@property` 的定义。 | LSP semantic token 组，语义路径: type.property。 |
| `@lsp.type.regexp` | links to @string.regexp | 06-links: 通过链接复用 `@string.regexp` 的定义。 | LSP semantic token 组，语义路径: type.regexp。 |
| `@lsp.type.string` | links to @string | 06-links: 通过链接复用 `@string` 的定义。 | LSP semantic token 组，语义路径: type.string。 |
| `@lsp.type.struct` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.struct。 |
| `@lsp.type.type` | links to @type | 06-links: 通过链接复用 `@type` 的定义。 | LSP semantic token 组，语义路径: type.type。 |
| `@lsp.type.typeParameter` | links to @type.definition | 06-links: 通过链接复用 `@type.definition` 的定义。 | LSP semantic token 组，语义路径: type.typeParameter。 |
| `@lsp.type.variable` | links to @variable | 06-links: 通过链接复用 `@variable` 的定义。 | LSP semantic token 组，语义路径: type.variable。 |

### LSP 诊断与提示

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `DiagnosticDeprecated` | cterm=strikethrough gui=strikethrough guisp=NvimLightRed | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticError` | ctermfg=9 guifg=NvimLightRed | 01-palette-name: 当前组引用了命名调色板颜色。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticFloatingError` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticFloatingHint` | links to DiagnosticHint | 06-links: 通过链接复用 `DiagnosticHint` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticFloatingInfo` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticFloatingOk` | links to DiagnosticOk | 06-links: 通过链接复用 `DiagnosticOk` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticFloatingWarn` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticHint` | ctermfg=12 guifg=NvimLightBlue | 01-palette-name: 当前组引用了命名调色板颜色。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticInfo` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticOk` | ctermfg=10 guifg=NvimLightGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticSignError` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticSignHint` | links to DiagnosticHint | 06-links: 通过链接复用 `DiagnosticHint` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticSignInfo` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticSignOk` | links to DiagnosticOk | 06-links: 通过链接复用 `DiagnosticOk` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticSignWarn` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnderlineError` | cterm=underline gui=underline guisp=NvimLightRed | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnderlineHint` | cterm=underline gui=underline guisp=NvimLightBlue | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnderlineInfo` | cterm=underline gui=underline guisp=NvimLightCyan | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnderlineOk` | cterm=underline gui=underline guisp=NvimLightGreen | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnderlineWarn` | cterm=underline gui=underline guisp=NvimLightYellow | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticUnnecessary` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualLinesError` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualLinesHint` | links to DiagnosticHint | 06-links: 通过链接复用 `DiagnosticHint` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualLinesInfo` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualLinesOk` | links to DiagnosticOk | 06-links: 通过链接复用 `DiagnosticOk` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualLinesWarn` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualTextError` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualTextHint` | links to DiagnosticHint | 06-links: 通过链接复用 `DiagnosticHint` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualTextInfo` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualTextOk` | links to DiagnosticOk | 06-links: 通过链接复用 `DiagnosticOk` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticVirtualTextWarn` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |
| `DiagnosticWarn` | ctermfg=11 guifg=NvimLightYellow | 01-palette-name: 当前组引用了命名调色板颜色。 | LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。 |

## 可选

### LSP semantic token

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `@lsp.mod.deprecated` | links to DiagnosticDeprecated | 06-links: 通过链接复用 `DiagnosticDeprecated` 的定义。 | LSP semantic token 组，语义路径: mod.deprecated。 |
