extends ASTBranch
class_name ASTEmphasis

func _ready() -> void:
	name = "em tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTEmphasis):
		add_child(parser.get_token())
	# Discard emphasis
	parser.consume_characters()

func print_content() -> String:
	var content = "<em>"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</em>"
	return content
