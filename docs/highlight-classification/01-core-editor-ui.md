# Part 1: Core Editor UI

覆盖 Neovim 基础 UI、窗口、菜单、消息、diff、拼写、可视选择等核心界面高亮组。

分类规则：
- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。
- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。
- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。

## 必设置

### 基础 UI / 编辑器

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `Added` | ctermfg=10 guifg=NvimLightGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | 通用新增标记。 |
| `Changed` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 通用修改标记。 |
| `ColorColumn` | cterm=reverse guibg=NvimDarkGrey4 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 色列背景。 |
| `Conceal` | guifg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 折叠或隐藏文本的占位显示。 |
| `Cursor` | guifg=bg guibg=fg | 02-special-alias: 当前组引用了 `fg`、`bg`、`NONE` 这类特殊别名值。 | 普通模式光标。 |
| `CursorColumn` | guibg=NvimDarkGrey3 | 01-palette-name: 当前组引用了命名调色板颜色。 | 当前列背景。 |
| `CursorLine` | guibg=NvimDarkGrey3 | 01-palette-name: 当前组引用了命名调色板颜色。 | 当前行背景。 |
| `CursorLineNr` | cterm=bold gui=bold | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 当前行行号。 |
| `DiffAdd` | ctermfg=0 ctermbg=10 guifg=NvimLightGrey1 guibg=NvimDarkGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | diff 新增内容。 |
| `DiffAddedGutter` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `DiffChange` | guifg=NvimLightGrey1 guibg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | diff 修改内容。 |
| `DiffDelete` | cterm=bold ctermfg=9 gui=bold guifg=NvimLightRed | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | diff 删除内容。 |
| `DiffModifiedGutter` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `DiffNoEOL` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `DiffRemovedGutter` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `DiffText` | ctermfg=0 ctermbg=14 guifg=NvimLightGrey1 guibg=NvimDarkCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | diff 中更强调的变化片段。 |
| `DiffTextAdd` | links to DiffText | 06-links: 通过链接复用 `DiffText` 的定义。 | diff 新增文本强调片段。 |
| `Directory` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 目录名。 |
| `EndOfBuffer` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | 缓冲区结尾后的空行区域。 |
| `ErrorMsg` | ctermfg=9 guifg=NvimLightRed | 01-palette-name: 当前组引用了命名调色板颜色。 | 错误消息。 |
| `FloatBorder` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | 浮动窗口边框。 |
| `FloatTitle` | links to Title | 06-links: 通过链接复用 `Title` 的定义。 | 浮动窗口标题。 |
| `FoldColumn` | links to SignColumn | 06-links: 通过链接复用 `SignColumn` 的定义。 | 折叠列。 |
| `Folded` | guifg=NvimLightGrey4 guibg=NvimDarkGrey1 | 01-palette-name: 当前组引用了命名调色板颜色。 | 被折叠文本的显示样式。 |
| `LineNr` | guifg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 普通行号。 |
| `MatchParen` | cterm=bold,underline gui=bold guibg=NvimDarkGrey4 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 匹配括号。 |
| `ModeMsg` | ctermfg=10 guifg=NvimLightGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | 模式切换提示。 |
| `MoreMsg` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 更多信息提示。 |
| `NonText` | guifg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 非正文字符，例如结尾符号。 |
| `Normal` | guifg=NvimLightGrey2 guibg=NvimDarkGrey2 | 01-palette-name: 当前组引用了命名调色板颜色。 | 普通文本区域的基础高亮，绝大多数界面的默认前景和背景。 |
| `NormalFloat` | guibg=NvimDarkGrey1 | 01-palette-name: 当前组引用了命名调色板颜色。 | 浮动窗口正文。 |
| `OkMsg` | ctermfg=10 guifg=NvimLightGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | 成功提示消息。 |
| `Pmenu` | cterm=reverse guibg=NvimDarkGrey3 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 补全菜单主体。 |
| `PmenuMatch` | cterm=bold gui=bold | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 补全菜单中匹配到的文本。 |
| `PmenuMatchSel` | cterm=bold gui=bold | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 补全菜单选中项中的匹配文本。 |
| `PmenuSel` | cterm=underline,reverse gui=reverse blend=0 | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 补全菜单选中项。 |
| `Question` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | 提示用户确认或提问的信息。 |
| `Removed` | ctermfg=9 guifg=NvimLightRed | 01-palette-name: 当前组引用了命名调色板颜色。 | 通用删除标记。 |
| `Search` | ctermfg=0 ctermbg=11 guifg=NvimLightGrey1 guibg=NvimDarkYellow | 01-palette-name: 当前组引用了命名调色板颜色。 | 普通搜索匹配。 |
| `SearchSpecialSearchType` | links to MoreMsg | 06-links: 通过链接复用 `MoreMsg` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignColumn` | guifg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | sign 列，例如诊断、git 标记所在区域。 |
| `SpecialKey` | links to Special | 06-links: 通过链接复用 `Special` 的定义。 | 特殊按键与不可显示字符。 |
| `StatusLine` | cterm=reverse guifg=NvimLightGrey2 guibg=NvimDarkGrey4 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 当前窗口状态栏。 |
| `StatusLineNC` | cterm=bold,underline guifg=NvimLightGrey3 guibg=NvimDarkGrey3 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 非当前窗口状态栏。 |
| `StderrMsg` | links to ErrorMsg | 06-links: 通过链接复用 `ErrorMsg` 的定义。 | 标准错误输出消息。 |
| `Substitute` | links to Search | 06-links: 通过链接复用 `Search` 的定义。 | 替换命令中将被替换的内容。 |
| `TabLine` | links to StatusLineNC | 06-links: 通过链接复用 `StatusLineNC` 的定义。 | 标签页栏中的普通项。 |
| `TabLineFill` | links to TabLine | 06-links: 通过链接复用 `TabLine` 的定义。 | 标签页栏剩余填充区域。 |
| `TabLineSel` | gui=bold | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 标签页栏中的选中项。 |
| `TermCursor` | cterm=reverse gui=reverse | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 终端缓冲区中的光标。 |
| `Title` | cterm=bold gui=bold guifg=NvimLightGrey2 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 标题文本。 |
| `VertSplit` | links to WinSeparator | 06-links: 通过链接复用 `WinSeparator` 的定义。 | 旧式垂直分隔线组，通常链接到 WinSeparator。 |
| `Visual` | ctermfg=0 ctermbg=15 guibg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 可视模式选区。 |
| `VisualNOS` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | 非拥有选择权时的可视选区。 |
| `WarningMsg` | ctermfg=11 guifg=NvimLightYellow | 01-palette-name: 当前组引用了命名调色板颜色。 | 警告消息。 |
| `Whitespace` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | 空白字符可视化。 |
| `WinSeparator` | links to Normal | 06-links: 通过链接复用 `Normal` 的定义。 | 窗口分隔线。 |

### 基础杂项

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `CopilotAnnotation` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `CopilotSuggestion` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `CurSearch` | ctermfg=0 ctermbg=11 guifg=NvimDarkGrey1 guibg=NvimLightYellow | 01-palette-name: 当前组引用了命名调色板颜色。 | 当前搜索命中。 |
| `GitGutterAdd` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterAddLine` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterAddLineNr` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterChange` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterChangeLine` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterChangeLineNr` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterDelete` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterDeleteLine` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `GitGutterDeleteLineNr` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `IncSearch` | links to CurSearch | 06-links: 通过链接复用 `CurSearch` 的定义。 | 增量搜索命中。 |
| `MarkSignHL` | links to Identifier | 06-links: 通过链接复用 `Identifier` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `MarkSignNumHL` | links to CursorLineNr | 06-links: 通过链接复用 `CursorLineNr` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `MarkVirtTextHL` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord1` | ctermfg=0 ctermbg=12 guifg=#001e80 guibg=#a1b7ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord10` | ctermfg=0 ctermbg=130 guifg=#803000 guibg=#ffc4a1 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord11` | ctermfg=0 ctermbg=2 guifg=#3f8000 guibg=#d0ffa1 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord12` | ctermfg=0 ctermbg=9 guifg=#6f8000 guibg=#f3ffa1 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord13` | ctermfg=248 ctermbg=15 guifg=#999999 guibg=#e3e3d2 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord14` | ctermfg=15 ctermbg=7 guifg=#666666 guibg=#d3d3c3 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord15` | ctermfg=0 ctermbg=248 guifg=#222222 guibg=#a3a396 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord16` | ctermfg=15 ctermbg=0 guifg=#dddddd guibg=#53534c | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord17` | ctermfg=248 ctermbg=0 guifg=#aaaaaa guibg=#131311 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord18` | ctermfg=15 ctermbg=12 guifg=#f0f0ff guibg=#0000ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord19` | ctermfg=15 ctermbg=1 guifg=#ffffff guibg=#ff0000 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord2` | ctermfg=0 ctermbg=13 guifg=#80005d guibg=#ffa1c6 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord20` | ctermfg=15 ctermbg=2 guifg=#355f35 guibg=#00ff00 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord21` | ctermfg=15 ctermbg=3 guifg=#6f6f4c guibg=#ffff00 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord3` | ctermfg=0 ctermbg=10 guifg=#0f8000 guibg=#acffa1 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord4` | ctermfg=0 ctermbg=11 guifg=#806000 guibg=#ffe8a1 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord5` | ctermfg=0 ctermbg=6 guifg=#420080 guibg=#d2a1ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord6` | ctermfg=0 ctermbg=14 guifg=#007f80 guibg=#a1feff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord7` | ctermfg=0 ctermbg=4 guifg=#004e80 guibg=#a1dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord8` | ctermfg=0 ctermbg=5 guifg=#120080 guibg=#a29ccf | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `MarkWord9` | ctermfg=0 ctermbg=1 guifg=#720080 guibg=#f5a1ff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `Method` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `MultiCursor` | links to VM_Cursor | 06-links: 通过链接复用 `VM_Cursor` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `NONE` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `Scrollbar` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarCursor` | ctermfg=0 guifg=#e0e2ea | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarCursorHandle` | ctermfg=0 ctermbg=15 guifg=#e0e2ea guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarError` | ctermfg=0 guifg=#ffc0b9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarErrorHandle` | ctermfg=0 ctermbg=15 guifg=#ffc0b9 guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitAdd` | ctermfg=0 guifg=#e0e2ea | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitAddHandle` | ctermfg=0 ctermbg=15 guifg=#e0e2ea guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitChange` | ctermfg=0 guifg=#e0e2ea | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitChangeHandle` | ctermfg=0 ctermbg=15 guifg=#e0e2ea guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitDelete` | ctermfg=0 guifg=#e0e2ea | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarGitDeleteHandle` | ctermfg=0 ctermbg=15 guifg=#e0e2ea guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarHandle` | ctermbg=15 guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarHint` | ctermfg=0 guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarHintHandle` | ctermfg=0 ctermbg=15 guifg=#a6dbff guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarInfo` | ctermfg=0 guifg=#8cf8f7 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarInfoHandle` | ctermfg=0 ctermbg=15 guifg=#8cf8f7 guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarMisc` | ctermfg=0 guifg=#e0e2ea | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarMiscHandle` | ctermfg=0 ctermbg=15 guifg=#e0e2ea guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarSearch` | ctermfg=0 guifg=#eef1f8 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarSearchHandle` | ctermfg=0 ctermbg=15 guifg=#eef1f8 guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarWarn` | ctermfg=0 guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `ScrollbarWarnHandle` | ctermfg=0 ctermbg=15 guifg=#fce094 guibg=#606060 blend=0 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `SignifyLineAdd` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignifyLineChange` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignifyLineDelete` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignifySignAdd` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignifySignChange` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SignifySignDelete` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `Struct` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | Neovim 基础界面或兼容高亮组。 |
| `SymbolUsageText` | links to Comment | 06-links: 通过链接复用 `Comment` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextArrow` | guifg=#4f5258 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextArrowNoBg` | guifg=#4f5258 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextBg` | guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextError` | guifg=#ffc0b9 guibg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorCursorLine` | guifg=#ffc0b9 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorMixError` | guifg=#ffc0b9 guibg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorMixHint` | guifg=#ffc0b9 guibg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorMixInfo` | guifg=#ffc0b9 guibg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorMixWarn` | guifg=#ffc0b9 guibg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextErrorNoBg` | guifg=#ffc0b9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHint` | guifg=#a6dbff guibg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintCursorLine` | guifg=#a6dbff guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintMixError` | guifg=#a6dbff guibg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintMixHint` | guifg=#a6dbff guibg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintMixInfo` | guifg=#a6dbff guibg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintMixWarn` | guifg=#a6dbff guibg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextHintNoBg` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfo` | guifg=#8cf8f7 guibg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoCursorLine` | guifg=#8cf8f7 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoMixError` | guifg=#8cf8f7 guibg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoMixHint` | guifg=#8cf8f7 guibg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoMixInfo` | guifg=#8cf8f7 guibg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoMixWarn` | guifg=#8cf8f7 guibg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextInfoNoBg` | guifg=#8cf8f7 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarn` | guifg=#fce094 guibg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnCursorLine` | guifg=#fce094 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnMixError` | guifg=#fce094 guibg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnMixHint` | guifg=#fce094 guibg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnMixInfo` | guifg=#fce094 guibg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnMixWarn` | guifg=#fce094 guibg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineDiagnosticVirtualTextWarnNoBg` | guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextError` | guifg=#483b3e guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextErrorCursorLine` | guifg=#483b3e guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextErrorNoBg` | guifg=#483b3e | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextHint` | guifg=#34414d guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextHintCursorLine` | guifg=#34414d guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextHintNoBg` | guifg=#34414d | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextInfo` | guifg=#2e484b guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextInfoCursorLine` | guifg=#2e484b guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextInfoNoBg` | guifg=#2e484b | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextWarn` | guifg=#474236 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextWarnCursorLine` | guifg=#474236 guibg=#2c2e33 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TinyInlineInvDiagnosticVirtualTextWarnNoBg` | guifg=#474236 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgFIX` | gui=bold guifg=#14161b guibg=#ffc0b9 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgHACK` | gui=bold guifg=#14161b guibg=#fce094 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgNOTE` | gui=bold guifg=#14161b guibg=#a6dbff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgPERF` | gui=bold guifg=#14161b guibg=#a6dbff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgTEST` | gui=bold guifg=#14161b guibg=#a6dbff | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgTODO` | gui=bold guifg=#14161b guibg=#8cf8f7 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoBgWARN` | gui=bold guifg=#14161b guibg=#fce094 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgFIX` | guifg=#ffc0b9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgHACK` | guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgNOTE` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgPERF` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgTEST` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgTODO` | guifg=#8cf8f7 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoFgWARN` | guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignFIX` | guifg=#ffc0b9 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignHACK` | guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignNOTE` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignPERF` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignTEST` | guifg=#a6dbff | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignTODO` | guifg=#8cf8f7 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TodoSignWARN` | guifg=#fce094 | 03-hex-specified: 当前组直接写入了十六进制颜色值。 | Neovim 基础界面或兼容高亮组。 |
| `TreesitterContext` | links to NormalFloat | 06-links: 通过链接复用 `NormalFloat` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `TreesitterContextBottom` | links to NONE | 06-links: 通过链接复用 `NONE` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `TreesitterContextLineNumber` | links to LineNr | 06-links: 通过链接复用 `LineNr` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `TreesitterContextLineNumberBottom` | links to TreesitterContextBottom | 06-links: 通过链接复用 `TreesitterContextBottom` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `TreesitterContextSeparator` | links to FloatBorder | 06-links: 通过链接复用 `FloatBorder` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `VM_Cursor` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `VM_Extend` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `VM_Insert` | links to DiffChange | 06-links: 通过链接复用 `DiffChange` 的定义。 | Neovim 基础界面或兼容高亮组。 |
| `VM_Mono` | links to IncSearch | 06-links: 通过链接复用 `IncSearch` 的定义。 | Neovim 基础界面或兼容高亮组。 |

