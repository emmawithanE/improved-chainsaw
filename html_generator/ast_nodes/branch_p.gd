extends ASTBranch
class_name ASTParagraph

func _ready() -> void:
	name = "Paragraph tag"

func generate(parser : MarkdownParser):
	while !((parser.check_next_token() is ASTEOL) or (parser.check_next_token() is ASTEOF)):
		add_child(parser.get_token())
	# Discard EOL
	parser.consume_characters()

func print_content() -> String:
	var content = "<p>"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</p>\n"
	return content
