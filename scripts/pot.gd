extends TextureButton

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS
	GlobalGameManager.add_effect_signal.connect(Callable(self,"_on_fire_clicked"))
	var bubble = get_node("BubbleParticle")
	bubble.emitting = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("yao_item"):
		handle_yao_caught(body)
		var add_stuff = get_node("AddStuffParticle")
		add_stuff.emitting = true

func handle_yao_caught(yao_node:Node2D):
	#GlobalGameManager.set_now_ingredient(yao_node.get_ingredient_type())
	GlobalGameManager.add_ingredient(yao_node.get_ingredient_type(),yao_node.smash_progress)
	yao_node.queue_free()


func _on_button_down() -> void:
	if not GlobalGameManager.ingredient_queue.is_empty():
		GlobalGameManager.set_moving(true)


func _on_button_up() -> void:
	GlobalGameManager.set_moving(false)

func _process(delta: float) -> void:
	var bubble = get_node("BubbleParticle")
	if GlobalGameManager.ismoving():
		bubble.emitting = true
	else:
		bubble.emitting = false
		
func _on_fire_clicked():
	var fire = get_node("FireParticle")
	fire.emitting = true
