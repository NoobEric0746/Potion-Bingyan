# Potion.gd
class_name Potion

var potion_name: String
var ingredients: Dictionary
var effects: Dictionary

# 构造函数
func _init(name: String = "", ing: Dictionary = {}, eff: Dictionary = {}):
	potion_name = name
	ingredients = _validate_and_create_indexed_dict(ing, 1, 3, "ingredients")
	effects = _validate_and_create_indexed_dict(eff, 1, 3, "effects")

# 辅助方法：验证并创建索引范围为1-3的字典
func _validate_and_create_indexed_dict(source_dict: Dictionary, min_index: int, max_index: int, dict_name: String) -> Dictionary:
	var result := {}
	
	for key in source_dict:
		# 确保键在允许的范围内
		if key < min_index or key > max_index:
			push_error("键 %d 超出允许范围 (%d-%d) for %s" % [key, min_index, max_index, dict_name])
			continue
		
		# 确保键是整数类型
		if not key is int:
			push_error("键必须是整数类型 for %s" % dict_name)
			continue
			
		result[key] = source_dict[key]
	
	return result

# 设置成分
func set_ingredient(index: int, value) -> bool:
	if index < 1 or index > 3:
		push_error("成分索引必须在1-3之间")
		return false
	
	ingredients[index] = value
	return true

# 获取成分
func get_ingredient(index: int):
	if index < 1 or index > 3:
		push_error("成分索引必须在1-3之间")
		return null
	
	return ingredients.get(index)

# 设置效果
func set_effect(index: int, value) -> bool:
	if index < 1 or index > 3:
		push_error("效果索引必须在1-3之间")
		return false
	
	effects[index] = value
	return true

# 获取效果
func get_effect(index: int):
	if index < 1 or index > 3:
		push_error("效果索引必须在1-3之间")
		return null
	
	return effects.get(index)

# 获取所有有效成分的数量
func get_ingredient_count() -> int:
	return ingredients.size()

# 获取所有有效效果的数量
func get_effect_count() -> int:
	return effects.size()

# 转换为字典（便于序列化）
func to_dict() -> Dictionary:
	return {
		"name": potion_name,
		"ingredients": ingredients,
		"effects": effects
	}

# 从字典加载数据
func from_dict(data: Dictionary) -> void:
	if data.has("name"):
		potion_name = data["name"]
	
	if data.has("ingredients") and data["ingredients"] is Dictionary:
		ingredients = _validate_and_create_indexed_dict(data["ingredients"], 1, 3, "ingredients")
	
	if data.has("effects") and data["effects"] is Dictionary:
		effects = _validate_and_create_indexed_dict(data["effects"], 1, 3, "effects")

# 获取信息字符串
func get_info() -> String:
	return "药水 '%s': 成分 %s, 效果 %s" % [potion_name, ingredients, effects]
