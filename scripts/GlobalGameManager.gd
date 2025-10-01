extends Node2D
@export var now_ingredient = 0
var potion_moving = false
var ingredient_queue = Queue.new()
var durability_queue = Queue.new()
var now_step = 0
var potion_watering = false
var show_arrow = false
var smashing = false
@export var base_len = 150

signal queue_changed

func get_now_ingredient():
	if ingredient_queue.is_empty():
		return 0
	return ingredient_queue.peek()
func get_now_durability():
	if durability_queue.is_empty():
		return 0
	return durability_queue.peek()
func use_ingredient():
	if ingredient_queue.is_empty():
		return
	durability_queue.modify(durability_queue.peek()-1)
	now_step+=1
	if durability_queue.peek()==0:
		durability_queue.dequeue()
		ingredient_queue.dequeue()

func set_now_ingredient(ingredient):
	now_ingredient = ingredient

func get_direction_by_ingredient(ingredient):
	if ingredient == 1 :
		return Vector2(1,0)
	elif ingredient == 2:
		return Vector2(-0.3,1)
	elif ingredient == 3:
		return Vector2(-0.3,-1)
	else:
		return Vector2.ZERO
		
func set_moving(i: bool):
	potion_moving = i
func ismoving() -> bool:
	return potion_moving

func set_watering(i: bool):
	potion_watering = i

func add_ingredient(ingredient,smash_progress):
	ingredient_queue.enqueue(ingredient)
	durability_queue.enqueue(base_len*(smash_progress+100)/100)
	queue_changed.emit()
