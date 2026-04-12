# Part 2: Core Syntax And Vim Internals

覆盖传统 Vim 语法组以及 `Nvim*` 内部语法解析组。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 必设置

### 传统 Vim 语法

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `Boolean` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | 传统 Vim 语法组：布尔。 |
| `Character` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | 传统 Vim 语法组：字符。 |
| `Comment` | guifg=NvimLightGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：注释。 |
| `Conditional` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | 传统 Vim 语法组：条件关键字。 |
| `Constant` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：常量。 |
| `Debug` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 传统 Vim 语法组：调试标记。 |
| `Define` | links to PreProc | 06-links: 通过链接复用 `PreProc` 的定义。 | 传统 Vim 语法组：定义。 |
| `Delimiter` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：分隔符。 |
| `Error` | ctermfg=0 ctermbg=9 guifg=NvimLightGrey1 guibg=NvimDarkRed | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：错误。 |
| `Exception` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | 传统 Vim 语法组：异常处理关键字。 |
| `Float` | links to Number | 06-links: 通过链接复用 `Number` 的定义。 | 传统 Vim 语法组：浮点数。 |
| `Function` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：函数。 |
| `Identifier` | ctermfg=12 guifg=NvimLightBlue | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：标识符。 |
| `Ignore` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | 传统 Vim 语法组：可忽略内容。 |
| `Include` | links to PreProc | 06-links: 通过链接复用 `PreProc` 的定义。 | 传统 Vim 语法组：导入。 |
| `Keyword` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | 传统 Vim 语法组：关键字。 |
| `Label` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | 传统 Vim 语法组：标签。 |
| `Macro` | links to PreProc | 06-links: 通过链接复用 `PreProc` 的定义。 | 传统 Vim 语法组：宏。 |
| `Number` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | 传统 Vim 语法组：数字。 |
| `Operator` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：运算符。 |
| `PreCondit` | links to PreProc | 06-links: 通过链接复用 `PreProc` 的定义。 | 传统 Vim 语法组：条件预处理。 |
| `PreProc` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：预处理。 |
| `Repeat` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | 传统 Vim 语法组：循环关键字。 |
| `Special` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：特殊内容。 |
| `SpecialChar` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 传统 Vim 语法组：特殊字符。 |
| `SpecialComment` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 传统 Vim 语法组：特殊注释。 |
| `Statement` | cterm=bold gui=bold guifg=NvimLightGrey2 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 传统 Vim 语法组：语句关键字总类。 |
| `StorageClass` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | 传统 Vim 语法组：存储类。 |
| `String` | ctermfg=10 guifg=NvimLightGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：字符串。 |
| `Structure` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | 传统 Vim 语法组：结构体。 |
| `Tag` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 传统 Vim 语法组：标签。 |
| `Todo` | cterm=bold gui=bold guifg=NvimLightGrey2 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 传统 Vim 语法组：待办标记。 |
| `Type` | guifg=NvimLightGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 传统 Vim 语法组：类型。 |
| `Typedef` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | 传统 Vim 语法组：类型别名。 |
| `Underlined` | cterm=underline gui=underline | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 带下划线的文本，常用于链接。 |

## 可选

