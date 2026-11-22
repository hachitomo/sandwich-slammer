extends Node

class_name Order

var base: int
var recipe_match: Types.recipe
var modifiers: Array[Types.modifier]

func _init() -> void:
	base = 0
	recipe_match = Types.recipe.NONE
	modifiers = []
