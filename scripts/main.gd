extends Node2D
@export var sprite_resource: PackedScene

func _on_spawn_button_pressed():
	var new_sprite_instance = sprite_resource.instantiate()
	new_sprite_instance.global_position = get_global_mouse_position()
	add_child(new_sprite_instance)
func _process(delta):
	pass
	#print(GlobalGameManager.get_now_ingredient())
func _ready():
	set_process(true)
	get_node("SubViewportContainer/SubViewport/PotionMap").draw_dots()
