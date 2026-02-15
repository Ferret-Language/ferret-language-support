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
  "!!"
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
  "%"
  "??"
  ".."
  "::"
  "|"
  "~"
  "^"
  "|>"
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

; =========================
; Comments
; =========================
(line_comment) @comment
(block_comment) @comment

; =========================
; Strings / chars / bytes
; =========================
(string_literal) @string
(char_literal) @string
(byte_literal) @string

; =========================
; Numbers
; =========================
(integer_literal) @number
(float_literal) @number
(imaginary_literal) @number

; =========================
; Literals
; =========================
(boolean_literal) @boolean
(none_literal) @constant.builtin

; =========================
; Types
; =========================
(primitive_type) @type.builtin
(type_identifier) @type

(type_declaration
  name: (type_identifier) @type)

(enum_variant) @constant

; =========================
; Namespaces
; =========================
(scoped_identifier
  scope: (identifier) @namespace)

; =========================
; Definitions
; =========================
(function_declaration
  name: (identifier) @function)

(interface_method
  name: (identifier) @function)

; =========================
; Variables
; =========================
(parameter
  name: (identifier) @variable.parameter)

(method_receiver
  name: (identifier) @variable.parameter)

(declaration_item
  name: (identifier) @variable)

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))

; =========================
; Properties (field access)
; =========================
(field_expression
  field: (field_identifier) @property)

(field_declaration
  name: (field_identifier) @property)

(struct_field_init
  name: (field_identifier) @property)

; =========================
; Calls
; =========================
; Plain call: f(...)
(call_expression
  function: (identifier) @function)

; Scoped call: io::Println(...)
(call_expression
  function: (scoped_identifier
    name: (identifier) @function))

; Method call: obj.method(...)
; Must come AFTER @property so it overrides field coloring at call-sites.
(call_expression
  function: (field_expression
    field: (field_identifier) @function))

; Parenthesized callees: (f)(...), (io::Println)(...), (obj.method)(...)
(call_expression
  function: (parenthesized_expression
    (identifier) @function))

(call_expression
  function: (parenthesized_expression
    (scoped_identifier
      name: (identifier) @function)))

(call_expression
  function: (parenthesized_expression
    (field_expression
      field: (field_identifier) @function)))

; =========================
; Keywords
; =========================
[
  "let" "const" "fn" "type" "struct" "enum" "union" "interface"
  "if" "else" "while" "for" "in"
  "break" "continue" "defer" "fork"
  "match" "return" "as" "catch"
  "import" "map" "mut"
] @keyword

["true" "false"] @boolean

; =========================
; Operators
; =========================
[
  ":=" "=" "=>" "!!" "!" "?" "&" "@" "#"
  "+" "-" "*" "/" "%" "**"
  "==" "!=" "<" ">" "<=" ">="
  "&&" "||" "??" ".." "::" "|" "~" "^" "|>"
] @operator

; =========================
; Punctuation
; =========================
["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["," ";" ":" "."] @punctuation.delimiter
