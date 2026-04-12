from __future__ import annotations

from pathlib import Path
import re


INPUT_FILE = Path("highlight_default.txt")
OUTPUT_DIR = Path("docs/highlight-classification")


PLUGIN_PREFIXES = [
    "BufferLine",
    "Notify",
    "lualine",
    "NvimTree",
    "Cmp",
    "BlinkCmp",
    "GitSigns",
    "RainbowDelimiter",
    "Telescope",
    "Mason",
    "WhichKey",
    "Noice",
    "Navic",
    "Mini",
    "NeoTree",
    "Aerial",
    "Alpha",
    "Lazy",
    "Trouble",
    "Leap",
    "Flash",
    "Hop",
    "Dap",
    "Neogit",
    "Illuminate",
    "RenderMarkdown",
    "Snacks",
    "Oil",
    "Avante",
    "Outline",
    "DropBar",
    "IndentBlankline",
    "Ibl",
]

SUPPORTED_PLUGIN_PREFIXES = {"Cmp", "BlinkCmp", "GitSigns", "RainbowDelimiter", "NvimTree"}

SYNTAX_NAMES = {
    "Comment",
    "Constant",
    "String",
    "Character",
    "Number",
    "Boolean",
    "Float",
    "Identifier",
    "Function",
    "Statement",
    "Conditional",
    "Repeat",
    "Label",
    "Operator",
    "Keyword",
    "Exception",
    "PreProc",
    "Include",
    "Define",
    "Macro",
    "PreCondit",
    "StorageClass",
    "Structure",
    "Typedef",
    "Type",
    "Special",
    "SpecialChar",
    "Tag",
    "Delimiter",
    "SpecialComment",
    "Debug",
    "Ignore",
    "Error",
    "Todo",
    "Underlined",
}

OPTIONAL_CORE = {
    "VisualNC",
    "NormalNC",
    "MsgArea",
    "StdoutMsg",
    "ComplMatchIns",
    "PreInsert",
    "PmenuShadow",
    "PmenuShadowThrough",
    "FloatShadow",
    "FloatShadowThrough",
    "StatusLineTerm",
    "StatusLineTermNC",
    "CursorIM",
    "lCursor",
    "WinBar",
    "WinBarNC",
    "RedrawDebugNormal",
    "RedrawDebugClear",
    "RedrawDebugComposed",
    "RedrawDebugRecompose",
    "LineNrAbove",
    "LineNrBelow",
    "CursorLineSign",
    "CursorLineFold",
    "PmenuKind",
    "PmenuKindSel",
    "PmenuExtra",
    "PmenuExtraSel",
    "PmenuBorder",
    "PmenuSbar",
    "PmenuThumb",
    "FloatFooter",
    "MsgSeparator",
    "QuickFixLine",
    "WildMenu",
    "SpellBad",
    "SpellCap",
    "SpellRare",
    "SpellLocal",
    "SnippetTabstop",
    "SnippetTabstopActive",
    "ComplHint",
    "ComplHintMore",
}

