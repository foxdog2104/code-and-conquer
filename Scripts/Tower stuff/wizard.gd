extends StaticBody2D

var enemyArray:Array[PathFollow2D]
var currentTarget
var loadedArrows:int = 0
var currentTargets = []
var spawnLocation:Vector2
@onready var myBullets = %BulletContainer

var funcOrder:Array[int]
var funcTower:Array[int]
var currentFunc:int = 0

var active = false




func _on_area_2d_body_exited(body):
	print("something")
	if body.get_parent() == currentTarget:
		print("target left")
		currentTarget = null


func _on_rof_timer_timeout():
	if (self.get_parent().currentMana >= 10):
		active = true


func _on_timer_timeout():
	if currentFunc >= funcOrder.size():
			currentFunc = 0
			if (self.get_parent().currentMana < 10):
				active = false
	if active == true:
		TowerFunctions.doFunc(self.get_parent(),self,funcOrder[currentFunc])
		currentFunc = currentFunc + 1
