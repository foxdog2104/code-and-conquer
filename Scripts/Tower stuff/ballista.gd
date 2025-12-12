extends StaticBody2D

@onready var arrow:PackedScene = preload("res://Scenes/Tower stuff/ballista_arrow.tscn")
var enemyArray:Array[PathFollow2D]
var currentTarget
var loadedArrows:int = 0
var currentTargets = []
var spawnLocation:Vector2
@onready var myBullets = %BulletContainer

var funcOrder:Array[int]
var funcTower:Array[int]
var currentFunc:int = 0


func _ready():
	print("hello i exist")

#TODO fix this, this is wrong and only executes ballista funcs when it should
#be able to execute anything. not my problem rn
func execute(select:int):
	print(currentFunc)
	match select:
		1:
			loadArrow()
		2:
			fireArrow()
		3:
			getTarget()
		_:
			print("Invalid function")

func _on_rof_timer_timeout():
	if currentFunc >= funcOrder.size():
		currentFunc = 0
	print(funcOrder[currentFunc])
	TowerFunctions.doFunc(self.get_parent(),self,funcOrder[currentFunc])
	currentFunc = currentFunc + 1
	

func getTarget():
	TowerFunctions.doFunc(self.get_parent(),self,funcOrder[currentFunc])
	#

func loadArrow():
	TowerFunctions.doFunc(self.get_parent(),self,funcOrder[currentFunc])

func fireArrow():
	TowerFunctions.doFunc(self.get_parent(),self,funcOrder[currentFunc])


func _on_area_2d_body_entered(body) -> void:
	#not being used
	print("body entered")
	if "Enemy" in body.name:
		pass
	else:
		print("not an enemy")


func _on_area_2d_body_exited(body) -> void:
	print("something")
	if body.get_parent() == currentTarget:
		print("target left")
		currentTarget = null
