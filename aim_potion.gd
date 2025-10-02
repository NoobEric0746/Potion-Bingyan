extends Node2D

@export var potion_type:String

func _ready():
	get_node("Label").text = potion_type
