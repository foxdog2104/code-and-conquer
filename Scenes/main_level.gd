extends Node2D
@onready var battle_chosic_com_: AudioStreamPlayer = $"Battle(chosic_com)"
@onready var stage = $StageTest
@onready var wave_manager = stage.get_node("WaveManager")
@onready var save_loader = stage.get_node("SaveLoader")
@onready var win_screen = $WinScreen/WinScreen

func _ready() -> void:
	battle_chosic_com_.play()
	wave_manager.level_won.connect(_on_level_won)


func _on_settings_bgs_finished() -> void:
	battle_chosic_com_.play()

func _on_level_won() -> void:
	save_loader.save()
	win_screen.show_screen()
