extends Node2D

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
	var lbl = Label.new()
	lbl.text = Types.recipe_name(order.recipe_match) + ": " + str(order.get_total())
	lbl.add_theme_color_override("font_color" , Color("#ac3232"))
	lbl.add_theme_font_size_override("font_size", 8)
	$Specials/Orders.add_child(lbl)
	$Specials/Orders.move_child(lbl,0)

func get_modifier_report(order: Order) -> String:
	var result = ""
	for mod in order.modifiers:
		result  = result + Types.modifier_name(mod) + ": " + str(Types.modifier_bonus(mod)) + "\n"
	return result
		
