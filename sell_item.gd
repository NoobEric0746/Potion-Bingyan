extends TextureButton
@export var idx:int
@export var tex1:Texture2D
@export var tex2:Texture2D
@export var tex3:Texture2D

func _ready() -> void:
	GlobalSellManager.new_day.connect(Callable(self,"_on_new_day"))
	
	if GlobalSellManager.seller_items[idx]==1:
		texture_normal = tex1
	if GlobalSellManager.seller_items[idx]==2:
		texture_normal = tex2
	if GlobalSellManager.seller_items[idx]==3:
		texture_normal = tex3
	if GlobalSellManager.seller_items[idx]==0:
		hide()
	
	get_node("Label").text = str(GlobalSellManager.seller_prices[idx])+"$"

func _on_pressed() -> void:
	if GlobalGameManager.money>=GlobalSellManager.seller_prices[idx]:
		GlobalGameManager.money-=GlobalSellManager.seller_prices[idx]
		GlobalGameManager.storage_data[GlobalSellManager.seller_items[idx]]+=5
		GlobalSellManager.seller_items[idx]=0
		hide()

func _on_new_day():
	show()
