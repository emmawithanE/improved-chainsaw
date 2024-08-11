extends Node
class_name MarkdownParser

@export_file("*.txt") var file

var unparsed_text : String

func load_data() -> void:
	assert(file, "Parser has no file to parse")
	
	var open_file := FileAccess.open(file, FileAccess.READ)
	unparsed_text = open_file.get_as_text(true)


#--------

func check_next_token() -> ASTToken:
	# Big silly elif chain incoming, i suspect
	
	if unparsed_text.length() == 0:
		return ASTEOF.new()
	elif unparsed_text.begins_with("\n"):
		return ASTEOL.new()
	else:
		return ASTText.new()

func get_token() -> ASTToken:
	var next_token = check_next_token()
	
	if next_token is ASTText:
		next_token.name = "Text"
		next_token.generate(self)
		return next_token
	elif next_token is ASTEOF:
		return next_token
	elif next_token is ASTEOL:
		consume_characters()
		return next_token
	else:
		assert(false, "token type not generated")
		return next_token

func consume_characters(count := 1) -> String:
	var chars = unparsed_text.substr(0,count)
	unparsed_text = unparsed_text.substr(count)
	return chars

func get_text_string() -> String:
	var text = ""
	while check_next_token() is ASTText:
		text += consume_characters()
	return text

func get_paragraph() -> ASTToken:
	var paragraph := ASTParagraph.new()
	paragraph.generate(self)
	return paragraph
