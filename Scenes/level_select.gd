extends Control
@onready var settings_bgs: AudioStreamPlayer = $SettingsBgs
@onready var save_loader: LevelSaverLoader = $SaveLoader


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_bgs.play()
	save_loader.save()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
