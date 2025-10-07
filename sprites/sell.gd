extends Node2D

@export var tex_buyer:Texture2D
@export var tex_seller:Texture2D

func _process(delta: float) -> void:
	var label = get_node("conversation")
	var money = get_node("Money")
	money.text = str(GlobalGameManager.money)+"$"
	label.text = GlobalSellManager.buyer_words()
	process_info()
	process_price()
	var button = get_node("SellButton")
	var sell_tab = get_node("SellTab")
	if GlobalSellManager.get_price()<=0:
		button.hide()
	else:
		button.show()
	if GlobalSellManager.now<4 and GlobalSellManager.buyers_need[GlobalSellManager.now] == 114:
		sell_tab.show()
	else:
		sell_tab.hide()

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
	var potion = get_node("potion")
	var stop_buying = get_node("StopBuyingButton")
	var info = get_node("Info")
	if GlobalSellManager.now>=4:
		label.hide()
		buyer.hide()
		next_day.show()
		potion.hide()
		stop_buying.hide()
		info.hide()
	elif GlobalSellManager.buyers_need[GlobalSellManager.now]==114:
		label.hide()
		buyer.show()
		next_day.hide()
		potion.hide()
		stop_buying.show()
		info.hide()
		buyer.texture = tex_seller
	else:
		label.show()
		buyer.show()
		next_day.hide()
		potion.show()
		stop_buying.hide()
		info.show()
		buyer.texture = tex_buyer
		if GlobalSellManager.get_price()==0:
			label.text = "这不是我要的"
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
	GlobalDataManager.save_game()

func _on_stop_buying_button_pressed() -> void:
	GlobalSellManager.now+=1
