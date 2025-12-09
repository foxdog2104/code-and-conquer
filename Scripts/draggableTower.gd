extends Area2D

var mouseHovering = false
var isDragging = false
var initialPos:Vector2
var towerNode = preload("res://Scenes/Tower stuff/tower_base_v_2.tscn")

func _process(_delta):
	if (Input.is_action_just_pressed("left_click") && self.mouseHovering == true && isDragging == false):
		isDragging = true
		initialPos = self.global_position
		
		print("clicked")
	if (Input.is_action_just_released("left_click") && isDragging == true):
		if can_add_tower():
			var newTower = towerNode.instantiate()
			var path = get_tree().get_root()
			#var path = get_tree().get_root().get_node("Main/Towers")
			path.add_child(newTower)
		#TODO will add checking for valid location later. tis time crunch time
		isDragging = false
		self.global_position = initialPos
		modulate = Color.WHITE
		
	if isDragging == true:
		self.global_position = get_global_mouse_position()
		if can_add_tower():
			modulate = Color.GREEN
		else: 
			modulate = Color.RED
			

func _on_mouse_entered():
	self.mouseHovering = true


func _on_mouse_exited():
	self.mouseHovering = false
	
func can_add_tower(): 
	var not_placeable_areas = get_overlapping_areas()
	
	if not_placeable_areas.size() > 0:
		return false
	else:
		return true
