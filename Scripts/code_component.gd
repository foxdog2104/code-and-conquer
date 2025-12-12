extends PanelContainer

@export_category("ID's")
@export var funcID:int





func _on_remove_pressed():
	self.queue_free()


func _on_move_up_pressed():
	moveComponent(-1)


func _on_move_down_pressed():
	moveComponent(1)


func moveComponent(selection:int):
	var node_index = get_index()
	var node_parent = get_parent()
	node_parent.move_child(self, node_index + selection)
