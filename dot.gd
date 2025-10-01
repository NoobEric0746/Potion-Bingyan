extends Area2D

@export var texture_dot: Texture2D
@export var texture_cross: Texture2D

var step=0
func _ready():
	area_entered.connect(Callable(self,"_on_area_entered"))

#func _on_area_entered(area):
#	if area.is_in_group("potion"):
#		queue_free()

func set_step(i):
	step=i

func set_type(t):
	if t==1:
		get_node("Sprite2D").texture = texture_cross
	else:
		get_node("Sprite2D").texture = texture_dot
		
func _process(delta):
	if GlobalGameManager.now_step >= step:
		queue_free()
