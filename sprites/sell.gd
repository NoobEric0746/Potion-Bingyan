extends Node2D

func _process(delta: float) -> void:
	var label = get_node("conversation")
	label.text = GlobalSellManager.buyer_words()
	process_info()
	process_price()
	var button = get_node("SellButton")
	if GlobalSellManager.get_price()<=0:
		button.hide()
	else:
		button.show()

func process_info():
	var label = get_node("Info")
	if GlobalGameManager.potion_name == "":
		label.text = "水"
	else:
		label.text = GlobalGameManager.potion_name+"药剂"

func process_price():
	var label = get_node("Price")
	var buyer = get_node("Buyer")
	var next_day = get_node("NextDay")
	if GlobalSellManager.now>=4:
		label.hide()
		buyer.hide()
		next_day.show()
	else:
		label.show()
		buyer.show()
		next_day.hide()
		if GlobalSellManager.get_price()==0:
			label.text = "这不对吧"
		else:
			label.text = str(GlobalSellManager.get_price())+"$"


func _on_sell_button_pressed() -> void:
	if GlobalSellManager.get_price()==0:
		return
	else:
		GlobalGameManager.money+=GlobalSellManager.get_price()
		GlobalGameManager.clear_potion()
		GlobalSellManager.now += 1
		GlobalGameManager.used=true


func _on_next_day_pressed() -> void:
	GlobalSellManager._ready()
	GlobalGameManager.plant_state = {1:true,2:true,3:true}
