extends Label

func _ready() -> void:
	hide()
func appear():
	show()
	await get_tree().create_timer(0.2).timeout
	hide()
