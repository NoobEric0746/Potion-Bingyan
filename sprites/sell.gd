extends Node2D

func _process(delta: float) -> void:
	var label = get_node("conversation")
	label.text = GlobalSellManager.buyer_words()
	process_info()
	process_price()

func process_info():
	var label = get_node("Info")
	if GlobalGameManager.potion_name == "":
		label.text = "水"
	else:
		label.text = GlobalGameManager.potion_name+"药剂"

func process_price():
	var label = get_node("Price")
	if GlobalSellManager.get_price()==0:
		label.text = "这不对吧"
	else:
		label.text = str(GlobalSellManager.get_price())+"$"


func _on_sell_button_pressed() -> void:
	if GlobalSellManager.get_price()==0:
		return
	GlobalGameManager.money+=GlobalSellManager.get_price()
	GlobalGameManager.clear_potion()
	GlobalSellManager.now += 1
