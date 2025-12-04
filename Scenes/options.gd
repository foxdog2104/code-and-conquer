extends Control
@onready var settings_bgs: AudioStreamPlayer = $SettingsBgs
@onready var sfx: HScrollBar = $Audio/SFX
@onready var bgm: HScrollBar = $Audio/BGM
var sfx_index
var bgm_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_get_audio_bus_value()
	settings_bgs.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index,linear_to_db(value))
	



func _on_bgm_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bgm_index,linear_to_db(value))
	
func _get_audio_bus_value():
	sfx_index = AudioServer.get_bus_index("SFX")
	bgm_index = AudioServer.get_bus_index("BGM")
	
	#converting to a linear 
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_index))
	bgm.value = db_to_linear(AudioServer.get_bus_volume_db(bgm_index))
	
	