CORE_DESCRIPTIONS = {
    "Normal": "普通文本区域的基础高亮，绝大多数界面的默认前景和背景。",
    "NormalNC": "非当前窗口的普通文本区域。",
    "NormalFloat": "浮动窗口正文。",
    "FloatBorder": "浮动窗口边框。",
    "FloatTitle": "浮动窗口标题。",
    "FloatFooter": "浮动窗口底部标题或附注。",
    "Cursor": "普通模式光标。",
    "CursorIM": "输入法模式光标。",
    "lCursor": "语言映射相关光标。",
    "TermCursor": "终端缓冲区中的光标。",
    "CursorLine": "当前行背景。",
    "CursorColumn": "当前列背景。",
    "CursorLineNr": "当前行行号。",
    "CursorLineSign": "当前行 sign 列。",
    "CursorLineFold": "当前行折叠列。",
    "LineNr": "普通行号。",
    "LineNrAbove": "当前行上方的相对行号。",
    "LineNrBelow": "当前行下方的相对行号。",
    "SignColumn": "sign 列，例如诊断、git 标记所在区域。",
    "FoldColumn": "折叠列。",
    "Folded": "被折叠文本的显示样式。",
    "StatusLine": "当前窗口状态栏。",
    "StatusLineNC": "非当前窗口状态栏。",
    "StatusLineTerm": "终端窗口状态栏。",
    "StatusLineTermNC": "非当前终端窗口状态栏。",
    "WinSeparator": "窗口分隔线。",
    "VertSplit": "旧式垂直分隔线组，通常链接到 WinSeparator。",
    "WinBar": "窗口顶部栏。",
    "WinBarNC": "非当前窗口顶部栏。",
    "TabLine": "标签页栏中的普通项。",
    "TabLineSel": "标签页栏中的选中项。",
    "TabLineFill": "标签页栏剩余填充区域。",
    "Pmenu": "补全菜单主体。",
    "PmenuSel": "补全菜单选中项。",
    "PmenuMatch": "补全菜单中匹配到的文本。",
    "PmenuMatchSel": "补全菜单选中项中的匹配文本。",
    "PmenuKind": "补全菜单项种类列。",
    "PmenuKindSel": "补全菜单选中项的种类列。",
    "PmenuExtra": "补全菜单额外信息列。",
    "PmenuExtraSel": "补全菜单选中项的额外信息列。",
    "PmenuSbar": "补全菜单滚动条背景。",
    "PmenuThumb": "补全菜单滚动条滑块。",
    "PmenuBorder": "补全菜单边框。",
    "PmenuShadow": "补全菜单阴影。",
    "PmenuShadowThrough": "补全菜单穿透阴影。",
    "FloatShadow": "浮动窗口阴影。",
    "FloatShadowThrough": "浮动窗口穿透阴影。",
    "Visual": "可视模式选区。",
    "VisualNOS": "非拥有选择权时的可视选区。",
    "VisualNC": "非当前窗口中的可视选区。",
    "Search": "普通搜索匹配。",
    "CurSearch": "当前搜索命中。",
    "IncSearch": "增量搜索命中。",
    "Substitute": "替换命令中将被替换的内容。",
    "ColorColumn": "色列背景。",
    "Conceal": "折叠或隐藏文本的占位显示。",
    "Whitespace": "空白字符可视化。",
    "NonText": "非正文字符，例如结尾符号。",
    "EndOfBuffer": "缓冲区结尾后的空行区域。",
    "SpecialKey": "特殊按键与不可显示字符。",
    "Directory": "目录名。",
    "Title": "标题文本。",
    "Question": "提示用户确认或提问的信息。",
    "MoreMsg": "更多信息提示。",
    "ModeMsg": "模式切换提示。",
    "ErrorMsg": "错误消息。",
    "WarningMsg": "警告消息。",
    "OkMsg": "成功提示消息。",
    "StderrMsg": "标准错误输出消息。",
    "StdoutMsg": "标准输出消息。",
    "MsgArea": "命令行消息区域。",
    "MsgSeparator": "消息区域分隔线。",
    "WildMenu": "命令行 wildmenu 选中项。",
    "QuickFixLine": "quickfix 中当前项。",
    "Underlined": "带下划线的文本，常用于链接。",
    "MatchParen": "匹配括号。",
    "SpellBad": "拼写错误。",
    "SpellCap": "大小写类拼写问题。",
    "SpellRare": "罕见词拼写问题。",
    "SpellLocal": "本地化拼写问题。",
    "DiffAdd": "diff 新增内容。",
    "DiffChange": "diff 修改内容。",
    "DiffDelete": "diff 删除内容。",
    "DiffText": "diff 中更强调的变化片段。",
    "DiffTextAdd": "diff 新增文本强调片段。",
    "Added": "通用新增标记。",
    "Removed": "通用删除标记。",
    "Changed": "通用修改标记。",
    "ComplMatchIns": "插入模式补全匹配文本。",
    "ComplHint": "补全提示文本。",
    "ComplHintMore": "补全更多提示。",
    "PreInsert": "插入前提示状态。",
    "RedrawDebugNormal": "重绘调试状态：普通。",
    "RedrawDebugClear": "重绘调试状态：清理。",
    "RedrawDebugComposed": "重绘调试状态：组合完成。",
    "RedrawDebugRecompose": "重绘调试状态：重新组合。",
    "Comment": "传统 Vim 语法组：注释。",
    "Constant": "传统 Vim 语法组：常量。",
    "String": "传统 Vim 语法组：字符串。",
    "Character": "传统 Vim 语法组：字符。",
    "Number": "传统 Vim 语法组：数字。",
    "Boolean": "传统 Vim 语法组：布尔。",
    "Float": "传统 Vim 语法组：浮点数。",
    "Identifier": "传统 Vim 语法组：标识符。",
    "Function": "传统 Vim 语法组：函数。",
    "Statement": "传统 Vim 语法组：语句关键字总类。",
    "Conditional": "传统 Vim 语法组：条件关键字。",
    "Repeat": "传统 Vim 语法组：循环关键字。",
    "Label": "传统 Vim 语法组：标签。",
    "Operator": "传统 Vim 语法组：运算符。",
    "Keyword": "传统 Vim 语法组：关键字。",
    "Exception": "传统 Vim 语法组：异常处理关键字。",
    "PreProc": "传统 Vim 语法组：预处理。",
    "Include": "传统 Vim 语法组：导入。",
    "Define": "传统 Vim 语法组：定义。",
    "Macro": "传统 Vim 语法组：宏。",
    "PreCondit": "传统 Vim 语法组：条件预处理。",
    "StorageClass": "传统 Vim 语法组：存储类。",
    "Structure": "传统 Vim 语法组：结构体。",
    "Typedef": "传统 Vim 语法组：类型别名。",
    "Type": "传统 Vim 语法组：类型。",
    "Special": "传统 Vim 语法组：特殊内容。",
    "SpecialChar": "传统 Vim 语法组：特殊字符。",
    "Tag": "传统 Vim 语法组：标签。",
    "Delimiter": "传统 Vim 语法组：分隔符。",
    "SpecialComment": "传统 Vim 语法组：特殊注释。",
    "Debug": "传统 Vim 语法组：调试标记。",
    "Ignore": "传统 Vim 语法组：可忽略内容。",
    "Error": "传统 Vim 语法组：错误。",
    "Todo": "传统 Vim 语法组：待办标记。",
    "SnippetTabstop": "代码片段跳位。",
    "SnippetTabstopActive": "当前活跃的代码片段跳位。",
}

