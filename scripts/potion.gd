extends Area2D

func _ready():
	set_process(true)
func _process(delta: float) -> void:
	if GlobalGameManager.ismoving():
		print(GlobalGameManager.get_now_ingredient())
		position += GlobalGameManager.get_direction_by_ingredient(GlobalGameManager.get_now_ingredient())
		GlobalGameManager.use_ingredient();
