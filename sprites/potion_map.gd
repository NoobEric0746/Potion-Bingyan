extends Node2D
@export var dot: PackedScene

func _ready():
	GlobalGameManager.queue_changed.connect(_on_queue_changed)

func _on_queue_changed():
	clear_dots()
	draw_dots()
	
func clear_dots():
	var dots = get_tree().get_nodes_in_group("dot")
	for i in range(dots.size()-1,-1,-1):
		var node = dots[i]
		if is_instance_valid(node):
			node.queue_free()
func draw_dots():
	var tmp_ingredient = GlobalGameManager.ingredient_queue.duplicate()
	var tmp_durability = GlobalGameManager.durability_queue.duplicate()
	var pos = get_node("Potion").position
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
