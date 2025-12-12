extends Node

@onready var enemyPath: Path2D = %EnemyPath
@onready var timer_label: Label = $TimerLabel
@onready var start_button: TextureButton = $UI/Control/StartWaveButton

const ENEMY_GOBLIN := 0
const ENEMY_OGRE := 1

@export var enemy_scenes: Array[PackedScene] = [
	preload("res://Scenes/enemy_base.tscn"),
	preload("res://Scenes/enemy_base.tscn"),
]

@export var enemy_stats: Array[enemyBase] = [
	preload("res://resources/enemies/Goblin.tres"),
	preload("res://resources/enemies/Ogre.tres"),
]

var waves := [
	[
		{ "enemy": ENEMY_GOBLIN, "count": 10, "interval": 1.0 },
	],
	[
		{ "enemy": ENEMY_GOBLIN, "count": 5, "interval": 0.6 },
		{ "enemy": ENEMY_OGRE, "count": 1, "interval": 0.0 },
		{ "enemy": ENEMY_GOBLIN, "count": 5, "interval": 0.6 },
	],
	[
		{ "enemy": ENEMY_GOBLIN, "count": 7, "interval": 0.6 },
		{ "enemy": ENEMY_OGRE, "count": 2, "interval": 0.6 },
		{ "enemy": ENEMY_GOBLIN, "count": 5, "interval": 0.6 },
	],
	[
		{ "enemy": ENEMY_GOBLIN, "count": 5, "interval": 0.6 },
		{ "enemy": ENEMY_OGRE, "count": 3, "interval": 0.6 },
		{ "enemy": ENEMY_GOBLIN, "count": 10, "interval": 0.6 },
	],
]

var current_wave_index: int = -1
var current_segment_index: int = 0
var enemies_spawned_in_segment: int = 0
var active_wave: bool = false
var spawn_timer: float = 0.0


func _ready() -> void:
	start_button.pressed.connect(_on_start_wave_pressed)
	_update_start_button()


func _process(delta: float) -> void:
	if active_wave:
		_process_spawning(delta)


func _on_start_wave_pressed() -> void:
	if active_wave:
		return
	_start_next_wave()


func _start_next_wave() -> void:
	current_wave_index += 1

	if current_wave_index >= waves.size():
		timer_label.text = "All waves done!"
		start_button.disabled = true
		return

	_start_wave(current_wave_index)
	_update_start_button()


func _start_wave(wave_index: int) -> void:
	active_wave = true
	current_segment_index = 0
	enemies_spawned_in_segment = 0
	spawn_timer = 0.0
	timer_label.text = "Wave %d" % (wave_index + 1)


func _process_spawning(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer > 0.0:
		return

	var wave = waves[current_wave_index]

	if current_segment_index >= wave.size():
		_end_current_wave()
		return

	var segment = wave[current_segment_index]
	var enemy_type: int = segment["enemy"]
	var segment_count: int = segment["count"]
	var interval: float = segment.get("interval", 1.0)

	var enemy_scene: PackedScene = enemy_scenes[enemy_type]
	var stats: enemyBase = enemy_stats[enemy_type]

	var new_enemy = enemy_scene.instantiate()
	new_enemy.enemyStats = stats
	enemyPath.add_child(new_enemy)

	enemies_spawned_in_segment += 1

	if enemies_spawned_in_segment >= segment_count:
		current_segment_index += 1
		enemies_spawned_in_segment = 0

	spawn_timer = interval


func _end_current_wave() -> void:
	active_wave = false
	spawn_timer = 0.0
	_update_start_button()


func _update_start_button() -> void:
	start_button.disabled = (current_wave_index + 1 >= waves.size())
	if (active_wave):
		start_button.visible = false
	else:
		start_button.visible = true