### Neovim 内部语法

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `NvimAnd` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimArrow` | links to Delimiter | 06-links: 通过链接复用 `Delimiter` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimAssignment` | links to Operator | 06-links: 通过链接复用 `Operator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimAssignmentWithAddition` | links to NvimAugmentedAssignment | 06-links: 通过链接复用 `NvimAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimAssignmentWithConcatenation` | links to NvimAugmentedAssignment | 06-links: 通过链接复用 `NvimAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimAssignmentWithSubtraction` | links to NvimAugmentedAssignment | 06-links: 通过链接复用 `NvimAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimAugmentedAssignment` | links to NvimAssignment | 06-links: 通过链接复用 `NvimAssignment` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimBinaryMinus` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimBinaryOperator` | links to NvimOperator | 06-links: 通过链接复用 `NvimOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimBinaryPlus` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimCallingParenthesis` | links to NvimParenthesis | 06-links: 通过链接复用 `NvimParenthesis` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimColon` | links to Delimiter | 06-links: 通过链接复用 `Delimiter` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimComma` | links to Delimiter | 06-links: 通过链接复用 `Delimiter` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimComparison` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimComparisonModifier` | links to NvimComparison | 06-links: 通过链接复用 `NvimComparison` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimConcat` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimConcatOrSubscript` | links to NvimConcat | 06-links: 通过链接复用 `NvimConcat` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimContainer` | links to NvimParenthesis | 06-links: 通过链接复用 `NvimParenthesis` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimCurly` | links to NvimSubscript | 06-links: 通过链接复用 `NvimSubscript` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDict` | links to NvimContainer | 06-links: 通过链接复用 `NvimContainer` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDivision` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDoubleQuote` | links to NvimStringQuote | 06-links: 通过链接复用 `NvimStringQuote` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDoubleQuotedBody` | links to NvimStringBody | 06-links: 通过链接复用 `NvimStringBody` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDoubleQuotedEscape` | links to NvimStringSpecial | 06-links: 通过链接复用 `NvimStringSpecial` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimDoubleQuotedUnknownEscape` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimEnvironmentName` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimEnvironmentSigil` | links to NvimOptionSigil | 06-links: 通过链接复用 `NvimOptionSigil` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimFigureBrace` | links to NvimInternalError | 06-links: 通过链接复用 `NvimInternalError` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimFloat` | links to NvimNumber | 06-links: 通过链接复用 `NvimNumber` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimIdentifier` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimIdentifierKey` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimIdentifierName` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimIdentifierScope` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimIdentifierScopeDelimiter` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimInternalError` | ctermfg=9 ctermbg=9 guifg=Red guibg=Red | 01-palette-name: 当前组引用了命名调色板颜色。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimInvalid` | links to Error | 06-links: 通过链接复用 `Error` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAnd` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidArrow` | links to NvimInvalidDelimiter | 06-links: 通过链接复用 `NvimInvalidDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAssignment` | links to NvimInvalid | 06-links: 通过链接复用 `NvimInvalid` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAssignmentWithAddition` | links to NvimInvalidAugmentedAssignment | 06-links: 通过链接复用 `NvimInvalidAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAssignmentWithConcatenation` | links to NvimInvalidAugmentedAssignment | 06-links: 通过链接复用 `NvimInvalidAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAssignmentWithSubtraction` | links to NvimInvalidAugmentedAssignment | 06-links: 通过链接复用 `NvimInvalidAugmentedAssignment` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidAugmentedAssignment` | links to NvimInvalidAssignment | 06-links: 通过链接复用 `NvimInvalidAssignment` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidBinaryMinus` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidBinaryOperator` | links to NvimInvalidOperator | 06-links: 通过链接复用 `NvimInvalidOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidBinaryPlus` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidCallingParenthesis` | links to NvimInvalidParenthesis | 06-links: 通过链接复用 `NvimInvalidParenthesis` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidColon` | links to NvimInvalidDelimiter | 06-links: 通过链接复用 `NvimInvalidDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidComma` | links to NvimInvalidDelimiter | 06-links: 通过链接复用 `NvimInvalidDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidComparison` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidComparisonModifier` | links to NvimInvalidComparison | 06-links: 通过链接复用 `NvimInvalidComparison` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidConcat` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidConcatOrSubscript` | links to NvimInvalidConcat | 06-links: 通过链接复用 `NvimInvalidConcat` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidContainer` | links to NvimInvalidParenthesis | 06-links: 通过链接复用 `NvimInvalidParenthesis` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidCurly` | links to NvimInvalidSubscript | 06-links: 通过链接复用 `NvimInvalidSubscript` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDelimiter` | links to NvimInvalid | 06-links: 通过链接复用 `NvimInvalid` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDict` | links to NvimInvalidContainer | 06-links: 通过链接复用 `NvimInvalidContainer` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDivision` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDoubleQuote` | links to NvimInvalidStringQuote | 06-links: 通过链接复用 `NvimInvalidStringQuote` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDoubleQuotedBody` | links to NvimInvalidStringBody | 06-links: 通过链接复用 `NvimInvalidStringBody` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDoubleQuotedEscape` | links to NvimInvalidStringSpecial | 06-links: 通过链接复用 `NvimInvalidStringSpecial` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidDoubleQuotedUnknownEscape` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidEnvironmentName` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidEnvironmentSigil` | links to NvimInvalidOptionSigil | 06-links: 通过链接复用 `NvimInvalidOptionSigil` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidFigureBrace` | links to NvimInvalidDelimiter | 06-links: 通过链接复用 `NvimInvalidDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidFloat` | links to NvimInvalidNumber | 06-links: 通过链接复用 `NvimInvalidNumber` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidIdentifier` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidIdentifierKey` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidIdentifierName` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidIdentifierScope` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidIdentifierScopeDelimiter` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidLambda` | links to NvimInvalidParenthesis | 06-links: 通过链接复用 `NvimInvalidParenthesis` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidList` | links to NvimInvalidContainer | 06-links: 通过链接复用 `NvimInvalidContainer` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidMod` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidMultiplication` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidNestingParenthesis` | links to NvimInvalidParenthesis | 06-links: 通过链接复用 `NvimInvalidParenthesis` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidNot` | links to NvimInvalidUnaryOperator | 06-links: 通过链接复用 `NvimInvalidUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidNumber` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidNumberPrefix` | links to NvimInvalidNumber | 06-links: 通过链接复用 `NvimInvalidNumber` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOperator` | links to NvimInvalid | 06-links: 通过链接复用 `NvimInvalid` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOptionName` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOptionScope` | links to NvimInvalidIdentifierScope | 06-links: 通过链接复用 `NvimInvalidIdentifierScope` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOptionScopeDelimiter` | links to NvimInvalidIdentifierScopeDelimiter | 06-links: 通过链接复用 `NvimInvalidIdentifierScopeDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOptionSigil` | links to NvimInvalidIdentifier | 06-links: 通过链接复用 `NvimInvalidIdentifier` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidOr` | links to NvimInvalidBinaryOperator | 06-links: 通过链接复用 `NvimInvalidBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidParenthesis` | links to NvimInvalidDelimiter | 06-links: 通过链接复用 `NvimInvalidDelimiter` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidPlainAssignment` | links to NvimInvalidAssignment | 06-links: 通过链接复用 `NvimInvalidAssignment` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidRegister` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSingleQuote` | links to NvimInvalidStringQuote | 06-links: 通过链接复用 `NvimInvalidStringQuote` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSingleQuotedBody` | links to NvimInvalidStringBody | 06-links: 通过链接复用 `NvimInvalidStringBody` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSingleQuotedQuote` | links to NvimInvalidStringSpecial | 06-links: 通过链接复用 `NvimInvalidStringSpecial` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSingleQuotedUnknownEscape` | links to NvimInternalError | 06-links: 通过链接复用 `NvimInternalError` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSpacing` | links to ErrorMsg | 06-links: 通过链接复用 `ErrorMsg` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidString` | links to NvimInvalidValue | 06-links: 通过链接复用 `NvimInvalidValue` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidStringBody` | links to NvimStringBody | 06-links: 通过链接复用 `NvimStringBody` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidStringQuote` | links to NvimInvalidString | 06-links: 通过链接复用 `NvimInvalidString` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidStringSpecial` | links to NvimStringSpecial | 06-links: 通过链接复用 `NvimStringSpecial` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSubscript` | links to NvimInvalidParenthesis | 06-links: 通过链接复用 `NvimInvalidParenthesis` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSubscriptBracket` | links to NvimInvalidSubscript | 06-links: 通过链接复用 `NvimInvalidSubscript` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidSubscriptColon` | links to NvimInvalidSubscript | 06-links: 通过链接复用 `NvimInvalidSubscript` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidTernary` | links to NvimInvalidOperator | 06-links: 通过链接复用 `NvimInvalidOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidTernaryColon` | links to NvimInvalidTernary | 06-links: 通过链接复用 `NvimInvalidTernary` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidUnaryMinus` | links to NvimInvalidUnaryOperator | 06-links: 通过链接复用 `NvimInvalidUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidUnaryOperator` | links to NvimInvalidOperator | 06-links: 通过链接复用 `NvimInvalidOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidUnaryPlus` | links to NvimInvalidUnaryOperator | 06-links: 通过链接复用 `NvimInvalidUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimInvalidValue` | links to NvimInvalid | 06-links: 通过链接复用 `NvimInvalid` 的定义。 | Neovim 内部命令行 / 表达式语法中的非法 token。 |
| `NvimLambda` | links to NvimParenthesis | 06-links: 通过链接复用 `NvimParenthesis` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimList` | links to NvimContainer | 06-links: 通过链接复用 `NvimContainer` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimMod` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimMultiplication` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimNestingParenthesis` | links to NvimParenthesis | 06-links: 通过链接复用 `NvimParenthesis` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimNot` | links to NvimUnaryOperator | 06-links: 通过链接复用 `NvimUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimNumber` | links to Number | 06-links: 通过链接复用 `Number` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimNumberPrefix` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOperator` | links to Operator | 06-links: 通过链接复用 `Operator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOptionName` | links to NvimIdentifier | 06-links: 通过链接复用 `NvimIdentifier` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOptionScope` | links to NvimIdentifierScope | 06-links: 通过链接复用 `NvimIdentifierScope` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOptionScopeDelimiter` | links to NvimIdentifierScopeDelimiter | 06-links: 通过链接复用 `NvimIdentifierScopeDelimiter` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOptionSigil` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimOr` | links to NvimBinaryOperator | 06-links: 通过链接复用 `NvimBinaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimParenthesis` | links to Delimiter | 06-links: 通过链接复用 `Delimiter` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimPlainAssignment` | links to NvimAssignment | 06-links: 通过链接复用 `NvimAssignment` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimRegister` | links to SpecialChar | 06-links: 通过链接复用 `SpecialChar` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSingleQuote` | links to NvimStringQuote | 06-links: 通过链接复用 `NvimStringQuote` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSingleQuotedBody` | links to NvimStringBody | 06-links: 通过链接复用 `NvimStringBody` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSingleQuotedQuote` | links to NvimStringSpecial | 06-links: 通过链接复用 `NvimStringSpecial` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSingleQuotedUnknownEscape` | links to NvimInternalError | 06-links: 通过链接复用 `NvimInternalError` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSpacing` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimString` | links to String | 06-links: 通过链接复用 `String` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimStringBody` | links to NvimString | 06-links: 通过链接复用 `NvimString` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimStringQuote` | links to NvimString | 06-links: 通过链接复用 `NvimString` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimStringSpecial` | links to SpecialChar | 06-links: 通过链接复用 `SpecialChar` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSubscript` | links to NvimParenthesis | 06-links: 通过链接复用 `NvimParenthesis` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSubscriptBracket` | links to NvimSubscript | 06-links: 通过链接复用 `NvimSubscript` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSubscriptColon` | links to NvimSubscript | 06-links: 通过链接复用 `NvimSubscript` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimSurroundHighlight` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimTernary` | links to NvimOperator | 06-links: 通过链接复用 `NvimOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimTernaryColon` | links to NvimTernary | 06-links: 通过链接复用 `NvimTernary` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimUnaryMinus` | links to NvimUnaryOperator | 06-links: 通过链接复用 `NvimUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimUnaryOperator` | links to NvimOperator | 06-links: 通过链接复用 `NvimOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
| `NvimUnaryPlus` | links to NvimUnaryOperator | 06-links: 通过链接复用 `NvimUnaryOperator` 的定义。 | Neovim 内部命令行 / 表达式解析语法组。 |
