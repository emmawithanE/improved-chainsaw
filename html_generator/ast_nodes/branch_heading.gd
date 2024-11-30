extends ASTBranch
class_name ASTHeading

var level : int

func _ready() -> void:
	name = "Heading tag"

func generate(parser : MarkdownParser):
	level = 0
	while parser.check_next_token() is ASTHeading:
		level += 1
		parser.consume_characters()
	while parser.get_next_chars() == " ":
		parser.consume_characters()
	
	if level > 6:
		printerr("Heading level too great! %d" % level)
	
	while !((parser.check_next_token() is ASTEOL) or (parser.check_next_token() is ASTEOF)):
		add_child(parser.get_token())
	parser.consume_characters() # Consume EOL
	
	name = "Heading %d tag" % level
	

func print_content() -> String:
	var content = "<h%d>" % level
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "</h%d>\n" % level
	return content
