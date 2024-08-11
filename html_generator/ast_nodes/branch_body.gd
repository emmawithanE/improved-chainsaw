extends ASTBranch
class_name ASTBody

func _ready() -> void:
	name = "Body tag"

func generate(parser : MarkdownParser):
	while !(parser.check_next_token() is ASTEOF):
		add_child(parser.get_paragraph())
	