## 可选

### 基础 UI / 编辑器

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `ComplHint` | links to NonText | 06-links: 通过链接复用 `NonText` 的定义。 | 补全提示文本。 |
| `ComplHintMore` | links to MoreMsg | 06-links: 通过链接复用 `MoreMsg` 的定义。 | 补全更多提示。 |
| `ComplMatchIns` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 插入模式补全匹配文本。 |
| `CursorIM` | links to Cursor | 06-links: 通过链接复用 `Cursor` 的定义。 | 输入法模式光标。 |
| `CursorLineFold` | links to FoldColumn | 06-links: 通过链接复用 `FoldColumn` 的定义。 | 当前行折叠列。 |
| `CursorLineSign` | links to SignColumn | 06-links: 通过链接复用 `SignColumn` 的定义。 | 当前行 sign 列。 |
| `FloatFooter` | links to FloatTitle | 06-links: 通过链接复用 `FloatTitle` 的定义。 | 浮动窗口底部标题或附注。 |
| `FloatShadow` | ctermbg=0 guibg=NvimDarkGrey4 blend=80 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 浮动窗口阴影。 |
| `FloatShadowThrough` | ctermbg=0 guibg=NvimDarkGrey4 blend=100 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 浮动窗口穿透阴影。 |
| `LineNrAbove` | links to LineNr | 06-links: 通过链接复用 `LineNr` 的定义。 | 当前行上方的相对行号。 |
| `LineNrBelow` | links to LineNr | 06-links: 通过链接复用 `LineNr` 的定义。 | 当前行下方的相对行号。 |
| `MsgArea` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 命令行消息区域。 |
| `MsgSeparator` | links to StatusLine | 06-links: 通过链接复用 `StatusLine` 的定义。 | 消息区域分隔线。 |
| `NormalNC` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 非当前窗口的普通文本区域。 |
| `PmenuBorder` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | 补全菜单边框。 |
| `PmenuExtra` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | 补全菜单额外信息列。 |
| `PmenuExtraSel` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | 补全菜单选中项的额外信息列。 |
| `PmenuKind` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | 补全菜单项种类列。 |
| `PmenuKindSel` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | 补全菜单选中项的种类列。 |
| `PmenuSbar` | links to Pmenu | 06-links: 通过链接复用 `Pmenu` 的定义。 | 补全菜单滚动条背景。 |
| `PmenuShadow` | links to FloatShadow | 06-links: 通过链接复用 `FloatShadow` 的定义。 | 补全菜单阴影。 |
| `PmenuShadowThrough` | links to FloatShadowThrough | 06-links: 通过链接复用 `FloatShadowThrough` 的定义。 | 补全菜单穿透阴影。 |
| `PmenuThumb` | guibg=NvimDarkGrey4 | 01-palette-name: 当前组引用了命名调色板颜色。 | 补全菜单滚动条滑块。 |
| `PreInsert` | links to Added | 06-links: 通过链接复用 `Added` 的定义。 | 插入前提示状态。 |
| `QuickFixLine` | ctermfg=14 guifg=NvimLightCyan | 01-palette-name: 当前组引用了命名调色板颜色。 | quickfix 中当前项。 |
| `RedrawDebugClear` | ctermfg=0 ctermbg=11 guibg=NvimDarkYellow | 01-palette-name: 当前组引用了命名调色板颜色。 | 重绘调试状态：清理。 |
| `RedrawDebugComposed` | ctermfg=0 ctermbg=10 guibg=NvimDarkGreen | 01-palette-name: 当前组引用了命名调色板颜色。 | 重绘调试状态：组合完成。 |
| `RedrawDebugNormal` | cterm=reverse gui=reverse | 04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。 | 重绘调试状态：普通。 |
| `RedrawDebugRecompose` | ctermfg=0 ctermbg=9 guibg=NvimDarkRed | 01-palette-name: 当前组引用了命名调色板颜色。 | 重绘调试状态：重新组合。 |
| `SpellBad` | cterm=undercurl gui=undercurl guisp=NvimLightRed | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 拼写错误。 |
| `SpellCap` | cterm=undercurl gui=undercurl guisp=NvimLightYellow | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 大小写类拼写问题。 |
| `SpellLocal` | cterm=undercurl gui=undercurl guisp=NvimLightGreen | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 本地化拼写问题。 |
| `SpellRare` | cterm=undercurl gui=undercurl guisp=NvimLightCyan | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 罕见词拼写问题。 |
| `StatusLineTerm` | links to StatusLine | 06-links: 通过链接复用 `StatusLine` 的定义。 | 终端窗口状态栏。 |
| `StatusLineTermNC` | links to StatusLineNC | 06-links: 通过链接复用 `StatusLineNC` 的定义。 | 非当前终端窗口状态栏。 |
| `StdoutMsg` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 标准输出消息。 |
| `VisualNC` | cleared | 07-cleared: 当前组已清空，没有独立高亮定义。 | 非当前窗口中的可视选区。 |
| `WildMenu` | links to PmenuSel | 06-links: 通过链接复用 `PmenuSel` 的定义。 | 命令行 wildmenu 选中项。 |
| `WinBar` | cterm=bold gui=bold guifg=NvimLightGrey4 guibg=NvimDarkGrey1 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 窗口顶部栏。 |
| `WinBarNC` | cterm=bold guifg=NvimLightGrey4 guibg=NvimDarkGrey1 | 05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。 | 非当前窗口顶部栏。 |

### 基础杂项

| Group | 状态 | 状态说明 | 说明 |
| --- | --- | --- | --- |
| `SnippetTabstop` | links to Visual | 06-links: 通过链接复用 `Visual` 的定义。 | 代码片段跳位。 |
| `SnippetTabstopActive` | links to SnippetTabstop | 06-links: 通过链接复用 `SnippetTabstop` 的定义。 | 当前活跃的代码片段跳位。 |
| `lCursor` | guifg=bg guibg=fg | 02-special-alias: 当前组引用了 `fg`、`bg`、`NONE` 这类特殊别名值。 | 语言映射相关光标。 |
