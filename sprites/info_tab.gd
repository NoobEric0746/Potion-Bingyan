extends Node2D

func _process(delta: float) -> void:
	var label = get_node("Label")
	var idx = GlobalGameManager.saved_potion_info
	var info = get_node("IngredientInfo")
	if idx == 0:
		info.text = GlobalGameManager.ingredient_info
		if GlobalGameManager.potion_name == "":
			label.text = "水"
		else:
			label.text = GlobalGameManager.potion_name+"药剂"
	else:
		var name = GlobalGameManager.saved_potion[idx]["name"]
		var ingredient = GlobalGameManager.saved_potion[idx]["ingredient"]
		if name == "":
			label.text = "水"
		else:
			label.text = name+"药剂"
		info.text = "消耗:\n药材A:"+str(ingredient[1])+"\n药材B:"+str(ingredient[2])+"\n药材C:"+str(ingredient[3])
		


func _on_confirm_pressed() -> void:
	#GlobalGameManager.kill_items.emit()
	#get_tree().change_scene_to_file("res://sprites/sell.tscn")
	GlobalGameManager.save_potion(1)
