extends Area2D

var enemyArray
@export var bulletDamage = 1.0
var active = true




func _physics_process(delta):
	if active == true:
		for i in get_overlapping_bodies():
			var temp = i.get_parent()
			temp._damage(bulletDamage)
			active = false
func _on_v_timer_timeout():
	queue_free()
