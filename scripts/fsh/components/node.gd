extends Node
class_name FSHNode

var kind			# defined by `NodeKind` in `parser.rs`
var node			# node of said kind

func _init(p_kind, p_node):
	kind = p_kind
	node = p_node