TREESITTER_BASE_MAP = {
    "variable": "变量",
    "constant": "常量",
    "module": "模块 / 命名空间",
    "label": "标签",
    "string": "字符串",
    "character": "字符",
    "boolean": "布尔值",
    "number": "数字",
    "type": "类型",
    "attribute": "属性标注 / annotation",
    "property": "属性",
    "function": "函数",
    "constructor": "构造器",
    "operator": "运算符",
    "keyword": "关键字",
    "punctuation": "标点 / 分隔符",
    "comment": "注释",
    "markup": "标记文本",
    "diff": "diff 标记",
    "tag": "标签",
    "parameter": "参数",
    "field": "字段",
    "namespace": "命名空间",
    "symbol": "符号",
    "method": "方法",
    "text": "旧式 text 捕获",
    "repeat": "循环关键字",
    "conditional": "条件关键字",
    "exception": "异常关键字",
    "include": "导入关键字",
    "define": "定义关键字",
    "preproc": "预处理关键字",
    "float": "浮点数字",
    "storageclass": "存储类关键字",
}

PARTS = [
    ("01-core-editor-ui.md", "Part 1: Core Editor UI", "覆盖 Neovim 基础 UI、窗口、菜单、消息、diff、拼写、可视选择等核心界面高亮组。"),
    ("02-core-syntax-and-vim-internals.md", "Part 2: Core Syntax And Vim Internals", "覆盖传统 Vim 语法组以及 `Nvim*` 内部语法解析组。"),
    ("03-treesitter.md", "Part 3: TreeSitter", "覆盖 TreeSitter captures，包括基础 captures、兼容别名与语言特化 captures。"),
    ("04-lsp-and-diagnostics.md", "Part 4: LSP And Diagnostics", "覆盖 Diagnostic、LSP UI、LSP semantic token 与旧式兼容诊断组。"),
    ("05-supported-integrations.md", "Part 5: Supported Integrations", "覆盖 `spectra.nvim` 当前共享运行时已支持的插件集成组，例如 `cmp`、`blink`、`gitsigns`、`rainbow-delimiters`、`nvim-tree`。"),
    ("06-external-plugin-groups.md", "Part 6: External Plugin Groups", "覆盖当前环境中来自外部插件、状态栏、通知系统和私有生态的高亮组。这些通常不应成为通用主题框架的必做项。"),
    ("07-devicons.md", "Part 7: DevIcons", "覆盖 `nvim-web-devicons` 及其派生出来的文件类型图标高亮组。这些通常不应放在核心编辑器 UI 分类中。"),
]


