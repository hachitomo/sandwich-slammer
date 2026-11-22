extends Node2D

class_name Sandwich


const sandwich_texture = preload("res://assets/img/sandwich2.png")

signal orderup(Order)

# DING DING DING IT'S THE THEME!!! :D
var layers: Array[Types.ingredient_type] = [Types.ingredient_type.BREAD]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	update_items()

func update_items() -> void:
	while $Layers.get_child_count() < layers.size():
		var new_idx = $Layers.get_child_count()
		var new_item = Sprite2D.new()
		new_item.region_enabled = true
		new_item.texture = sandwich_texture
		new_item.region_rect = Types.get_ingredient_crop(layers[new_idx])
		new_item.position = position
		new_item.offset.y = (new_idx+1) * -32
		$Layers.add_child(new_item)
	while $Layers.get_child_count() > layers.size():
		$Layers.remove_child($Layers.get_child($Layers.get_child_count()-1))

func add_ingredient(igdt: Types.ingredient_type) -> void:
	layers.append(igdt)

func score_sandwich() -> void:
	var order = Order.new()
	order.base = self.layers.map(Types.ingredient_base_score).reduce(func(acc, n): return acc + n, 0)
	order.modifiers = get_modifiers()
	order.recipe_match = get_recipe_match()
	
	# Creekside gets a pass for "too large" because it is a recipe match that naturally is
	if order.recipe_match == Types.recipe.CREEKSIDE and order.modifiers.has(Types.modifier.TOO_LARGE):
		order.modifier.erase(Types.modifier.TOO_LARGE)
	
	layers = [Types.ingredient_type.BREAD]
	orderup.emit(order)
	#TODO
	# replenish_ingredients(amount?)

func get_recipe_match() -> Types.recipe:
	
	if has_cheese() and not has_veg() and not has_cheese():
		return Types.recipe.GRILLED_CHEESE
	
	if layers.has(Types.ingredient_type.HAM) and layers.has(Types.ingredient_type.SWISS):
		return Types.recipe.HAM_SWISS
	
	if not layers.has(Types.ingredient_type.TURKEY) and [Types.ingredient_type.BACON,Types.ingredient_type.LETTUCE,Types.ingredient_type.TOMATO].all(func(igdt): return layers.has(igdt)):
		return Types.recipe.BLT
	
	if [Types.ingredient_type.BACON,Types.ingredient_type.LETTUCE,Types.ingredient_type.TOMATO].all(func(igdt): return layers.has(igdt)):
		return Types.recipe.TURKEY_CLUB
	
	#TODO: mustard
	if [Types.ingredient_type.HAM,Types.ingredient_type.SWISS,Types.ingredient_type.PICKLE].all(func(igdt): return layers.has(igdt)):
		return Types.recipe.CUBANO
	
	if [Types.ingredient_type.TURKEY,Types.ingredient_type.AVOCADO,Types.ingredient_type.BACON,Types.ingredient_type.LETTUCE,Types.ingredient_type.TOMATO,Types.ingredient_type.SWISS,Types.ingredient_type.CHEDDAR].all(func(igdt): return layers.has(igdt)):
		return Types.recipe.CREEKSIDE
	
	return Types.recipe.NONE

func get_modifiers() -> Array[Types.modifier]:
	var mods: Array[Types.modifier] = []
	
	if layers.get(layers.size()-1) != Types.ingredient_type.BREAD:
		mods.append(Types.modifier.OPEN_FACED)
	
	if layers.count(Types.ingredient_type.BREAD) > 1 and item_repeated(Types.ingredient_type.BREAD):
		mods.append(Types.modifier.EXTRA_BREAD)
	
	if any_item_repeated():
		mods.append(Types.modifier.EXTRA_INGREDIENT)
	
	if layers.size() < Types.MIN_LAYERS:
		mods.append(Types.modifier.TOO_SMALL)
	
	if layers.size() > Types.MAX_LAYERS:
		mods.append(Types.modifier.TOO_SMALL)
	
	if layers.count(Types.ingredient_type.BREAD) > 2 and not mods.has(Types.modifier.EXTRA_BREAD):
		mods.append(Types.modifier.DOUBLE_DECKER)
	
	if has_meat() and has_cheese():
		mods.append(Types.modifier.MEAT_AND_CHEESE)
	
	if not has_meat():
		mods.append(Types.modifier.VEGETARIAN)
		
	if has_meat() and has_cheese() and has_veg():
		mods.append(Types.modifier.WELL_ROUNDED)
	
	return mods


func has_cheese() -> bool:
	var has_swiss = layers.has(Types.ingredient_type.SWISS)
	var has_cheddar = layers.has(Types.ingredient_type.CHEDDAR)
	return has_swiss || has_cheddar

func has_meat() -> bool:
	var has_ham = layers.has(Types.ingredient_type.HAM)
	var has_turkey = layers.has(Types.ingredient_type.TURKEY)
	var has_bacon = layers.has(Types.ingredient_type.BACON)
	return has_ham || has_turkey || has_bacon


func has_veg() -> bool:
	var has_lettuce = layers.has(Types.ingredient_type.LETTUCE)
	var has_avocado = layers.has(Types.ingredient_type.AVOCADO)
	var has_tomato = layers.has(Types.ingredient_type.TOMATO)
	var has_pickle = layers.has(Types.ingredient_type.PICKLE)
	return has_lettuce || has_avocado || has_tomato || has_pickle

func item_repeated(item: Variant) -> bool:
	for i in range(layers.size()-2):
		if layers.get(i) == item and layers.get(i+1) == item:
			return true
	return false

func any_item_repeated() -> bool:
	for i in range(layers.size()-2):
		if layers.get(i) != Types.ingredient_type.BREAD and layers.get(i) == layers.get(i+1):
			return true
	return false

#TODO
# reset to just bread, clear out layers and child sprites - & LATER - animate?
func reset() -> void:
	pass

func size() -> int:
	return $Layers.get_child_count()
