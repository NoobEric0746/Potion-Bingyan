extends Area2D

func _ready():
	set_process(true)
func _process(delta: float) -> void:
	if GlobalGameManager.ismoving():
		position += GlobalGameManager.get_direction_by_ingredient(GlobalGameManager.get_now_ingredient())
		GlobalGameManager.use_ingredient();
