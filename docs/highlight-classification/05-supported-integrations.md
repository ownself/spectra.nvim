# Part 5: Supported Integrations

覆盖 `spectra.nvim` 当前共享运行时已支持的插件集成组，例如 `cmp`、`blink`、`gitsigns`、`rainbow-delimiters`、`nvim-tree`。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 可选

### 受支持插件集成

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `BlinkCmpDoc` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpDocBorder` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpDocCursorLine` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpDocSeparator` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpGhostText` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKind` | links to PmenuKind | 06-links: 通过链接复用 `PmenuKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindClass` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindColor` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindConstant` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindConstructor` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindEnum` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindEnumMember` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindEvent` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindField` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindFile` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindFolder` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindFunction` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindInterface` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindKeyword` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindMethod` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindModule` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindOperator` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindProperty` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindReference` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindSnippet` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindStruct` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindText` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindTypeParameter` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindUnit` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindValue` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpKindVariable` | links to BlinkCmpKind | 06-links: 通过链接复用 `BlinkCmpKind` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpLabel` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpLabelDeprecated` | links to PmenuExtra | 06-links: 通过链接复用 `PmenuExtra` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpLabelDescription` | links to PmenuExtra | 06-links: 通过链接复用 `PmenuExtra` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpLabelDetail` | links to PmenuExtra | 06-links: 通过链接复用 `PmenuExtra` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpLabelMatch` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpMenu` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpMenuBorder` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpMenuSelection` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpScrollBarGutter` | links to PmenuSbar | 06-links: 通过链接复用 `PmenuSbar` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpScrollBarThumb` | links to PmenuThumb | 06-links: 通过链接复用 `PmenuThumb` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpSignatureHelp` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpSignatureHelpActiveParameter` | links to LspSignatureActiveParameter | 06-links: 通过链接复用 `LspSignatureActiveParameter` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpSignatureHelpBorder` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | blink.cmp 补全菜单相关组。 |
| `BlinkCmpSource` | links to PmenuExtra | 06-links: 通过链接复用 `PmenuExtra` 的定义。 | blink.cmp 补全菜单相关组。 |
| `CmpItemAbbr` | links to CmpItemAbbrDefault | 06-links: 通过链接复用 `CmpItemAbbrDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrDefault` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrDeprecated` | links to CmpItemAbbrDeprecatedDefault | 06-links: 通过链接复用 `CmpItemAbbrDeprecatedDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrDeprecatedDefault` | guifg=NvimLightGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrMatch` | links to CmpItemAbbrMatchDefault | 06-links: 通过链接复用 `CmpItemAbbrMatchDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrMatchDefault` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrMatchFuzzy` | links to CmpItemAbbrMatchFuzzyDefault | 06-links: 通过链接复用 `CmpItemAbbrMatchFuzzyDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemAbbrMatchFuzzyDefault` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKind` | links to CmpItemKindDefault | 06-links: 通过链接复用 `CmpItemKindDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindClass` | links to CmpItemKindClassDefault | 06-links: 通过链接复用 `CmpItemKindClassDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindClassDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindClassIcon` | links to CmpItemKindClassIconDefault | 06-links: 通过链接复用 `CmpItemKindClassIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindClassIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindColor` | links to CmpItemKindColorDefault | 06-links: 通过链接复用 `CmpItemKindColorDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindColorDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindColorIcon` | links to CmpItemKindColorIconDefault | 06-links: 通过链接复用 `CmpItemKindColorIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindColorIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstant` | links to CmpItemKindConstantDefault | 06-links: 通过链接复用 `CmpItemKindConstantDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstantDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstantIcon` | links to CmpItemKindConstantIconDefault | 06-links: 通过链接复用 `CmpItemKindConstantIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstantIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstructor` | links to CmpItemKindConstructorDefault | 06-links: 通过链接复用 `CmpItemKindConstructorDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstructorDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstructorIcon` | links to CmpItemKindConstructorIconDefault | 06-links: 通过链接复用 `CmpItemKindConstructorIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindConstructorIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindDefault` | guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnum` | links to CmpItemKindEnumDefault | 06-links: 通过链接复用 `CmpItemKindEnumDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumIcon` | links to CmpItemKindEnumIconDefault | 06-links: 通过链接复用 `CmpItemKindEnumIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumMember` | links to CmpItemKindEnumMemberDefault | 06-links: 通过链接复用 `CmpItemKindEnumMemberDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumMemberDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumMemberIcon` | links to CmpItemKindEnumMemberIconDefault | 06-links: 通过链接复用 `CmpItemKindEnumMemberIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEnumMemberIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEvent` | links to CmpItemKindEventDefault | 06-links: 通过链接复用 `CmpItemKindEventDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEventDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEventIcon` | links to CmpItemKindEventIconDefault | 06-links: 通过链接复用 `CmpItemKindEventIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindEventIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindField` | links to CmpItemKindFieldDefault | 06-links: 通过链接复用 `CmpItemKindFieldDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFieldDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFieldIcon` | links to CmpItemKindFieldIconDefault | 06-links: 通过链接复用 `CmpItemKindFieldIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFieldIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFile` | links to CmpItemKindFileDefault | 06-links: 通过链接复用 `CmpItemKindFileDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFileDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFileIcon` | links to CmpItemKindFileIconDefault | 06-links: 通过链接复用 `CmpItemKindFileIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFileIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFolder` | links to CmpItemKindFolderDefault | 06-links: 通过链接复用 `CmpItemKindFolderDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFolderDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFolderIcon` | links to CmpItemKindFolderIconDefault | 06-links: 通过链接复用 `CmpItemKindFolderIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFolderIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFunction` | links to CmpItemKindFunctionDefault | 06-links: 通过链接复用 `CmpItemKindFunctionDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFunctionDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFunctionIcon` | links to CmpItemKindFunctionIconDefault | 06-links: 通过链接复用 `CmpItemKindFunctionIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindFunctionIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindIcon` | links to CmpItemKindIconDefault | 06-links: 通过链接复用 `CmpItemKindIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindIconDefault` | guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindInterface` | links to CmpItemKindInterfaceDefault | 06-links: 通过链接复用 `CmpItemKindInterfaceDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindInterfaceDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindInterfaceIcon` | links to CmpItemKindInterfaceIconDefault | 06-links: 通过链接复用 `CmpItemKindInterfaceIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindInterfaceIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindKeyword` | links to CmpItemKindKeywordDefault | 06-links: 通过链接复用 `CmpItemKindKeywordDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindKeywordDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindKeywordIcon` | links to CmpItemKindKeywordIconDefault | 06-links: 通过链接复用 `CmpItemKindKeywordIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindKeywordIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindMethod` | links to CmpItemKindMethodDefault | 06-links: 通过链接复用 `CmpItemKindMethodDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindMethodDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindMethodIcon` | links to CmpItemKindMethodIconDefault | 06-links: 通过链接复用 `CmpItemKindMethodIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindMethodIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindModule` | links to CmpItemKindModuleDefault | 06-links: 通过链接复用 `CmpItemKindModuleDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindModuleDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindModuleIcon` | links to CmpItemKindModuleIconDefault | 06-links: 通过链接复用 `CmpItemKindModuleIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindModuleIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindOperator` | links to CmpItemKindOperatorDefault | 06-links: 通过链接复用 `CmpItemKindOperatorDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindOperatorDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindOperatorIcon` | links to CmpItemKindOperatorIconDefault | 06-links: 通过链接复用 `CmpItemKindOperatorIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindOperatorIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindProperty` | links to CmpItemKindPropertyDefault | 06-links: 通过链接复用 `CmpItemKindPropertyDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindPropertyDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindPropertyIcon` | links to CmpItemKindPropertyIconDefault | 06-links: 通过链接复用 `CmpItemKindPropertyIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindPropertyIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindReference` | links to CmpItemKindReferenceDefault | 06-links: 通过链接复用 `CmpItemKindReferenceDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindReferenceDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindReferenceIcon` | links to CmpItemKindReferenceIconDefault | 06-links: 通过链接复用 `CmpItemKindReferenceIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindReferenceIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindSnippet` | links to CmpItemKindSnippetDefault | 06-links: 通过链接复用 `CmpItemKindSnippetDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindSnippetDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindSnippetIcon` | links to CmpItemKindSnippetIconDefault | 06-links: 通过链接复用 `CmpItemKindSnippetIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindSnippetIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindStruct` | links to CmpItemKindStructDefault | 06-links: 通过链接复用 `CmpItemKindStructDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindStructDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindStructIcon` | links to CmpItemKindStructIconDefault | 06-links: 通过链接复用 `CmpItemKindStructIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindStructIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindText` | links to CmpItemKindTextDefault | 06-links: 通过链接复用 `CmpItemKindTextDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTextDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTextIcon` | links to CmpItemKindTextIconDefault | 06-links: 通过链接复用 `CmpItemKindTextIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTextIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTypeParameter` | links to CmpItemKindTypeParameterDefault | 06-links: 通过链接复用 `CmpItemKindTypeParameterDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTypeParameterDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTypeParameterIcon` | links to CmpItemKindTypeParameterIconDefault | 06-links: 通过链接复用 `CmpItemKindTypeParameterIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindTypeParameterIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindUnit` | links to CmpItemKindUnitDefault | 06-links: 通过链接复用 `CmpItemKindUnitDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindUnitDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindUnitIcon` | links to CmpItemKindUnitIconDefault | 06-links: 通过链接复用 `CmpItemKindUnitIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindUnitIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindValue` | links to CmpItemKindValueDefault | 06-links: 通过链接复用 `CmpItemKindValueDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindValueDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindValueIcon` | links to CmpItemKindValueIconDefault | 06-links: 通过链接复用 `CmpItemKindValueIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindValueIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindVariable` | links to CmpItemKindVariableDefault | 06-links: 通过链接复用 `CmpItemKindVariableDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindVariableDefault` | links to CmpItemKind | 06-links: 通过链接复用 `CmpItemKind` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindVariableIcon` | links to CmpItemKindVariableIconDefault | 06-links: 通过链接复用 `CmpItemKindVariableIconDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemKindVariableIconDefault` | links to CmpItemKindIcon | 06-links: 通过链接复用 `CmpItemKindIcon` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemMenu` | links to CmpItemMenuDefault | 06-links: 通过链接复用 `CmpItemMenuDefault` 的定义。 | nvim-cmp 补全菜单相关组。 |
| `CmpItemMenuDefault` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | nvim-cmp 补全菜单相关组。 |
| `GitSignsAdd` | links to Added | 06-links: 通过链接复用 `Added` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddCul` | links to GitSignsAdd | 06-links: 通过链接复用 `GitSignsAdd` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddInline` | links to TermCursor | 06-links: 通过链接复用 `TermCursor` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddLn` | links to DiffAdd | 06-links: 通过链接复用 `DiffAdd` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddLnInline` | links to GitSignsAddInline | 06-links: 通过链接复用 `GitSignsAddInline` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddNr` | links to GitSignsAdd | 06-links: 通过链接复用 `GitSignsAdd` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsAddPreview` | links to DiffAdd | 06-links: 通过链接复用 `DiffAdd` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChange` | links to Changed | 06-links: 通过链接复用 `Changed` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangeCul` | links to GitSignsChange | 06-links: 通过链接复用 `GitSignsChange` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangeInline` | links to TermCursor | 06-links: 通过链接复用 `TermCursor` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangeLn` | links to DiffChange | 06-links: 通过链接复用 `DiffChange` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangeLnInline` | links to GitSignsChangeInline | 06-links: 通过链接复用 `GitSignsChangeInline` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangeNr` | links to GitSignsChange | 06-links: 通过链接复用 `GitSignsChange` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangedelete` | links to GitSignsChange | 06-links: 通过链接复用 `GitSignsChange` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangedeleteCul` | links to GitSignsChangeCul | 06-links: 通过链接复用 `GitSignsChangeCul` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangedeleteLn` | links to GitSignsChangeLn | 06-links: 通过链接复用 `GitSignsChangeLn` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsChangedeleteNr` | links to GitSignsChangeNr | 06-links: 通过链接复用 `GitSignsChangeNr` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsCurrentLineBlame` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDelete` | links to Removed | 06-links: 通过链接复用 `Removed` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteCul` | links to GitSignsDelete | 06-links: 通过链接复用 `GitSignsDelete` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteInline` | links to TermCursor | 06-links: 通过链接复用 `TermCursor` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteLn` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteLnInline` | links to GitSignsDeleteInline | 06-links: 通过链接复用 `GitSignsDeleteInline` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteNr` | links to GitSignsDelete | 06-links: 通过链接复用 `GitSignsDelete` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeletePreview` | links to DiffDelete | 06-links: 通过链接复用 `DiffDelete` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteVirtLn` | links to DiffDelete | 06-links: 通过链接复用 `DiffDelete` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsDeleteVirtLnInLine` | links to GitSignsDeleteLnInline | 06-links: 通过链接复用 `GitSignsDeleteLnInline` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsNoEOLPreview` | links to Constant | 06-links: 通过链接复用 `Constant` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedAdd` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedAddCul` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedAddLn` | guifg=#77787c guibg=#005523 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedAddNr` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChange` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangeCul` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangeLn` | guifg=#77787c guibg=#4f5258 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangeNr` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangedelete` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangedeleteCul` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangedeleteLn` | guifg=#77787c guibg=#4f5258 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedChangedeleteNr` | guifg=#467c7b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedDelete` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedDeleteCul` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedDeleteNr` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedTopdelete` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedTopdeleteCul` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedTopdeleteLn` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedTopdeleteNr` | guifg=#7f605c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedUntracked` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedUntrackedCul` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedUntrackedLn` | guifg=#77787c guibg=#005523 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsStagedUntrackedNr` | guifg=#597b60 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsTopdelete` | links to GitSignsDelete | 06-links: 通过链接复用 `GitSignsDelete` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsTopdeleteCul` | links to GitSignsDeleteCul | 06-links: 通过链接复用 `GitSignsDeleteCul` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsTopdeleteLn` | links to GitSignsDeleteLn | 06-links: 通过链接复用 `GitSignsDeleteLn` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsTopdeleteNr` | links to GitSignsDeleteNr | 06-links: 通过链接复用 `GitSignsDeleteNr` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsUntracked` | links to GitSignsAdd | 06-links: 通过链接复用 `GitSignsAdd` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsUntrackedCul` | links to GitSignsAddCul | 06-links: 通过链接复用 `GitSignsAddCul` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsUntrackedLn` | links to GitSignsAddLn | 06-links: 通过链接复用 `GitSignsAddLn` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsUntrackedNr` | links to GitSignsAddNr | 06-links: 通过链接复用 `GitSignsAddNr` 的定义。 | gitsigns 改动标记与预览相关组。 |
| `GitSignsVirtLnum` | links to GitSignsDeleteVirtLn | 06-links: 通过链接复用 `GitSignsDeleteVirtLn` 的定义。 | gitsigns 改动标记与预览相关组。 |
