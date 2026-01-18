; Keywords that tree-sitter generates
[
  "let"
  "const"
  "fn"
  "type"
  "struct"
  "enum"
  "union"
  "interface"
  "if"
  "else"
  "while"
  "for"
  "in"
  "break"
  "continue"
  "defer"
  "fork"
  "match"
  "return"
  "as"
  "catch"
  "import"
  "map"
  "mut"
] @keyword

; Boolean literals
[
  "true"
  "false"
] @boolean

; Primitive types - use the node type
(primitive_type) @type.builtin

; Custom types
(type_identifier) @type

; Operators
[
  ":="
  "="
  "=>"
  "!"
  "?"
  "&"
  "@"
  "#"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  "&&"
  "||"
  "??"
  ".."
  "::"
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
  ":"
  "."
] @punctuation.delimiter

; Comments
(line_comment) @comment
(block_comment) @comment

; Strings - import paths should be same color as regular strings
(string_literal) @string
(char_literal) @string
(byte_literal) @string

; Escape sequences
(escape_sequence) @string.escape

; Numbers
(integer_literal) @number
(float_literal) @number

; Literals
(boolean_literal) @boolean
(none_literal) @constant.builtin

; Function definitions
(function_declaration
  name: (identifier) @function
  (#set! priority 200))

(interface_method
  name: (identifier) @function
  (#set! priority 200))

; Function calls
(call_expression
  function: (identifier) @function
  (#set! priority 200))

(call_expression
  function: (scoped_identifier
    name: (identifier) @function)
  (#set! priority 200))

; Type declarations
(type_declaration
  name: (type_identifier) @type)

; Enum variants
(enum_variant) @constant

; Scoped identifiers
(scoped_identifier
  scope: (identifier) @namespace)

(scoped_identifier
  scope: (type_identifier) @type)

(scoped_identifier
  name: (type_identifier) @constant)

(scoped_identifier
  name: (identifier) @variable)

; Struct field access
(field_expression
  field: (field_identifier) @property)

; Struct field definitions
(field_declaration
  name: (field_identifier) @property)

; Struct field initialization
(struct_field_init
  name: (field_identifier) @property)

; Parameters
(parameter
  name: (identifier) @variable.parameter)

; Method receiver
(method_receiver
  name: (identifier) @variable.parameter)

; Variables
((identifier) @variable
 (#set! priority 5))

; Constants (uppercase identifiers)
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))
