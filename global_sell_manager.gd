extends Node

var buyers_need = {}
var buyers_kindness = {}
var now

func _ready():
	create_buyers()
	now=0

func create_buyers():
	for i in range(0,3):
		buyers_need[i] = randi_range(1,3)
		buyers_kindness[i] = randi_range(10,30)

func translate(i):
	match i:
		1:
			return "治疗"
		2:
			return "中毒"
		3:
			return "爆炸"

func buyer_words():
	return "我需要:\n" + translate(buyers_need[now]) + "\n药水"

func get_price():
	if translate(buyers_need[now]) in GlobalGameManager.potion_data:
		var level = GlobalGameManager.potion_data[translate(buyers_need[now])]
		return level * buyers_kindness[now]
	else:
		return 0
