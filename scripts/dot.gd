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
	
	if GlobalGameManager.firing and GlobalGameManager.vortex != Vector2.ZERO:
		process_vortex()
	if GlobalGameManager.now_step >= step:
		queue_free()
	if GlobalGameManager.potion_watering:
		var potion = get_parent().get_node("Potion")
		var direction = potion.start_pos - potion.global_position
		if direction.length() < 2.0:
			return
		var movement = direction.normalized()
		global_position += movement

func process_vortex():
	print("1")
	var potion = get_parent().get_node("Potion")
	var dis = potion.global_position - GlobalGameManager.vortex
	var go = (dis.rotated(deg_to_rad(100))).normalized()
	global_position += go
	if dis.length()<3:
		global_position += Vector2(200,0)
	
