extends Node2D
@export var dot: PackedScene
var pos = Vector2.ZERO
var tmp_pos = Vector2.ZERO
var tmp_durability = 0
var drawing = false

func _ready():
	GlobalGameManager.queue_changed.connect(_on_queue_changed)
	GlobalGameManager.start_draw_tmp.connect(_on_start_draw_tmp)
	GlobalGameManager.stop_draw_tmp.connect(_on_stop_draw_tmp)


func _on_queue_changed():
	clear_dots()
	draw_dots()

func _on_start_draw_tmp():
	tmp_pos = pos
	tmp_durability = 0
	drawing = true

func _on_stop_draw_tmp():
	clear_tmp_dots()
	drawing=false

func _process(delta: float) -> void:
	if drawing:
		draw_tmp_dots()
	
	if GlobalGameManager.potion_watering:
		var potion = get_node("Potion")
		var direction = potion.start_pos - potion.global_position
		if direction.length() < 2.0:
			return
		var movement = direction.normalized()
		pos += movement*2

func clear_dots():
	var dots = get_tree().get_nodes_in_group("dot")
	for i in range(dots.size()-1,-1,-1):
		var node = dots[i]
		if is_instance_valid(node):
			node.queue_free()
			
func clear_tmp_dots():
	var dots = get_tree().get_nodes_in_group("tmp_dot")
	for i in range(dots.size()-1,-1,-1):
		var node = dots[i]
		if is_instance_valid(node):
			node.queue_free()

func draw_tmp_dots():
	while tmp_durability < GlobalGameManager.tmp_durability:
		tmp_pos+=GlobalGameManager.get_direction_by_ingredient(GlobalGameManager.tmp_ingredient)
		tmp_durability += 1
		if tmp_durability%30==0:
			#print(tmp_durability)
			var dot_instance = dot.instantiate()
			dot_instance.position = tmp_pos
			dot_instance.add_to_group("tmp_dot")
			dot_instance.set_step(9999999)
			call_deferred("add_child", dot_instance)

func draw_dots():
	var tmp_ingredient = GlobalGameManager.ingredient_queue.duplicate()
	var tmp_durability = GlobalGameManager.durability_queue.duplicate()
	pos = get_node("Potion").position
	var i=0
	while not tmp_ingredient.is_empty():
		i += 1
		pos+=GlobalGameManager.get_direction_by_ingredient(tmp_ingredient.peek())
		tmp_durability.modify(tmp_durability.peek()-1)
		if tmp_durability.peek()==0:
			tmp_durability.dequeue()
			tmp_ingredient.dequeue()
		if i%30==0:
			var dot_instance = dot.instantiate()
			dot_instance.position = pos
			dot_instance.set_step(GlobalGameManager.now_step+i)
			call_deferred("add_child", dot_instance)
	
	var dot_instance = dot.instantiate()
	dot_instance.position = pos
	dot_instance.set_step(GlobalGameManager.now_step+i)
	dot_instance.set_type(1)
	call_deferred("add_child", dot_instance)
