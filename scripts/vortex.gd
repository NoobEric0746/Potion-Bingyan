extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("potion"):
		GlobalGameManager.vortex = global_position
		#print("in_vortex")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("potion"):
		GlobalGameManager.vortex = Vector2.ZERO
