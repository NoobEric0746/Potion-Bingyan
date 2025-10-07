extends Node2D

func button_clicked(idx):
	
	var ingredient = GlobalGameManager.saved_potion[idx]["ingredient"]
	var effect = GlobalGameManager.saved_potion[idx]["effect"]
	var potion_name = GlobalGameManager.saved_potion[idx]["name"]
	var pos = GlobalGameManager.saved_potion[idx]["pos"]
	var water = GlobalGameManager.saved_potion[idx]["water"]
	for i in range(1,4):
		if GlobalGameManager.storage_data[i] < ingredient[i]:
			return
	for i in range(1,4):
		GlobalGameManager.storage_data[i] -= ingredient[i]
	GlobalGameManager.potion_data = effect
	GlobalGameManager.potion_name = potion_name
	GlobalGameManager.used_ingredient = ingredient
	GlobalGameManager.potion_pos = pos
	GlobalGameManager.potion_water = water
	GlobalGameManager.ingredient_queue.clear()
	GlobalGameManager.durability_queue.clear()
	GlobalGameManager.reload()
