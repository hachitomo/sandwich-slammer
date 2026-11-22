extends Node2D

#TODO
# Display order scores as they go out in the orders box

var daily_special: Types.recipe

const FONT_COLOR: Color = Color("#ac3232")

func _init() -> void:
	daily_special = Types.all_recipes.pick_random()

func _ready() -> void:
	$Specials/DailySpecial.text = Types.recipe_name(daily_special)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_special() -> String:
	return Types.recipe_name(daily_special)

func score(order: Order) -> void:
	
	print("Order up!!!")
	print(Types.recipe_name(order.recipe_match))
	print("Score: ", order.base)
