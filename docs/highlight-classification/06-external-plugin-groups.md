# Part 6: External Plugin Groups

覆盖当前环境中来自外部插件、状态栏、通知系统和私有生态的高亮组。这些通常不应成为通用主题框架的必做项。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 不必要

### 外部插件 / 私有生态

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `BufferLineBackground` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineBuffer` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineBufferSelected` | cterm=bold,italic gui=bold,italic guifg=#e0e2ea guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineBufferVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineCloseButton` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineCloseButtonSelected` | guifg=#e0e2ea guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineCloseButtonVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineDiagnostic` | guifg=#74767b guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineDiagnosticSelected` | cterm=bold,italic gui=bold,italic guifg=#a8a9af guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineDiagnosticVisible` | guifg=#74767b guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineDuplicate` | cterm=italic gui=italic guifg=#93969b guibg=#0f1014 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineDuplicateSelected` | cterm=italic gui=italic guifg=#93969b guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineDuplicateVisible` | cterm=italic gui=italic guifg=#93969b guibg=#121418 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineError` | guifg=#9b9ea4 guibg=#0f1014 guisp=#ffc0b9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineErrorDiagnostic` | guifg=#74767b guibg=#0f1014 guisp=#bf908a | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineErrorDiagnosticSelected` | cterm=bold,italic gui=bold,italic guifg=#bf908a guibg=#14161b guisp=#bf908a | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineErrorDiagnosticVisible` | guifg=#74767b guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineErrorSelected` | cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#14161b guisp=#ffc0b9 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineErrorVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineFill` | guifg=#9b9ea4 guibg=#0b0c0e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineGroupLabel` | guifg=#0b0c0e guibg=#9b9ea4 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineGroupSeparator` | guifg=#9b9ea4 guibg=#0b0c0e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineHint` | guifg=#9b9ea4 guibg=#0f1014 guisp=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineHintDiagnostic` | guifg=#74767b guibg=#0f1014 guisp=#7ca4bf | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineHintDiagnosticSelected` | cterm=bold,italic gui=bold,italic guifg=#7ca4bf guibg=#14161b guisp=#7ca4bf | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineHintDiagnosticVisible` | guifg=#74767b guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineHintSelected` | cterm=bold,italic gui=bold,italic guifg=#a6dbff guibg=#14161b guisp=#a6dbff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineHintVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineIndicatorSelected` | guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineIndicatorVisible` | guifg=#121418 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineInfo` | guifg=#9b9ea4 guibg=#0f1014 guisp=#8cf8f7 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineInfoDiagnostic` | guifg=#74767b guibg=#0f1014 guisp=#69bab9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineInfoDiagnosticSelected` | cterm=bold,italic gui=bold,italic guifg=#69bab9 guibg=#14161b guisp=#69bab9 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineInfoDiagnosticVisible` | guifg=#74767b guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineInfoSelected` | cterm=bold,italic gui=bold,italic guifg=#8cf8f7 guibg=#14161b guisp=#8cf8f7 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineInfoVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineModified` | guifg=#b3f6c0 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineModifiedSelected` | guifg=#b3f6c0 guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineModifiedVisible` | guifg=#b3f6c0 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineNumbers` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineNumbersSelected` | cterm=bold,italic gui=bold,italic guifg=#e0e2ea guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineNumbersVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineOffsetSeparator` | guifg=#e0e2ea guibg=#0b0c0e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLinePick` | cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#0f1014 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLinePickSelected` | cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLinePickVisible` | cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#121418 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineSeparator` | guifg=#0b0c0e guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineSeparatorSelected` | guifg=#0b0c0e guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineSeparatorVisible` | guifg=#0b0c0e guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTab` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTabClose` | guifg=#9b9ea4 guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTabSelected` | guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTabSeparator` | guifg=#0b0c0e guibg=#0f1014 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTabSeparatorSelected` | guifg=#0b0c0e guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineTruncMarker` | guifg=#9b9ea4 guibg=#0b0c0e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineWarning` | guifg=#9b9ea4 guibg=#0f1014 guisp=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineWarningDiagnostic` | guifg=#74767b guibg=#0f1014 guisp=#bda86f | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineWarningDiagnosticSelected` | cterm=bold,italic gui=bold,italic guifg=#bda86f guibg=#14161b guisp=#bda86f | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineWarningDiagnosticVisible` | guifg=#74767b guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `BufferLineWarningSelected` | cterm=bold,italic gui=bold,italic guifg=#fce094 guibg=#14161b guisp=#fce094 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | bufferline 标签栏相关组。 |
| `BufferLineWarningVisible` | guifg=#9b9ea4 guibg=#121418 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | bufferline 标签栏相关组。 |
| `IblIndent` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | ibl 缩进线相关组。 |
| `IblScope` | guifg=#4f5258 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | ibl 缩进线相关组。 |
| `IblWhitespace` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | ibl 缩进线相关组。 |
| `MiniIcons` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsAzure` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsBlue` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsCyan` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsGreen` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsGrey` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsOrange` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsPurple` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsRed` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `MiniIconsYellow` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插件 Mini 的高亮组。 |
| `NoiceCmdline` | links to MsgArea | 06-links: 通过链接复用 `MsgArea` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIcon` | links to DiagnosticSignInfo | 06-links: 通过链接复用 `DiagnosticSignInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconCalculator` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconCmdline` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconFilter` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconHelp` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconInput` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconLua` | links to NoiceCmdlineIcon | 06-links: 通过链接复用 `NoiceCmdlineIcon` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlineIconSearch` | links to DiagnosticSignWarn | 06-links: 通过链接复用 `DiagnosticSignWarn` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopup` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorder` | links to DiagnosticSignInfo | 06-links: 通过链接复用 `DiagnosticSignInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderCalculator` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderCmdline` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderFilter` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderHelp` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderInput` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderLua` | links to NoiceCmdlinePopupBorder | 06-links: 通过链接复用 `NoiceCmdlinePopupBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupBorderSearch` | links to DiagnosticSignWarn | 06-links: 通过链接复用 `DiagnosticSignWarn` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitle` | links to DiagnosticSignInfo | 06-links: 通过链接复用 `DiagnosticSignInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleCalculator` | links to NoiceCmdlinePopupBorderCalculator | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderCalculator` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleCmdline` | links to NoiceCmdlinePopupBorderCmdline | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderCmdline` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleFilter` | links to NoiceCmdlinePopupBorderFilter | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderFilter` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleHelp` | links to NoiceCmdlinePopupBorderHelp | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderHelp` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleInput` | links to NoiceCmdlinePopupBorderInput | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderInput` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleLua` | links to NoiceCmdlinePopupBorderLua | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderLua` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePopupTitleSearch` | links to NoiceCmdlinePopupBorderSearch | 06-links: 通过链接复用 `NoiceCmdlinePopupBorderSearch` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCmdlinePrompt` | links to Title | 06-links: 通过链接复用 `Title` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindClass` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindColor` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindConstant` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindConstructor` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindDefault` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindEnum` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindEnumMember` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindField` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindFile` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindFolder` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindFunction` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindInterface` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindKeyword` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindMethod` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindModule` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindProperty` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindSnippet` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindStruct` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindText` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindUnit` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindValue` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCompletionItemKindVariable` | links to NoiceCompletionItemKindDefault | 06-links: 通过链接复用 `NoiceCompletionItemKindDefault` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceConfirm` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceConfirmBorder` | links to DiagnosticSignInfo | 06-links: 通过链接复用 `DiagnosticSignInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceCursor` | links to Cursor | 06-links: 通过链接复用 `Cursor` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatConfirm` | links to CursorLine | 06-links: 通过链接复用 `CursorLine` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatConfirmDefault` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatDate` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatEvent` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatKind` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelDebug` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelError` | links to DiagnosticVirtualTextError | 06-links: 通过链接复用 `DiagnosticVirtualTextError` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelInfo` | links to DiagnosticVirtualTextInfo | 06-links: 通过链接复用 `DiagnosticVirtualTextInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelOff` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelTrace` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatLevelWarn` | links to DiagnosticVirtualTextWarn | 06-links: 通过链接复用 `DiagnosticVirtualTextWarn` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatProgressDone` | guifg=#eef1f8 guibg=#6b5300 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatProgressTodo` | links to CursorLine | 06-links: 通过链接复用 `CursorLine` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceFormatTitle` | links to Title | 06-links: 通过链接复用 `Title` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceHiddenCursor` | cterm=nocombine gui=nocombine blend=100 | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceLspProgressClient` | links to Title | 06-links: 通过链接复用 `Title` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceLspProgressSpinner` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceLspProgressTitle` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceMini` | links to MsgArea | 06-links: 通过链接复用 `MsgArea` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopup` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopupBorder` | links to FloatBorder | 06-links: 通过链接复用 `FloatBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopupmenu` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopupmenuBorder` | links to FloatBorder | 06-links: 通过链接复用 `FloatBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopupmenuMatch` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoicePopupmenuSelected` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceScrollbar` | links to PmenuSbar | 06-links: 通过链接复用 `PmenuSbar` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceScrollbarThumb` | links to PmenuThumb | 06-links: 通过链接复用 `PmenuThumb` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceSplit` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceSplitBorder` | links to FloatBorder | 06-links: 通过链接复用 `FloatBorder` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NoiceVirtualText` | links to DiagnosticVirtualTextInfo | 06-links: 通过链接复用 `DiagnosticVirtualTextInfo` 的定义。 | noice.nvim 命令行、消息与补全相关组。 |
| `NotifyBackground` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyDEBUGBody` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyDEBUGBorder` | guifg=#8b8b8b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyDEBUGIcon` | guifg=#8b8b8b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyDEBUGTitle` | guifg=#8b8b8b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyERRORBody` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyERRORBorder` | guifg=#8a1f1f | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyERRORIcon` | guifg=#f70067 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyERRORTitle` | guifg=#f70067 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBody` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBody17` | guifg=#e0e2e9 guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBody18` | guifg=#e0e2e9 guibg=#14161b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBorder` | guifg=#4f6752 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBorder17` | guifg=#4f6652 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOBorder18` | guifg=#4f6652 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOIcon` | guifg=#a9ff68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOIcon17` | guifg=#a9fe68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOIcon18` | guifg=#a9fe68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOTitle` | guifg=#a9ff68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOTitle17` | guifg=#a9fe68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyINFOTitle18` | guifg=#a9fe68 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyLogTime` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyLogTitle` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyTRACEBody` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyTRACEBorder` | guifg=#4f3552 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyTRACEIcon` | guifg=#d484ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyTRACETitle` | guifg=#d484ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyWARNBody` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | nvim-notify 通知窗口相关组。 |
| `NotifyWARNBorder` | guifg=#79491d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyWARNIcon` | guifg=#f79000 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `NotifyWARNTitle` | guifg=#f79000 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | nvim-notify 通知窗口相关组。 |
| `TelescopeBorder` | links to TelescopeNormal | 06-links: 通过链接复用 `TelescopeNormal` 的定义。 | telescope 选择器相关组。 |
| `TelescopeMatching` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | telescope 选择器相关组。 |
| `TelescopeMultiIcon` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | telescope 选择器相关组。 |
| `TelescopeMultiSelection` | links to Type | 06-links: 通过链接复用 `Type` 的定义。 | telescope 选择器相关组。 |
| `TelescopeNormal` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewBlock` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewBorder` | links to TelescopeBorder | 06-links: 通过链接复用 `TelescopeBorder` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewCharDev` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewDate` | links to Directory | 06-links: 通过链接复用 `Directory` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewDirectory` | links to Directory | 06-links: 通过链接复用 `Directory` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewExecute` | links to String | 06-links: 通过链接复用 `String` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewGroup` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewHyphen` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewLine` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewLink` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewMatch` | links to Search | 06-links: 通过链接复用 `Search` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewMessage` | links to TelescopePreviewNormal | 06-links: 通过链接复用 `TelescopePreviewNormal` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewMessageFillchar` | links to TelescopePreviewMessage | 06-links: 通过链接复用 `TelescopePreviewMessage` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewNormal` | links to TelescopeNormal | 06-links: 通过链接复用 `TelescopeNormal` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewPipe` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewRead` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewSize` | links to String | 06-links: 通过链接复用 `String` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewSocket` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewSticky` | links to Keyword | 06-links: 通过链接复用 `Keyword` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewTitle` | links to TelescopeTitle | 06-links: 通过链接复用 `TelescopeTitle` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewUser` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopePreviewWrite` | links to Statement | 06-links: 通过链接复用 `Statement` 的定义。 | telescope 选择器相关组。 |
| `TelescopePromptBorder` | links to TelescopeBorder | 06-links: 通过链接复用 `TelescopeBorder` 的定义。 | telescope 选择器相关组。 |
| `TelescopePromptCounter` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | telescope 选择器相关组。 |
| `TelescopePromptNormal` | links to TelescopeNormal | 06-links: 通过链接复用 `TelescopeNormal` 的定义。 | telescope 选择器相关组。 |
| `TelescopePromptPrefix` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | telescope 选择器相关组。 |
| `TelescopePromptTitle` | links to TelescopeTitle | 06-links: 通过链接复用 `TelescopeTitle` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsBorder` | links to TelescopeBorder | 06-links: 通过链接复用 `TelescopeBorder` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsClass` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsComment` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsConstant` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsDiffAdd` | links to DiffAdd | 06-links: 通过链接复用 `DiffAdd` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsDiffChange` | links to DiffChange | 06-links: 通过链接复用 `DiffChange` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsDiffDelete` | links to DiffDelete | 06-links: 通过链接复用 `DiffDelete` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsDiffUntracked` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsField` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsFunction` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsIdentifier` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsLineNr` | links to LineNr | 06-links: 通过链接复用 `LineNr` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsMethod` | links to Method | 06-links: 通过链接复用 `Method` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsNormal` | links to TelescopeNormal | 06-links: 通过链接复用 `TelescopeNormal` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsNumber` | links to Number | 06-links: 通过链接复用 `Number` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsOperator` | links to Operator | 06-links: 通过链接复用 `Operator` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsSpecialComment` | links to SpecialComment | 06-links: 通过链接复用 `SpecialComment` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsStruct` | links to Struct | 06-links: 通过链接复用 `Struct` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsTitle` | links to TelescopeTitle | 06-links: 通过链接复用 `TelescopeTitle` 的定义。 | telescope 选择器相关组。 |
| `TelescopeResultsVariable` | links to SpecialChar | 06-links: 通过链接复用 `SpecialChar` 的定义。 | telescope 选择器相关组。 |
| `TelescopeSelection` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | telescope 选择器相关组。 |
| `TelescopeSelectionCaret` | links to TelescopeSelection | 06-links: 通过链接复用 `TelescopeSelection` 的定义。 | telescope 选择器相关组。 |
| `TelescopeTitle` | links to TelescopeBorder | 06-links: 通过链接复用 `TelescopeBorder` 的定义。 | telescope 选择器相关组。 |
| `WhichKey` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyBorder` | links to FloatBorder | 06-links: 通过链接复用 `FloatBorder` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyDesc` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyGroup` | links to Keyword | 06-links: 通过链接复用 `Keyword` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIcon` | links to @markup.link | 06-links: 通过链接复用 `@markup.link` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconAzure` | links to Function | 06-links: 通过链接复用 `Function` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconBlue` | links to DiagnosticInfo | 06-links: 通过链接复用 `DiagnosticInfo` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconCyan` | links to DiagnosticHint | 06-links: 通过链接复用 `DiagnosticHint` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconGreen` | links to DiagnosticOk | 06-links: 通过链接复用 `DiagnosticOk` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconGrey` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconOrange` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconPurple` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconRed` | links to DiagnosticError | 06-links: 通过链接复用 `DiagnosticError` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyIconYellow` | links to DiagnosticWarn | 06-links: 通过链接复用 `DiagnosticWarn` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyNormal` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeySeparator` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyTitle` | links to FloatTitle | 06-links: 通过链接复用 `FloatTitle` 的定义。 | which-key 提示面板相关组。 |
| `WhichKeyValue` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | which-key 提示面板相关组。 |
| `lualine_a_command` | gui=bold,nocombine guifg=#16181d guibg=#b6f0ff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_inactive` | gui=bold,nocombine guifg=#a7a9ae guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_insert` | gui=bold,nocombine guifg=#16181d guibg=#c4ffd3 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_normal` | gui=bold,nocombine guifg=#a7a9ae guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_replace` | gui=bold,nocombine guifg=#16181d guibg=#f6f8ff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_terminal` | gui=bold,nocombine guifg=#16181d guibg=#b6f0ff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_a_visual` | gui=bold,nocombine guifg=#16181d guibg=#9affff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_command` | gui=nocombine guifg=#b6f0ff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_command` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_inactive` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_insert` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_normal` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_replace` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_terminal` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_error_visual` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_command` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_inactive` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_insert` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_normal` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_replace` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_terminal` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_hint_visual` | gui=nocombine guifg=#a6dbff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_command` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_inactive` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_insert` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_normal` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_replace` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_terminal` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_info_visual` | gui=nocombine guifg=#8cf8f7 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_command` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_inactive` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_insert` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_normal` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_replace` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_terminal` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diagnostics_warn_visual` | gui=nocombine guifg=#fce094 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_command` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_inactive` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_insert` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_normal` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_replace` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_terminal` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_added_visual` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_command` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_inactive` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_insert` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_normal` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_replace` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_terminal` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_modified_visual` | gui=nocombine guifg=#eef1f8 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_command` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_inactive` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_insert` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_normal` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_replace` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_terminal` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_diff_removed_visual` | gui=nocombine guifg=#ffc0b9 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_inactive` | gui=nocombine guifg=#65696f guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_insert` | gui=nocombine guifg=#c4ffd3 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_normal` | gui=nocombine guifg=#65696f guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_replace` | gui=nocombine guifg=#f6f8ff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_terminal` | gui=nocombine guifg=#b6f0ff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_b_visual` | gui=nocombine guifg=#9affff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_command` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_inactive` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_insert` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_normal` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_replace` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_terminal` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_c_visual` | gui=nocombine guifg=#f6f8ff guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_command_to_lualine_b_command` | gui=nocombine guifg=#b6f0ff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_command_to_lualine_b_diff_added_command` | gui=nocombine guifg=#b6f0ff guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_insert_to_lualine_b_insert` | gui=nocombine guifg=#c4ffd3 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_insert_to_lualine_c_insert` | gui=nocombine guifg=#c4ffd3 guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_normal_to_lualine_b_diff_added_normal` | gui=nocombine guifg=#565a60 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_a_normal_to_lualine_b_normal` | gui=nocombine guifg=#565a60 guibg=#16181d | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_command_to_lualine_c_command` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_diagnostics_hint_command_to_lualine_c_command` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_diagnostics_hint_normal_to_lualine_c_normal` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_diff_added_normal_to_lualine_c_normal` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_insert_to_lualine_c_insert` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transitional_lualine_b_normal_to_lualine_c_normal` | gui=nocombine guifg=#16181d guibg=#565a60 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
| `lualine_transparent` | gui=nocombine guifg=#e0e2ea guibg=#14161b | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | lualine 状态栏分段与过渡相关组。 |
