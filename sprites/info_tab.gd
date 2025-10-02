extends Node2D

func _process(delta: float) -> void:
	var label = get_node("Label")
	if GlobalGameManager.potion_name == "":
		label.text = "水"
	else:
		label.text = GlobalGameManager.potion_name+"药剂"


func _on_confirm_pressed() -> void:
	GlobalGameManager.kill_items.emit()
	get_tree().change_scene_to_file("res://sprites/sell.tscn")
