extends ASTBranch
class_name ASTBody

func _ready() -> void:
	name = "Body tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTEOF):
		add_child(parser.get_paragraph())
	

func print_content() -> String:
	var content = "<body>\n"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</body>\n"
	return content
