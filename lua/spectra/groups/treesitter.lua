local M = {}
local T = require("spectra.util.theme")

function M.get(C, R)
  local groups = {
    ["@variable"] = R.local_variable,
    ["@variable.builtin"] = T.highlight(R, { "builtin_variable", "constant" }, { fg = C.purple }),
    ["@variable.parameter"] = R.parameter,
    ["@variable.member"] = R.field,
    ["@constant"] = T.highlight(R, { "constant" }, { fg = C.purple, bold = true }),
    ["@constant.builtin"] = T.highlight(R, { "constant", "builtin_variable" }, { fg = C.purple }),
    ["@constant.macro"] = T.highlight(R, { "macro", "constant" }, { fg = C.purple }),
    ["@module"] = T.highlight(R, { "module", "type" }, { fg = C.cyan }),
    ["@module.builtin"] = T.highlight(R, { "module", "type" }, { fg = C.cyan }, { italic = true }),
    ["@label"] = T.highlight(R, { "label", "text" }, { fg = C.subtle }),
    ["@string"] = R.string,
    ["@string.documentation"] = T.highlight(R, { "comment", "string" }, { fg = C.comment }),
    ["@string.regexp"] = T.highlight(R, { "regexp", "escape" }, { fg = C.pink }),
    ["@string.escape"] = R.escape,
    ["@string.special"] = T.highlight(R, { "special", "escape" }, { fg = C.orange }),
    ["@string.special.path"] = T.highlight(R, { "string", "text" }, { fg = C.yellow }),
    ["@string.special.symbol"] = T.highlight(R, { "constant", "string" }, { fg = C.purple }),
    ["@string.special.url"] = T.highlight(R, { "uri", "module" }, { fg = C.cyan }, { underline = true }),
    ["@character"] = T.highlight(R, { "character", "string" }, { fg = C.yellow }),
    ["@character.special"] = T.highlight(R, { "special", "escape" }, { fg = C.orange }),
    ["@boolean"] = T.highlight(R, { "number", "constant" }, { fg = C.purple }),
    ["@number"] = T.highlight(R, { "number", "constant" }, { fg = C.purple }),
    ["@number.float"] = T.highlight(R, { "number", "constant" }, { fg = C.purple }),
    ["@type"] = R.type,
    ["@type.builtin"] = T.highlight(R, { "builtin_type", "type" }, { fg = C.cyan }),
    ["@type.definition"] = T.highlight(R, { "type", "module" }, { fg = C.cyan }),
    ["@type.qualifier"] = T.highlight(R, { "preproc", "keyword" }, { fg = C.pink }),
    ["@type.parameter"] = T.highlight(R, { "type_parameter", "type" }, { fg = C.purple }),
    ["@attribute"] = T.highlight(R, { "attribute", "field" }, { fg = C.green }),
    ["@property"] = R.property,
    ["@function"] = R.function_name,
    ["@function.builtin"] = T.highlight(R, { "function_builtin", "function_name" }, { fg = C.cyan }),
    ["@function.call"] = R.function_name,
    ["@function.macro"] = T.highlight(R, { "macro", "constant" }, { fg = C.purple }),
    ["@function.method"] = R.function_name,
    ["@function.method.call"] = R.function_name,
    ["@constructor"] = T.highlight(R, { "constructor", "type" }, { fg = C.cyan }),
    ["@operator"] = R.operator,
    ["@keyword"] = R.keyword,
    ["@keyword.modifier"] = R.keyword,
    ["@keyword.type"] = R.keyword,
    ["@keyword.coroutine"] = R.keyword,
    ["@keyword.function"] = R.keyword,
    ["@keyword.operator"] = R.keyword,
    ["@keyword.import"] = T.highlight(R, { "preproc", "keyword" }, { fg = C.pink }),
    ["@keyword.return"] = R.keyword,
    ["@keyword.exception"] = R.keyword,
    ["@keyword.conditional"] = R.keyword,
    ["@keyword.conditional.ternary"] = R.operator,
    ["@keyword.repeat"] = R.keyword,
    ["@keyword.directive"] = T.highlight(R, { "preproc", "keyword" }, { fg = C.purple }),
    ["@keyword.directive.define"] = T.highlight(R, { "macro", "preproc" }, { fg = C.purple }),
    ["@punctuation.delimiter"] = { fg = C.fg },
    ["@punctuation.bracket"] = { fg = C.fg },
    ["@punctuation.delimiter.regex"] = { fg = C.pink },
    ["@punctuation.special"] = { fg = C.orange },
    ["@comment"] = R.comment,
    ["@comment.documentation"] = R.comment,
    ["@comment.documentation.java"] = T.highlight(R, { "comment" }, { fg = C.comment }),
    ["@comment.error"] = T.highlight(R, { "diagnostic_error" }, { fg = C.red }, { bold = true }),
    ["@comment.warning"] = T.highlight(R, { "diagnostic_warn" }, { fg = C.orange }, { bold = true }),
    ["@comment.note"] = T.highlight(R, { "diagnostic_info", "module" }, { fg = C.cyan }, { bold = true }),
    ["@comment.todo"] = T.highlight(R, { "todo", "keyword" }, { fg = C.bg, bg = C.pink, bold = true }),
    ["@markup"] = { fg = C.fg },
    ["@markup.strong"] = { fg = C.orange, bold = true },
    ["@markup.italic"] = { fg = C.yellow, italic = true },
    ["@markup.strikethrough"] = { fg = C.subtle, strikethrough = true },
    ["@markup.underline"] = { fg = C.cyan, underline = true },
    ["@markup.heading"] = { fg = C.purple, bold = true },
    ["@markup.heading.1.markdown"] = { fg = C.purple, bold = true },
    ["@markup.heading.2.markdown"] = { fg = C.pink, bold = true },
    ["@markup.heading.3.markdown"] = { fg = C.orange, bold = true },
    ["@markup.heading.4.markdown"] = { fg = C.green, bold = true },
    ["@markup.heading.5.markdown"] = { fg = C.cyan, bold = true },
    ["@markup.heading.6.markdown"] = { fg = C.comment, bold = true },
    ["@markup.quote"] = { fg = C.comment },
    ["@markup.math"] = { fg = C.purple },
    ["@markup.link"] = T.highlight(R, { "tag", "keyword" }, { fg = C.pink }, { underline = true }),
    ["@markup.link.label"] = T.highlight(R, { "module", "type" }, { fg = C.cyan }),
    ["@markup.link.url"] = T.highlight(R, { "uri", "module" }, { fg = C.cyan }, { underline = true, italic = true }),
    ["@markup.raw"] = { fg = C.green },
    ["@markup.list"] = { fg = C.cyan },
    ["@markup.list.checked"] = { fg = C.green },
    ["@markup.list.unchecked"] = { fg = C.subtle },
    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },
    ["@tag"] = T.highlight(R, { "tag", "keyword" }, { fg = C.pink }),
    ["@tag.builtin"] = T.highlight(R, { "tag", "keyword" }, { fg = C.pink }),
    ["@tag.attribute"] = T.highlight(R, { "attribute", "field" }, { fg = C.green }),
    ["@tag.delimiter"] = { fg = C.fg },
    ["@tag.tsx"] = { fg = C.cyan },
    ["@tag.builtin.tsx"] = { fg = C.pink },
    ["@tag.attribute.tsx"] = { fg = C.green },
    ["@constructor.tsx"] = { fg = C.cyan },
    ["@variable.member.yaml"] = { fg = C.cyan },
    ["@label.yaml"] = { fg = C.orange },
    ["@string.special.url.html"] = { fg = C.orange, underline = true },
    ["@markup.link.label.html"] = { fg = C.fg },
    ["@character.special.html"] = { fg = C.purple },
    ["@property.css"] = { fg = C.cyan },
    ["@property.scss"] = { fg = C.cyan },
    ["@property.id.css"] = { fg = C.green },
    ["@property.class.css"] = { fg = C.green },
    ["@type.css"] = { fg = C.pink },
    ["@type.tag.css"] = { fg = C.pink },
    ["@number.css"] = { fg = C.purple },
    ["@keyword.directive.css"] = { fg = C.pink },
    ["@constructor.python"] = { fg = C.cyan },
    ["@attribute.c_sharp"] = { fg = C.green },
    ["@keyword.import.cpp"] = { fg = C.pink },
    ["@function.macro.rust"] = { fg = C.purple },
    ["@label.rust"] = { fg = C.orange },
    ["@type.builtin.rust"] = { fg = C.cyan },
    ["@type.qualifier.cpp"] = { fg = C.pink },
    ["@type.parameter.cpp"] = { fg = C.purple },
    ["@type.parameter.c_sharp"] = { fg = C.purple },
  }

  groups["@parameter"] = groups["@variable.parameter"]
  groups["@field"] = groups["@variable.member"]
  groups["@namespace"] = groups["@module"]
  groups["@symbol"] = groups["@string.special.symbol"]
  groups["@method"] = groups["@function.method"]
  groups["@method.call"] = groups["@function.method.call"]
  groups["@text"] = groups["@markup"]
  groups["@text.strong"] = groups["@markup.strong"]
  groups["@text.emphasis"] = groups["@markup.italic"]
  groups["@text.underline"] = groups["@markup.underline"]
  groups["@text.strike"] = groups["@markup.strikethrough"]
  groups["@text.uri"] = groups["@markup.link.url"]
  groups["@text.title"] = groups["@markup.heading"]
  groups["@text.literal"] = groups["@markup.raw"]
  groups["@text.reference"] = groups["@markup.link"]
  groups["@text.todo"] = groups["@comment.todo"]
  groups["@text.warning"] = groups["@comment.warning"]
  groups["@text.note"] = groups["@comment.note"]
  groups["@text.danger"] = groups["@comment.error"]
  groups["@text.diff.add"] = groups["@diff.plus"]
  groups["@text.diff.delete"] = groups["@diff.minus"]
  groups["@type.qualifier"] = groups["@keyword"]
  groups["@storageclass"] = groups["@keyword.modifier"]
  groups["@keyword.storage"] = groups["@keyword.modifier"]
  groups["@repeat"] = groups["@keyword.repeat"]
  groups["@conditional"] = groups["@keyword.conditional"]
  groups["@exception"] = groups["@keyword.exception"]
  groups["@include"] = groups["@keyword.import"]
  groups["@define"] = groups["@keyword.directive.define"]
  groups["@preproc"] = groups["@keyword.directive"]
  groups["@float"] = groups["@number.float"]
  groups["@string.regex"] = groups["@string.regexp"]

  return groups
end

return M
