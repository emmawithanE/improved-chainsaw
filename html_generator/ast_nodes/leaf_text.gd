extends ASTLeaf
class_name ASTText

var text : String

func generate(parser : MarkdownParser):
	text = parser.get_text_string()

func print_content() -> String:
	return text
