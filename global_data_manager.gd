extends Node

func load_game():
	print("loading")
	# 检查存档文件是否存在
	if not FileAccess.file_exists("user://savegame.sav"):
		print("未找到存档文件。")
		return false

	# 打开文件进行读取
	var file = FileAccess.open("user://savegame.sav", FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()

		# 解析JSON字符串
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var saved_data = json.data
			# 将数据应用回游戏
			GlobalGameManager.money = saved_data["money"]
			GlobalGameManager.storage_data[1] = int(saved_data["storage"]["1"])
			GlobalGameManager.storage_data[2] = int(saved_data["storage"]["2"])
			GlobalGameManager.storage_data[3] = int(saved_data["storage"]["3"])
			GlobalGameManager.plant_state[1] = int(saved_data["garden"]["1"])
			GlobalGameManager.plant_state[2] = int(saved_data["garden"]["2"])
			GlobalGameManager.plant_state[3] = int(saved_data["garden"]["3"])
			GlobalGameManager.saved_potion = fix_dict_types(saved_data["saved_potion"])
			print(GlobalGameManager.saved_potion)
			
			#GlobalGameManager.storage_data = saved_data["storage"]
			print("游戏已加载！")
			return true
		else:
			push_error("解析存档数据失败！")
			return false
	else:
		push_error("读取存档文件失败！")
		return false

func save_game():
	var save_data = {
		"money": GlobalGameManager.money,
		"storage": GlobalGameManager.storage_data,
		"garden": GlobalGameManager.plant_state,
		"saved_potion":GlobalGameManager.saved_potion
	}

	# 将字典转换为JSON字符串
	var json_string = JSON.stringify(save_data)

	# 打开文件进行写入（user:// 路径是跨平台安全的）
	var file = FileAccess.open("user://savegame.sav", FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		print("游戏已保存！")
	else:
		push_error("保存文件失败！")

func fix_dict_types(loaded_dict: Dictionary) -> Dictionary:
	var fixed_dict = {}
	
	for key in loaded_dict:
		var value = loaded_dict[key]
		
		# 1. 先递归修复值（如果是嵌套字典或数组）
		if value is Dictionary:
			value = fix_dict_types(value)  # 递归修复嵌套字典
		
		# 2. 修复键的类型（字符串转整数）
		var fixed_key = key
		if key is String and key.is_valid_int():
			fixed_key = key.to_int()
		
		# 3. 修复值的类型（浮点数转整数）
		if value is float:
			# 使用四舍五入转换为整数，如需直接截断请改用 int(value)
			value = int(round(value))
		elif value is String and _is_vector2_string(value):
			value = string_to_vector2(value)
		
		fixed_dict[fixed_key] = value
	
	return fixed_dict

# 将字符串解析为Vector2
func string_to_vector2(vec_string: String) -> Vector2:
	# 移除字符串中不必要的部分，如"Vector2"和括号，并修剪空格
	var clean_string = vec_string.replace("Vector2", "").replace("(", "").replace(")", "").strip_edges()
	
	# 按逗号分割字符串，得到x和y的分量字符串
	var components = clean_string.split(",")
	if components.size() == 2:
		# 将分量字符串转换为浮点数
		var x = components[0].to_float()
		var y = components[1].to_float()
		return Vector2(x, y)
	else:
		# 如果格式不符合预期，打印警告并返回默认值 (0, 0)
		push_warning("无法解析Vector2字符串: " + vec_string)
		return Vector2.ZERO
# 辅助函数：判断一个字符串是否表示Vector2
func _is_vector2_string(s: String) -> bool:
	# 检查字符串是否包含Vector2的典型模式
	return (s.begins_with("Vector2(") and s.ends_with(")")) or (s.begins_with("(") and s.ends_with(")") and "," in s)
