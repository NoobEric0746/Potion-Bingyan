extends Node

var buyers_need = {}
var buyers_kindness = {}
var now
var seller_items = {}
var seller_prices = {}

signal new_day

func _ready():
	create_buyers()
	now=0
	new_day.emit()

func create_buyers():
	for i in range(0,4):
		buyers_need[i] = randi_range(1,3)
		buyers_kindness[i] = randi_range(10,30)
	for i in range(1,4):
		seller_items[i] = randi_range(1,3)
		seller_prices[i] = randi_range(10,20)
	var seller_idx = randi_range(0,3)
	buyers_need[seller_idx] = 114

func translate(i):
	match i:
		1:
			return "治疗"
		2:
			return "中毒"
		3:
			return "爆炸"

func buyer_words():
	if now<4:
		if buyers_need[now]==114:
			return "我来卖东西"
		else:
			return "我需要:\n" + translate(buyers_need[now]) + "\n药水"
	else:
		return "今日结束"

func get_price():
	if now>=4:
		return -1
	if translate(buyers_need[now]) in GlobalGameManager.potion_data:
		var level = GlobalGameManager.potion_data[translate(buyers_need[now])]
		return level * buyers_kindness[now]
	else:
		return 0
