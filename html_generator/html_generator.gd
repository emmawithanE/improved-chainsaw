extends Control
class_name HTMLGenerator

@onready var markdown_parser: MarkdownParser = %MarkdownParser
@onready var ast_parent: Node = %ASTParent

func _ready() -> void:
	run.call_deferred()
	
func run():
	markdown_parser.load_data()
	
	var body := ASTBody.new()
	ast_parent.add_child(body)
	
	body.generate(markdown_parser)
