extends Camera2D

# 拖动相关变量
var is_dragging := false
var drag_start_position := Vector2.ZERO

# 缩放相关变量
@export var zoom_sensitivity: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 3.0

func _input(event):
	# --- 处理拖动逻辑 ---
	if event.is_action_pressed("drag"):
		is_dragging = true
		drag_start_position = get_global_mouse_position()

	if event.is_action_released("drag"):
		is_dragging = false

	# 当鼠标移动且正处于拖动状态时，更新相机位置
	if event is InputEventMouseMotion and is_dragging:
		var drag_current_position = get_global_mouse_position()
		var drag_offset = drag_start_position - drag_current_position
		position += drag_offset
		# 更新起始位置为当前鼠标位置，使拖动更平滑
		drag_start_position = get_global_mouse_position()

	# --- 处理缩放逻辑 ---
	if event.is_action_pressed("zoom_in"):
		zoom_camera(-zoom_sensitivity)
	elif event.is_action_pressed("zoom_out"):
		zoom_camera(zoom_sensitivity)

func zoom_camera(change: float):
	var new_zoom = zoom + Vector2(change, change)
	# 限制缩放范围，避免过度缩放
	new_zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	zoom = new_zoom
