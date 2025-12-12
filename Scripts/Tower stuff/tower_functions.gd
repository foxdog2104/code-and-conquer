extends Node2D
@onready var arrow:PackedScene = preload("res://Scenes/Tower stuff/ballista_arrow.tscn")
@onready var fireballProjectile:PackedScene = preload("res://Scenes/Tower stuff/fireball_projectile.tscn")
@onready var manaBlastProjectile:PackedScene = preload("res://Scenes/Tower stuff/manablast.tscn")
func testSelf():
	print("Testing globals: ")
	print(self.position)

func doFunc(myParent:Area2D, mySelf:Node2D, selection:int):
	match selection:
		1:
			loadArrows(myParent)
		2:
			fireArrow(myParent,mySelf)
		3:
			getTarget(myParent, mySelf)
		4:
			gainMana(myParent)
		5:
			manaBlast(myParent,mySelf)
		6:
			fireball(myParent,mySelf)

#ballista functions
func loadArrows(myParent:Area2D):
	myParent.loadedArrows = myParent.loadedArrows + 1
	
func getTarget(myParent:Area2D, myself:Node2D):
	if is_instance_valid(myParent.currentTarget):
		print("Target still valid")
	else:
		var tempArray = []
		myParent.currentTargets = myself.get_node("Area2D").get_overlapping_bodies()
		for i in myParent.currentTargets:
			if "Enemy" in i.name:
				tempArray.append(i)
		var currTarget = null
			
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		myParent.currentTarget = currTarget
		print(myParent.currentTarget)
		
func fireArrow(myParent:Area2D, mySelf:Node2D):
	if is_instance_valid(myParent.currentTarget):
		var tempBullet = arrow.instantiate()
		tempBullet.position = myParent.spawnLocation
		tempBullet.target = myParent.currentTarget
		mySelf.myBullets.add_child(tempBullet)
	else:
		#TODO should have a little notification display saying no arrows
		print("No target!")
		pass

func gainMana(myParent:Area2D):
	print("mana")
	myParent.currentMana = myParent.currentMana + 1

func fireball(myParent:Area2D, mySelf:Node2D):
	if (myParent.currentMana >= 5):
		if is_instance_valid(myParent.currentTarget):
			var tempBullet = fireballProjectile.instantiate()
			tempBullet.position = myParent.spawnLocation
			tempBullet.target = myParent.currentTarget
			tempBullet.bulletContainer = mySelf.myBullets
			tempBullet.spawnLocation = myParent.spawnLocation
			mySelf.myBullets.add_child(tempBullet)
			myParent.currentMana = myParent.currentMana - 5
		else:
			#TODO should have a little notification display saying no arrows
			print("No target!")
			pass
	print("No mana")
func manaBlast(myParent:Area2D, mySelf:Node2D):
	if (myParent.currentMana >= 2):
		var tempBullet = manaBlastProjectile.instantiate()
		tempBullet.position = myParent.spawnLocation
		mySelf.myBullets.add_child(tempBullet)
		myParent.currentMana = myParent.currentMana - 2
