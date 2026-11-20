extends Node2D

@export var ingredient_start_count: int = 12
@export var cursor_offset: Vector2 = Vector2.ZERO

var ingredient_zero_point: Vector2

var init = true
var selecting = false
var count = 0

var select_region = Rect2(166,41,81,88)
var place_region = Rect2(162,0,155,32)

var available_ingredients: Dictionary[Types.ingredient_type,int] = {}

signal clear_ingredients

func _ready() -> void:
	init = true
	ingredient_zero_point = $Ham.position
	$IngredientSelections.set_mode(Types.menu_modes.grid)
	$IngredientSelections.set_cols(5)

func _process(_delta: float) -> void:
	if init:
		init_items()
		init = false
	if selecting:
		pass

func init_items() -> void:
	# Reset all ingredients nodes to zero and add the starting ingredients
	clear_ingredients.emit()
	$InitDelayTimer.start()

# increase one of the ingredient source stacks by one
func plus_ingredient() -> void:
	
	if not has_cheese():
		add_cheese()
	elif not has_veg():
		add_veg()
	elif not has_meat():
		add_meat()
	else:
		var new_type: Types.ingredient_type
		new_type = Types.random_ingredient()
		match new_type:
			Types.ingredient_type.HAM:
				$Ham.increase()
			Types.ingredient_type.TURKEY:
				$Turkey.increase()
			Types.ingredient_type.SWISS:
				$Swiss.increase()
			Types.ingredient_type.CHEDDAR:
				$Cheddar.increase()
			Types.ingredient_type.LETTUCE:
				$Lettuce.increase()
			Types.ingredient_type.AVOCADO:
				$Avocado.increase()
			Types.ingredient_type.TOMATO:
				$Tomato.increase()
			Types.ingredient_type.PICKLE:
				$Pickle.increase()
			Types.ingredient_type.BACON:
				$Bacon.increase()
			_:
				push_error("NOPE NOT A RANDOM INGREDIENT")
		count += 1
		record_add_ingredient(new_type)

func get_igdts(type: Types.ingredient_type) -> Node2D:
	match type:
		Types.ingredient_type.BREAD:
			return $Bread
		Types.ingredient_type.HAM:
			return $Ham
		Types.ingredient_type.TURKEY:
			return $Turkey
		Types.ingredient_type.SWISS:
			return $Swiss
		Types.ingredient_type.CHEDDAR:
			return $Cheddar
		Types.ingredient_type.LETTUCE:
			return $Lettuce
		Types.ingredient_type.AVOCADO:
			return $Avocado
		Types.ingredient_type.TOMATO:
			return $Tomato
		Types.ingredient_type.PICKLE:
			return $Pickle
		Types.ingredient_type.BACON:
			return $Bacon
		_:
			push_error("NOPE NOT AN IGDTS NODE!")
			return null

func has_cheese() -> bool:
	var has_swiss = available_ingredients.has(Types.ingredient_type.SWISS)
	var has_cheddar = available_ingredients.has(Types.ingredient_type.CHEDDAR)
	return has_swiss || has_cheddar
	
func add_cheese() -> void:
	var new_type = Types.cheeses.pick_random()
	match new_type:
		Types.ingredient_type.SWISS:
			$Swiss.increase()
		Types.ingredient_type.CHEDDAR:
			$Cheddar.increase()
		_:
			push_error("NOPE NOT A CHEESE")
	count += 1
	record_add_ingredient(new_type)
	
func has_meat() -> bool:
	var has_ham = available_ingredients.has(Types.ingredient_type.HAM)
	var has_turkey = available_ingredients.has(Types.ingredient_type.TURKEY)
	var has_bacon = available_ingredients.has(Types.ingredient_type.BACON)
	return has_ham || has_turkey || has_bacon
	
func add_meat() -> void:
	var new_type = Types.meats.pick_random()
	#var new_type_name = Types.ingredient_name(new_type)
	match new_type:
		Types.ingredient_type.HAM:
			$Ham.increase()
		Types.ingredient_type.TURKEY:
			$Turkey.increase()
		Types.ingredient_type.BACON:
			$Bacon.increase()
		_:
			push_error("NOPE NOT A MEAT")
	count += 1
	record_add_ingredient(new_type)

func has_veg() -> bool:
	var has_lettuce = available_ingredients.has(Types.ingredient_type.LETTUCE)
	var has_avocado = available_ingredients.has(Types.ingredient_type.AVOCADO)
	var has_tomato = available_ingredients.has(Types.ingredient_type.TOMATO)
	var has_pickle = available_ingredients.has(Types.ingredient_type.PICKLE)
	return has_lettuce || has_avocado || has_tomato || has_pickle
	
func add_veg() -> void:
	var new_type = Types.veggies.pick_random()
	#var new_type_name = Types.ingredient_name(new_type)
	match new_type:
		Types.ingredient_type.LETTUCE:
			$Lettuce.increase()
		Types.ingredient_type.AVOCADO:
			$Avocado.increase()
		Types.ingredient_type.TOMATO:
			$Tomato.increase()
		Types.ingredient_type.PICKLE:
			$Pickle.increase()
		_:
			push_error("NOPE NOT A VEG")
	count += 1
	record_add_ingredient(new_type)

func record_add_ingredient(new_type: Types.ingredient_type) -> void:
	if available_ingredients.has(new_type):
		var existing = available_ingredients.get(new_type)
		available_ingredients.set(new_type,existing+1)
	else:
		available_ingredients.set(new_type,1)

func add_ingredient_points() -> void:
	var points: Dictionary[Types.ingredient_type,Vector2] = {}
	for type in Types.ingredients_no_bread:
		var _pos = get_ingredient_selection_point(type)
		points.set(type, _pos)
	$IngredientSelections.set_items(points)
		

func get_ingredient_selection_point(igdt: Types.ingredient_type) -> Vector2:
	return get_igdts(igdt).position + cursor_offset

func _on_init_delay_timer_timeout() -> void:
	if count < ingredient_start_count:
		plus_ingredient()
	else:
		$InitDelayTimer.stop()
		add_ingredient_points()
		selecting = true
		$IngredientSelections.set_focus(true)