def plugin_prefix(name: str) -> str | None:
    for prefix in PLUGIN_PREFIXES:
        if name.startswith(prefix):
            return prefix
    return None


def category(name: str) -> str:
    if "DevIcon" in name:
        return "devicons"
    if name.startswith("@lsp.") or name.startswith("Lsp") or name.startswith("Diagnostic"):
        return "lsp"
    if name.startswith("@"):
        return "treesitter"
    prefix = plugin_prefix(name)
    if prefix:
        return "plugin"
    if name in SYNTAX_NAMES or name.startswith("Nvim") or name.startswith("vim"):
        return "syntax"
    return "core"


def part_for(name: str) -> str:
    cat = category(name)
    if cat == "devicons":
        return "07-devicons.md"
    if cat == "core":
        return "01-core-editor-ui.md"
    if cat == "syntax":
        return "02-core-syntax-and-vim-internals.md"
    if cat == "treesitter":
        return "03-treesitter.md"
    if cat == "lsp":
        return "04-lsp-and-diagnostics.md"
    prefix = plugin_prefix(name)
    if prefix in SUPPORTED_PLUGIN_PREFIXES:
        return "05-supported-integrations.md"
    return "06-external-plugin-groups.md"


def necessity(name: str) -> str:
    if name in {"@none", "@spell"}:
        return "不必要"

    cat = category(name)
    if cat == "devicons":
        return "不必要"
    if cat == "plugin":
        return "可选" if plugin_prefix(name) in SUPPORTED_PLUGIN_PREFIXES else "不必要"

    if cat == "treesitter":
        base = re.sub(r"\.(markdown|html|css|scss|python|c_sharp|cpp|rust|yaml|tsx)$", "", name)
        if re.match(r"^@(variable|constant|module|string|character|boolean|number|type|attribute|property|function|constructor|operator|keyword|comment|markup|diff|tag)(\.|$)", base):
            if re.search(r"\.(markdown|html|css|scss|python|c_sharp|cpp|rust|yaml|tsx)$", name):
                return "可选"
            return "必设置"
        return "可选"

    if cat == "lsp":
        if (
            name.startswith("Diagnostic")
            or name.startswith("LspReference")
            or name.startswith("LspCodeLens")
            or name in {"LspInlayHint", "LspSignatureActiveParameter", "LspInfoBorder"}
            or name.startswith("@lsp.type.")
        ):
            return "必设置"
        return "可选"

    if cat == "syntax":
        if name.startswith("Nvim"):
            return "可选"
        return "必设置"

    if name in OPTIONAL_CORE:
        return "可选"
    return "必设置"


def subcategory(name: str) -> str:
    cat = category(name)
    if cat == "core":
        if re.match(
            r"^(Normal|Cursor|LineNr|StatusLine|WinSeparator|VertSplit|TabLine|Pmenu|Float|WinBar|Msg|Title|Directory|Question|QuickFixLine|WildMenu|Fold|ColorColumn|Conceal|Whitespace|NonText|EndOfBuffer|SignColumn|Visual|Search|Diff|Added|Removed|Changed|Spell|MatchParen|TermCursor|SpecialKey|CursorColumn|CursorLine|Underlined|RedrawDebug|OkMsg|ErrorMsg|WarningMsg|MoreMsg|ModeMsg|StdoutMsg|StderrMsg|Substitute|Compl|PreInsert)"
        , name):
            return "基础 UI / 编辑器"
        return "基础杂项"
    if cat == "syntax":
        return "Neovim 内部语法" if name.startswith("Nvim") else "传统 Vim 语法"
    if cat == "devicons":
        return "DevIcon 文件图标生态"
    if cat == "treesitter":
        if re.search(r"\.(markdown|html|css|scss|python|c_sharp|cpp|rust|yaml|tsx)$", name):
            return "TreeSitter 语言特化"
        if re.match(r"^@(text|parameter|field|namespace|symbol|method|repeat|conditional|exception|include|define|preproc|float|string\.regex|storageclass)$", name):
            return "TreeSitter 兼容别名"
        return "TreeSitter 基础"
    if cat == "lsp":
        if name.startswith("Diagnostic") or name.startswith("LspDiagnostics"):
            return "LSP 诊断与提示"
        if name.startswith("@lsp."):
            return "LSP semantic token"
        return "LSP UI / 引用 / 辅助"
    return "受支持插件集成" if plugin_prefix(name) in SUPPORTED_PLUGIN_PREFIXES else "外部插件 / 私有生态"


