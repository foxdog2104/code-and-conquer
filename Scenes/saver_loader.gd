class_name LevelSaverLoader
extends Node

@export var level_number : int = 0
var data_slot := "res://Data/slot.json"

var level_status: Array[bool] = [false, false, false] # level 1..3

func save():
	print("SAVE CALLED FROM:", get_stack())
	if level_number >= 0 and level_number < level_status.size():
		level_status[level_number] = true

	var data = { "l_number": level_status }
	var json_file = FileAccess.open(data_slot, FileAccess.WRITE)
	json_file.store_line(JSON.stringify(data))
	json_file.close()

func load():
	if not FileAccess.file_exists(data_slot):
		return

	var json_file = FileAccess.open(data_slot, FileAccess.READ)
	var json_data = json_file.get_as_text()
	json_file.close()

	var data = JSON.parse_string(json_data)
	if data == null or not data.has("l_number"):
		return

	level_status.clear()

	for v in data["l_number"]:
		level_status.append(bool(v))
