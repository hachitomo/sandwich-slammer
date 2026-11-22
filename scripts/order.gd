extends Node

class_name Order

var base: int
var recipe_match: Types.recipe
var modifiers: Array[Types.modifier]
var total: int

func _init() -> void:
	base = 0
	recipe_match = Types.recipe.NONE
	modifiers = []
	total = 0

func get_total() -> int:
	return self.base + \
		Types.recipe_bonus(self.recipe_match) + \
		modifiers.reduce(func(accum: int, mod: Types.modifier):return accum + Types.modifier_bonus(mod),0)
