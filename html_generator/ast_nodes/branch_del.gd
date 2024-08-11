extends ASTBranch
class_name ASTDel

func _ready() -> void:
	name = "del tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTDel):
		add_child(parser.get_token())
	# Discard emphasis
	parser.consume_characters(2)

func print_content() -> String:
	var content = "<del>"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</del>"
	return content