def treesitter_description(name: str) -> str:
    if name == "@none":
        return "TreeSitter 捕获占位组，通常无需主题单独设置。"
    if name == "@spell":
        return "TreeSitter 拼写检查占位组，通常交由 spell 相关高亮处理。"

    body = name[1:]
    lang = None
    match = re.search(r"\.(markdown|html|css|scss|python|c_sharp|cpp|rust|yaml|tsx)$", body)
    if match:
        lang = match.group(1)
        body = body[: -(len(lang) + 1)]

    segments = body.split(".")
    base = TREESITTER_BASE_MAP.get(segments[0], "TreeSitter 捕获")
    modifiers = segments[1:]

    parts = [base]
    if modifiers:
        parts.append("修饰: " + ", ".join(modifiers))
    if lang:
        parts.append(f"语言特化: {lang}")
    return "，".join(parts) + "。"


def lsp_description(name: str) -> str:
    if name.startswith("Diagnostic"):
        return "LSP / diagnostics 相关高亮组，用于错误、警告、提示、虚拟文本、下划线或标记列。"
    if name.startswith("LspDiagnostics"):
        return "旧式 LSP diagnostics 兼容组，通常链接到新的 Diagnostic 系列。"
    if name.startswith("LspReference"):
        return "LSP 引用高亮，用于光标下 symbol 的读写引用范围。"
    if name == "LspInlayHint":
        return "LSP 内联提示。"
    if name.startswith("LspCodeLens"):
        return "LSP CodeLens 文本与分隔。"
    if name == "LspSignatureActiveParameter":
        return "函数签名提示中当前激活参数。"
    if name == "LspInfoBorder":
        return "LspInfo 窗口边框。"
    if name.startswith("@lsp."):
        return f"LSP semantic token 组，语义路径: {name[5:]}。"
    return "LSP 相关高亮组。"


def plugin_description(name: str) -> str:
    prefix = plugin_prefix(name)
    descriptions = {
        "Cmp": "nvim-cmp 补全菜单相关组。",
        "BlinkCmp": "blink.cmp 补全菜单相关组。",
        "GitSigns": "gitsigns 改动标记与预览相关组。",
        "RainbowDelimiter": "rainbow-delimiters 彩虹括号相关组。",
        "NvimTree": "nvim-tree 文件树相关组。",
        "BufferLine": "bufferline 标签栏相关组。",
        "Notify": "nvim-notify 通知窗口相关组。",
        "lualine": "lualine 状态栏分段与过渡相关组。",
        "Noice": "noice.nvim 命令行、消息与补全相关组。",
        "Telescope": "telescope 选择器相关组。",
        "WhichKey": "which-key 提示面板相关组。",
        "Mason": "mason UI 相关组。",
        "Navic": "nvim-navic 面包屑相关组。",
        "Trouble": "trouble 列表相关组。",
        "NeoTree": "neo-tree 文件树相关组。",
        "Aerial": "aerial 符号大纲相关组。",
        "Alpha": "alpha 启动页相关组。",
        "Lazy": "lazy.nvim 管理界面相关组。",
        "Flash": "flash.nvim 跳转相关组。",
        "Leap": "leap 跳转相关组。",
        "Hop": "hop 跳转相关组。",
        "Dap": "nvim-dap 调试相关组。",
        "Neogit": "neogit Git 界面相关组。",
        "Illuminate": "illuminate 当前词高亮相关组。",
        "RenderMarkdown": "render-markdown 渲染相关组。",
        "Snacks": "snacks.nvim 相关组。",
        "Oil": "oil.nvim 文件浏览相关组。",
        "Outline": "outline 视图相关组。",
        "DropBar": "dropbar 面包屑相关组。",
        "IndentBlankline": "indent-blankline 缩进线相关组。",
        "Ibl": "ibl 缩进线相关组。",
    }
    return descriptions.get(prefix, f"插件 {prefix or '未知'} 的高亮组。")


