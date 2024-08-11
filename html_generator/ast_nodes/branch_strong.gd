extends ASTBranch
class_name ASTStrong

func _ready() -> void:
	name = "strong tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTStrong):
		add_child(parser.get_token())
	# Discard emphasis
	parser.consume_characters(2)

func print_content() -> String:
	var content = "<strong>"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</strong>"
	return content
