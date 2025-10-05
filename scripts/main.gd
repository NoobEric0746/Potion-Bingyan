extends Node2D
@export var sprite_resource: PackedScene

func _on_spawn_button_pressed():
	var new_sprite_instance = sprite_resource.instantiate()
	new_sprite_instance.global_position = get_global_mouse_position()
	add_child(new_sprite_instance)
func _process(delta):
	var label = get_node("Money")
	var info = get_node("Label")
	
	label.text = str(GlobalGameManager.money)+"$"
	info.text = GlobalGameManager.ingredient_info
	#print(GlobalGameManager.get_now_ingredient())
func _ready():
	set_process(true)
	get_node("SubViewportContainer/SubViewport/PotionMap").draw_dots()


func _on_quit_button_pressed() -> void:
	GlobalGameManager.kill_items.emit()
	GlobalDataManager.save_game()