def syntax_description(name: str) -> str:
    if name.startswith("NvimInvalid"):
        return "Neovim 内部命令行 / 表达式语法中的非法 token。"
    if name.startswith("Nvim"):
        return "Neovim 内部命令行 / 表达式解析语法组。"
    return CORE_DESCRIPTIONS.get(name, "传统 Vim 语法高亮组。")


def core_description(name: str) -> str:
    return CORE_DESCRIPTIONS.get(name, "Neovim 基础界面或兼容高亮组。")


def description(name: str) -> str:
    cat = category(name)
    if cat == "devicons":
        return "nvim-web-devicons 及其派生生态的文件类型图标高亮组。"
    if cat == "treesitter":
        return treesitter_description(name)
    if cat == "lsp":
        return lsp_description(name)
    if cat == "plugin":
        return plugin_description(name)
    if cat == "syntax":
        return syntax_description(name)
    return core_description(name)


def parse_entries(text: str) -> list[dict[str, str]]:
    entries = []
    for line in text.splitlines():
        match = re.match(r"^(\S+)\s+xxx\s*(.*)$", line)
        if match:
            entries.append({"name": match.group(1), "spec": match.group(2).strip()})
    return entries


def esc(text: str) -> str:
    return text.replace("|", r"\|")


def status_kind(spec: str) -> str:
    spec = spec.strip()
    if not spec:
        return "unspecified"
    if spec.startswith("links to "):
        return "links"
    if spec == "cleared":
        return "cleared"

    named_refs = re.findall(r"\b(gui|cterm)(fg|bg|sp)=([A-Za-z][A-Za-z0-9]+)\b", spec)
    has_hex_color = bool(re.search(r"\b(gui|cterm)(fg|bg|sp)=#[0-9A-Fa-f]{3,8}\b", spec))
    has_attr_tokens = bool(re.search(r"\b(cterm|gui|blend)=([A-Za-z0-9#,]+)\b", spec))
    has_color_key = bool(re.search(r"\b(ctermfg|ctermbg|guifg|guibg|guisp)=([^\s]+)\b", spec))

    alias_values = {"fg", "bg", "foreground", "background", "NONE"}
    has_special_alias = any(value in alias_values for _, _, value in named_refs)
    has_palette_name = any(value not in alias_values for _, _, value in named_refs)

    if has_hex_color and has_palette_name:
        return "mixed"
    if has_hex_color and has_special_alias:
        return "mixed"
    if has_palette_name and has_special_alias:
        return "mixed"
    if has_hex_color and has_attr_tokens:
        return "mixed"
    if has_palette_name and has_attr_tokens:
        return "mixed"
    if has_special_alias and has_attr_tokens and not has_color_key:
        return "attr-only"
    if has_hex_color:
        return "hex-specified"
    if has_palette_name:
        return "palette-name"
    if has_special_alias:
        return "special-alias"
    if has_attr_tokens or has_color_key:
        return "attr-only"
    return "other"


def status_explanation(spec: str) -> str:
    kind = status_kind(spec)
    if kind == "links":
        target = spec.replace("links to ", "", 1).strip()
        return f"06-links: 通过链接复用 `{target}` 的定义。"
    if kind == "cleared":
        return "07-cleared: 当前组已清空，没有独立高亮定义。"
    if kind == "hex-specified":
        return "03-hex-specified: 当前组直接写入了十六进制颜色值。"
    if kind == "palette-name":
        return "01-palette-name: 当前组引用了命名调色板颜色。"
    if kind == "special-alias":
        return "02-special-alias: 当前组引用了 `fg`、`bg`、`NONE` 这类特殊别名值。"
    if kind == "attr-only":
        return "04-attr-only: 当前组主要定义了 bold、underline、blend 等样式属性。"
    if kind == "mixed":
        return "05-mixed: 当前组同时包含多种状态来源，例如显式色值、命名色和样式属性。"
    if kind == "unspecified":
        return "08-unspecified: 未检测到明确状态描述。"
    return "09-other: 当前状态不属于常见的 link / cleared / color spec 分类。"


