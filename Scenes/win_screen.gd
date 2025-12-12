extends Control

@export var level_select_scene: String = "res://Scenes/level_select.tscn"

func show_screen() -> void:
	visible = true
	get_tree().paused = true

func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(level_select_scene)
