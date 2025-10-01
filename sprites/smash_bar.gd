extends Label

func _ready() -> void:
	set_process(true)
	z_index = 150
	visible = true
	
func _process(delta: float) -> void:
	var yao = get_parent()
	text=str(yao.smash_progress)+"%"
