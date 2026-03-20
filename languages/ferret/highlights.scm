(line_comment) @comment
(block_comment) @comment

(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean
(none_literal) @constant.builtin

[
  "import"
  "const"
  "let"
  "mut"
  "fn"
  "type"
  "copy"
  "struct"
  "interface"
  "enum"
  "union"
  "error"
  "constraint"
  "if"
  "else"
  "match"
  "for"
  "while"
  "break"
  "continue"
  "return"
  "comptime"
  "take"
  "catch"
  "is"
  "as"
  "defer"
  "release"
  "panic"
  "lock"
  "unsafe"
  "self"
] @keyword

(move) @keyword

[
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  "!"
  "!!"
  "?"
  "??"
  "&"
  "+"
  "++"
  "-"
  "--"
  "*"
  "/"
  "%"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "&&"
  "||"
  "::"
  "=>"
] @operator

["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["," ";" ":" "."] @punctuation.delimiter

(attribute
  name: (identifier) @attribute)

(type_declaration
  name: (identifier) @type)

(constraint_declaration
  name: (identifier) @type)

(function_declaration
  owner: (identifier) @type)

(function_declaration
  owner: (scoped_identifier
    name: (identifier) @type))

(function_declaration
  owner: (generic_type
    name: (identifier) @type))

(function_declaration
  owner: (generic_type
    name: (scoped_identifier
      name: (identifier) @type)))

(named_type (identifier) @type)
(generic_type
  name: (identifier) @type)
(generic_type
  name: (scoped_identifier
    name: (identifier) @type))

(named_type
  (scoped_identifier
    name: (identifier) @type))

(scoped_identifier
  scope: (identifier) @type)

(scoped_identifier
  scope: (scoped_identifier
    name: (identifier) @type))

(named_type
  (scoped_identifier
    scope: (identifier) @type))

(named_type
  (scoped_identifier
    scope: (scoped_identifier
      name: (identifier) @type)))

(composite_literal
  type: (named_type (identifier) @type))

(composite_literal
  type: (named_type
    (scoped_identifier
      name: (identifier) @type)))

((identifier) @type.builtin
 (#any-of? @type.builtin
  "bool" "char" "string" "Self"
  "u8" "u16" "u32" "u64" "usize"
  "i8" "i16" "i32" "i64" "isize"
  "f32" "f64" "void"))

((identifier) @keyword
 (#eq? @keyword "self"))

(function_declaration
  name: (identifier) @function)

(interface_method
  name: (identifier) @function)

(call_expression
  function: (identifier) @function)

(call_expression
  function: (scoped_identifier
    name: (identifier) @function))

(call_expression
  function: (selector_expression
    field: (identifier) @function))

(generic_call_expression
  function: (identifier) @function)

(generic_call_expression
  function: (scoped_identifier
    name: (identifier) @function))

(generic_call_expression
  function: (selector_expression
    field: (identifier) @function))

; Recovery highlighting for invalid empty generic calls like `foo<>()`.
(ERROR
  (identifier) @function
  (argument_list))

(ERROR
  (scoped_identifier
    name: (identifier) @function)
  (argument_list))

(ERROR
  (selector_expression
    field: (identifier) @function)
  (argument_list))

(binary_expression
  left: (identifier) @function
  (ERROR)
  right: (parenthesized_expression))

(binary_expression
  left: (scoped_identifier
    name: (identifier) @function)
  (ERROR)
  right: (parenthesized_expression))

(binary_expression
  left: (selector_expression
    field: (identifier) @function)
  (ERROR)
  right: (parenthesized_expression))

(typed_parameter
  name: (identifier) @variable.parameter)

(type_parameter
  name: (identifier) @type)

(self_parameter) @keyword

(labeled_statement
  label: (identifier) @label)

(let_clause
  name: (identifier) @variable)

(const_clause
  name: (identifier) @constant)

(const_declaration
  name: (identifier) @constant)

(field_declaration
  name: (identifier) @property)

(named_field_initializer
  name: (identifier) @property)
