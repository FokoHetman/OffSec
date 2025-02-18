extends FSHNode
class_name FSHMatterializator

var id: FSHIdentifier

func _init(p_id: FSHIdentifier):
	kind = FSHParser.NodeKind.Matterializator
	id = p_id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
