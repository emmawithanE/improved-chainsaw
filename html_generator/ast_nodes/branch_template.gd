extends ASTBranch
class_name AST_BRANCHTEMPLATE

func _ready() -> void:
	name = "[NAME] tag"

func generate(parser : MarkdownParser):
	#while the next token should still be a child of this one:
		# Add children to this node!
	# remember to consume any terminating characters if needed
	pass
	

func print_content() -> String:
	var content = "[Opening tag, maybe with \n]"
	for child in get_children():
		if child is ASTToken:
			content += child.print_content()
	content += "[Closing tag, maybe with \n]"
	return content
