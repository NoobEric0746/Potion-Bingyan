extends Node2D
@export var now_ingredient = 0
var potion_moving = false
var ingredient_queue = Queue.new()
var durability_queue = Queue.new()
var tmp_ingredient = 0
var tmp_durability = 0
var now_step = 0
var potion_watering = false
var show_arrow = false
var smashing = false
var drying = false
var new_type = "None"
var new_level = 0
var potion_name = ""
var potion_data = {}
var used_ingredient = {1:0,2:0,3:0}
var storage_data = {1:5,2:5,3:5}
var saved_potion = {1:null,2:null,3:null}
var potion_pos = Vector2.ZERO
var potion_water = 100
var money:int = 0
var used = false
var plant_state = {1:true,2:true,3:true}
var ingredient_info = ""
var saved_potion_info = 0
var potion_o = Vector2.ZERO
var potion_pos1 = Vector2.ZERO

var firing = false
var vortex = Vector2.ZERO

@export var base_len = 150

signal queue_changed
signal start_draw_tmp
signal stop_draw_tmp
signal kill_items
signal to_craft
signal add_effect_signal
signal die_signal
signal upload_potion

func _ready():
	GlobalDataManager.load_game()
	ingredient_queue.clear()
	durability_queue.clear()
	potion_data = {}
	potion_name = ""
	new_level = 0
	#storage_data[1]=5
	#storage_data[2]=5
	#storage_data[3]=5

func show_tmp(i:bool):
	if i:
		start_draw_tmp.emit()
	else:
		stop_draw_tmp.emit()

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

func add_effect():
	if new_level == 0:
		return
	if not new_type in potion_data:
		potion_data[new_type]=new_level
		potion_name += new_type
		potion_name += str(new_level)
		add_effect_signal.emit()

func set_now_ingredient(ingredient):
	now_ingredient = ingredient

func get_direction_by_ingredient(ingredient):
	if ingredient == 1 :
		return Vector2(1,0)
	elif ingredient == 2:
		return Vector2(-0.5,1)
	elif ingredient == 3:
		return Vector2(-0.5,-1)
	else:
		return Vector2.ZERO
		
func set_moving(i: bool):
	potion_moving = i
func ismoving() -> bool:
	return potion_moving and (not ingredient_queue.is_empty())

func set_watering(i: bool):
	potion_watering = i

func add_ingredient(ingredient,smash_progress):
	ingredient_queue.enqueue(ingredient)
	durability_queue.enqueue(base_len*(smash_progress+100)/100)
	queue_changed.emit()
	used_ingredient[ingredient]+=1

func die():
	ingredient_queue.clear()
	durability_queue.clear()
	potion_data = {}
	potion_name = ""
	new_level = 0
	potion_pos = potion_o
	used_ingredient = {1:0,2:0,3:0}
	potion_water = 100
	die_signal.emit()
	
func save_potion(idx):
	
	upload_potion.emit()
	var p = {"name":potion_name,"effect":potion_data.duplicate(true),"ingredient":used_ingredient.duplicate(true),"pos":potion_pos,"water":potion_water}
	saved_potion[3] = saved_potion[2]
	saved_potion[2] = saved_potion[1]
	saved_potion[1] = p
func clear_potion():
	die()
func reload():
	die_signal.emit()
