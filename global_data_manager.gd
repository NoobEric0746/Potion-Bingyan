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
		"garden": GlobalGameManager.plant_state
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
