extends Area2D

@onready var workspace:HBoxContainer = $"../Workspace"
@onready var toggler:Button = $WorkspaceToggler
@onready var timer: Timer = $"../Timer"

var spawnLocation:Vector2

#tower variables
@onready var arrow:PackedScene = preload("res://Scenes/Tower stuff/ballista_arrow.tscn")
var enemyArray:Array[PathFollow2D]
var currentTarget
var loadedArrows:int = 0
var currentMana:int = 0
var currentTargets = []


func _ready():
	
	self.global_position = get_global_mouse_position()
	spawnLocation = get_global_mouse_position()
	


func _on_button_pressed():
	if toggler.visible == false:
		toggler.visible = !toggler.visible
		timer.start()


func _on_workspace_toggeler_pressed():
	workspace.visible = true


func _on_timer_timeout() -> void:
	toggler.visible = false
