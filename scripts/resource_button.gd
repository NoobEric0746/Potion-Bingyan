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
	
