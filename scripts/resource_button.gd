extends TextureButton

@export var sprite_to_spawn: PackedScene
@export var ingredient_type: int

func _on_button_down():
	if sprite_to_spawn != null:
		var new_instance = sprite_to_spawn.instantiate()
		get_tree().current_scene.add_child(new_instance)
		new_instance.global_position = get_global_mouse_position()
		new_instance.set_ingredient_type(ingredient_type)
		new_instance.update_texture()
		_on_mouse_exited()
		new_instance._on_mouse_entered()


func _on_mouse_entered() -> void:
	GlobalGameManager.tmp_ingredient = ingredient_type
	GlobalGameManager.tmp_durability = GlobalGameManager.base_len
	GlobalGameManager.show_tmp(true)


func _on_mouse_exited() -> void:
	GlobalGameManager.tmp_ingredient = 0
	GlobalGameManager.tmp_durability = 0
	GlobalGameManager.show_tmp(false)
