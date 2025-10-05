extends TextureButton

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				GlobalGameManager.smashing = true
			else:
				GlobalGameManager.smashing = false

func _process(delta: float) -> void:
	if GlobalGameManager.smashing:
		var yaos = get_node("Area2D").get_overlapping_bodies()
		for yao in yaos:
			if yao.is_in_group("yao_item"):
				if yao.smash_progress<100:
					yao.smash_progress+=1
					yao.get_node("SmashParticle").emitting = true
