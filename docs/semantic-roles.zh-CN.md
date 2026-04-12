# `spectra.nvim` 语义角色说明

这份文档说明 `spectra.nvim` 里 `roles()` 所使用的语义角色契约。

这些名称不是最终的 highlight group 名，而是主题提供给共享运行时的“语义 Token / 语义角色”。
共享模块会再把这些角色映射到：

- Vim 传统语法组
- TreeSitter captures
- LSP diagnostics
- semantic tokens
- 插件 integration 高亮组

## 角色列表

- `text`：通用正文与默认文本内容
- `identifier`：一般标识符，通常用于未进一步细分的名字
- `local_variable`：局部变量
- `builtin_variable`：内建变量、语言预定义变量
- `comment`：注释文本
- `keyword`：关键字，如 `if`、`for`、`return`、`class`
- `preproc`：预处理或编译指令
- `function_name`：函数名、可调用实体名称
- `function_builtin`：内建函数、标准库函数
- `type`：类型名
- `builtin_type`：内建类型，如 `string`、`number`、`boolean`
- `type_parameter`：泛型参数、模板类型参数
- `constructor`：构造器
- `parameter`：参数、形参
- `label`：标签、跳转标记
- `field`：字段，通常偏向结构体或对象成员字段
- `property`：属性，通常偏向面向对象属性或键值属性
- `constant`：常量
- `macro`：宏
- `string`：字符串
- `character`：字符字面量
- `number`：数字字面量
- `escape`：转义序列
- `regexp`：正则表达式内容
- `special`：特殊语义项，兜底给特殊字符或特殊语法片段
- `tag`：标签名，例如 HTML/XML tag
- `attribute`：特性、注解、attribute
- `operator`：运算符
- `module`：模块、命名空间、包名
- `uri`：URI、链接地址
- `todo`：TODO/FIXME 等待办提示
- `diagnostic_error`：诊断错误
- `diagnostic_warn`：诊断警告
- `diagnostic_info`：诊断信息
- `diagnostic_hint`：诊断提示
- `ui_border`：UI 边框语义色
- `ui_selection`：UI 选区语义色
- `ui_menu`：UI 菜单语义色

## 边界说明

- 这些 `roles` 不是 `@function`、`@type`、`Normal` 这种最终高亮组。
- `lua/spectra/groups/` 也不是 role 契约定义中心，而是“共享映射层”。
- 真正的 role 契约，是“主题 `roles()` 提供的语义角色”与“共享模块实际消费的角色名”的交集。

如果你要新增角色，应该先确认：

1. 共享模块里是否真的需要消费这个新角色
2. 它是否属于稳定的跨主题语义，而不是单个主题的临时细节
3. 是否应先通过现有角色组合解决，而不是立刻扩张契约
