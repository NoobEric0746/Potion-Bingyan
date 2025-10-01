extends Area2D

var start_pos = Vector2.ZERO

func _ready():
	set_process(true)
	start_pos = global_position


func _process(delta: float) -> void:
	if GlobalGameManager.ismoving():
		#print(GlobalGameManager.get_now_ingredient())
		position += GlobalGameManager.get_direction_by_ingredient(GlobalGameManager.get_now_ingredient())
		GlobalGameManager.use_ingredient();
	if GlobalGameManager.potion_watering:
		print("water")
		var direction = start_pos - global_position
		if direction.length() < 2.0:
			return
		var movement = direction.normalized()
		global_position += movement
