extends ASTLeaf
class_name ASTText

var text : String

func _ready() -> void:
	name = "Text string"

func generate(parser : MarkdownParser):
	text = parser.get_text_string()

func print_content() -> String:
	return text