def render_document(title: str, scope: str, entries: list[dict[str, str]], output: Path) -> None:
    lines: list[str] = [
        f"# {title}",
        "",
        scope,
        "",
        "分类规则：",
        "- `必设置`：`spectra.nvim` 共享运行时通常应直接覆盖，或属于核心体验缺失后会明显失真的组。",
        "- `可选`：兼容增强、语言特化、扩展 UI、legacy 兼容组或受支持插件集成。",
        "- `不必要`：明显属于用户私有插件生态、动态实例组，或不建议在通用主题框架中主动维护的组。",
        "",
    ]

    for need in ("必设置", "可选", "不必要"):
        bucket = [e for e in entries if e["necessity"] == need]
        if not bucket:
            continue
        lines.extend([f"## {need}", ""])
        for sub in sorted({e["subcategory"] for e in bucket}):
            sub_entries = sorted((e for e in bucket if e["subcategory"] == sub), key=lambda x: x["name"])
            lines.extend([f"### {sub}", "", "| Group | 状态 | 状态说明 | 说明 |", "| --- | --- | --- | --- |"])
            for entry in sub_entries:
                lines.append(
                    f"| `{esc(entry['name'])}` | {esc(entry['spec'])} | {esc(entry['status_explanation'])} | {esc(entry['description'])} |"
                )
            lines.append("")

    output.write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    entries = parse_entries(INPUT_FILE.read_text(encoding="utf-8"))

    enriched = []
    for entry in entries:
      name = entry["name"]
      enriched.append(
          {
              **entry,
              "category": category(name),
              "necessity": necessity(name),
              "subcategory": subcategory(name),
              "description": description(name),
              "status_explanation": status_explanation(entry["spec"]),
              "part": part_for(name),
          }
      )

    for filename, title, scope in PARTS:
        render_document(title, scope, [e for e in enriched if e["part"] == filename], OUTPUT_DIR / filename)

    index_lines = [
        "# Highlight Classification Index",
        "",
        "输入来源：`highlight_default.txt`。",
        "",
        "这套文档按统一规则把当前 Neovim session 中 `:highlight` 输出的组拆成多个部分，便于逐步阅读和维护。",
        "",
        "## Parts",
        "",
        "- [Part 1: Core Editor UI](./01-core-editor-ui.md)",
        "- [Part 2: Core Syntax And Vim Internals](./02-core-syntax-and-vim-internals.md)",
        "- [Part 3: TreeSitter](./03-treesitter.md)",
        "- [Part 4: LSP And Diagnostics](./04-lsp-and-diagnostics.md)",
        "- [Part 5: Supported Integrations](./05-supported-integrations.md)",
        "- [Part 6: External Plugin Groups](./06-external-plugin-groups.md)",
        "- [Part 7: DevIcons](./07-devicons.md)",
        "",
        "## Notes",
        "",
        "- `必设置 / 可选 / 不必要` 是站在 `spectra.nvim` 这种共享主题框架的角度做的工程化分类，不是 Neovim 官方强制级别。",
        "- 动态实例组、状态栏自动拼接组、通知系统实例组，统一倾向归入 `不必要`。",
        "- 受支持插件集成统一归入 `可选`，因为它们有价值，但不属于没有就无法使用主题的基础路径。",
        "",
        "## Counts",
        "",
        "| Part | Entries |",
        "| --- | ---: |",
    ]

    for filename, title, _ in PARTS:
        count = sum(1 for e in enriched if e["part"] == filename)
        index_lines.append(f"| {title} | {count} |")

    (OUTPUT_DIR / "00-index.md").write_text("\n".join(index_lines), encoding="utf-8")


if __name__ == "__main__":
    main()
