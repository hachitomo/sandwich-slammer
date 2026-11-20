extends Node2D

class_name Ingredients

@export var ingredient: Types.ingredient_type
@export var count: int = 0
var items: Array[Ingredient]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game = get_parent()
	game.clear_ingredients.connect(zero)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_items() -> void:
	reset_bread_three()
	while count > items.size():
		var new_item = Ingredient.new(ingredient)
		new_item.position.y = get_parent().position.y - (32 * items.size())
		add_child(new_item)
		items.append(new_item)
	if count < items.size():
		items = items.slice(0,count)

func increase() -> void:
	count = round(count  + 1)
	update_items()
	
func decrease() -> void:
	count = round(max(count - 1, 0))
	update_items()

func zero() -> void:
	count = 0;
	update_items()

func reset_bread_three() -> void:
	if self.ingredient == Types.ingredient_type.BREAD:
		count = 3
#func ingredient_matches(igdt: Types.ingredient_type) -> bool:
	#return igdt == Types.ingredient_type.ALL || igdt == ingredient

# ...(igdt: Types.ingredient_type):
	#if not ingredient_matches(igdt):
		#return
