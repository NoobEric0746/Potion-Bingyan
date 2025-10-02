extends Node2D

func _process(delta: float) -> void:
	var label = get_node("Label")
	if GlobalGameManager.potion_name == "":
		label.text = "水"
	else:
		label.text = GlobalGameManager.potion_name+"药剂"
