extends Node2D

@export var ingredient_type:int
@export var texture:Texture2D
var ok = true


func _ready():
	var tex = get_node("TextureButton")
	tex.texture_normal = texture
	if(GlobalGameManager.plant_state[ingredient_type]):
		tex.show()
	else:
		tex.hide()


func _on_texture_button_pressed() -> void:
	var tex = get_node("TextureButton")
	GlobalGameManager.storage_data[ingredient_type] += 5
	GlobalGameManager.plant_state[ingredient_type] = false
	var particle = get_node("Plus5Particle")
	particle.emitting = true
	tex.hide()
