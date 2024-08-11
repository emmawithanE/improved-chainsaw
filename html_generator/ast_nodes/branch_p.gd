extends ASTBranch
class_name ASTParagraph

func _ready() -> void:
	name = "Paragraph tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTEOL):
		add_child(parser.get_token())
	# Discard EOL
	parser.get_token()

func print_content() -> String:
	var content = "<p>"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</p>\n"
	return content
