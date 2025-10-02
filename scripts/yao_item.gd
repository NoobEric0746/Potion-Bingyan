extends RigidBody2D

var is_being_dragged = false
var drag_offset = Vector2.ZERO
@export var max_speed: float = 500.0
var ingredient_type = 0
var smash_progress=0;
var mouse_in = false

@export var texture_0: Texture2D
@export var texture_1: Texture2D
@export var texture_2: Texture2D
@export var texture_3: Texture2D

func _ready():
	input_pickable = true
	is_being_dragged = true
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	freeze = true
	z_index = 100

func _input_event(viewport,event,shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_being_dragged=true
				drag_offset = global_position - get_global_mouse_position()
				freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
				freeze = true
			else:
				if is_being_dragged:
					is_being_dragged=false
					freeze=false

func _physics_process(delta):
	if is_being_dragged:
		global_position=get_global_mouse_position()+drag_offset
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			is_being_dragged=false
			freeze=false

func _integrate_forces(state: PhysicsDirectBodyState2D):
	var current_velocity := state.linear_velocity
	
	# 如果当前速度超过了最大速度限制
	if current_velocity.length() > max_speed:
		# 将速度向量缩放到最大速度
		state.linear_velocity = current_velocity.normalized() * max_speed

func set_ingredient_type(type):
	ingredient_type=type
	
func get_ingredient_type():
	return ingredient_type

func update_texture():
	if ingredient_type==1:
		get_node("Sprite2D").texture = texture_1
	elif ingredient_type==2:
		get_node("Sprite2D").texture = texture_2
	elif ingredient_type==3:
		get_node("Sprite2D").texture = texture_3
	else:
		get_node("Sprite2D").texture = texture_0


func _on_mouse_entered() -> void:
	get_node("SmashBar").show()
	GlobalGameManager.tmp_ingredient = ingredient_type
	GlobalGameManager.tmp_durability = GlobalGameManager.base_len*(smash_progress+100)/100
	GlobalGameManager.show_tmp(true)
	mouse_in = true


func _on_mouse_exited() -> void:
	get_node("SmashBar").hide()
	GlobalGameManager.tmp_ingredient = 0
	GlobalGameManager.tmp_durability = 0
	GlobalGameManager.show_tmp(false)
	mouse_in = false

func _process(delta: float) -> void:
	if mouse_in:
		GlobalGameManager.tmp_durability = GlobalGameManager.base_len*(smash_progress+100)/100
		
