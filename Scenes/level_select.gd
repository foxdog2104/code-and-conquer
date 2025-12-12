extends Control
<<<<<<< Updated upstream
=======
@onready var settings_bgs: AudioStreamPlayer = $SettingsBgs
@onready var save_loader: LevelSaverLoader = $SaveLoader
@onready var level1_completed_label = $ConclusionLabel
>>>>>>> Stashed changes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
<<<<<<< Updated upstream
	pass # Replace with function body.


=======
	settings_bgs.play()
	save_loader.load()
	_update_level_labels()
	
>>>>>>> Stashed changes
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_level_labels() -> void:
	level1_completed_label.visible = save_loader.level_status[0]

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
