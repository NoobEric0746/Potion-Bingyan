extends Area2D

var start_pos = Vector2.ZERO
var water = 100
@export var dis1:int
@export var dis2:int
@export var dis3:int

func _ready():
	set_process(true)
	start_pos = global_position


func _process(delta: float) -> void:
	get_new_potion();
	get_node("Label").text=str(water)
	
	if GlobalGameManager.ismoving():
		#print(GlobalGameManager.get_now_ingredient())
		position += GlobalGameManager.get_direction_by_ingredient(GlobalGameManager.get_now_ingredient())
		GlobalGameManager.use_ingredient();
		
		if GlobalGameManager.drying:
			water -= 1
			if water<=0:
				print("failed")
		else:
			water=100
	if GlobalGameManager.potion_watering:
		var direction = start_pos - global_position
		if direction.length() < 2.0:
			return
		var movement = direction.normalized()
		global_position += movement

func get_new_potion():
	var potions = get_parent().get_tree().get_nodes_in_group("aim_potion")
	var flag=false
	for p in potions:
		var distance = (p.global_position - global_position).length()
		if distance<=dis3:
			GlobalGameManager.new_type = p.potion_type
			GlobalGameManager.new_level = 3
			flag=true
		elif distance<=dis2:
			GlobalGameManager.new_type = p.potion_type
			GlobalGameManager.new_level = 2
			flag=true
		elif distance<=dis1:
			GlobalGameManager.new_type = p.potion_type
			GlobalGameManager.new_level = 1
			flag=true
	if flag==false:
		GlobalGameManager.new_type = str("None")
		GlobalGameManager.new_level = 0
	var label = get_node("Label2")
	if GlobalGameManager.new_level==0:
		label.hide()
	else:
		label.show()
	label.text = GlobalGameManager.new_type+str(GlobalGameManager.new_level)
