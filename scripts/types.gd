class_name Types

#TODO
# define recipes somehow here

enum game_state {MAIN_MENU,HOW_TO,GAME,RESULTS}
enum ingredient_type {HAM=0,TURKEY=1,TOMATO=2,AVOCADO=3,BACON=4,CHEDDAR=5,SWISS=6,PICKLE=7,LETTUCE=8,BREAD=9}
enum sauce {MUSTARD,MAYO,RANCH}
enum menu_modes {vertical, horizontal,grid}
enum recipe {NONE,GRILLED_CHEESE,HAM_SWISS,BLT,TURKEY_CLUB,CUBANO,CREEKSIDE}
enum modifier {OPEN_FACED,EXTRA_BREAD,EXTRA_INGREDIENT,TOO_SMALL,TOO_LARGE,DOUBLE_DECKER,MEAT_AND_CHEESE,VEGETARIAN,WELL_ROUNDED,DAILY_SPECIAL}
#enum sauce {MUSTARD, RANCH, MAYO}

static var cheeses: Array[ingredient_type] = [ingredient_type.SWISS,ingredient_type.CHEDDAR]
static var veggies: Array[ingredient_type] = [ingredient_type.LETTUCE,ingredient_type.AVOCADO,ingredient_type.TOMATO,ingredient_type.PICKLE]
static var meats: Array[ingredient_type] = [ingredient_type.HAM,ingredient_type.TURKEY,ingredient_type.BACON]
static var ingredients: Array[ingredient_type] = [ingredient_type.SWISS,ingredient_type.CHEDDAR,ingredient_type.LETTUCE,ingredient_type.AVOCADO,ingredient_type.TOMATO,ingredient_type.PICKLE,ingredient_type.HAM,ingredient_type.TURKEY,ingredient_type.BACON,ingredient_type.BREAD]
static var ingredients_no_bread: Array[ingredient_type] = [ingredient_type.SWISS,ingredient_type.CHEDDAR,ingredient_type.LETTUCE,ingredient_type.AVOCADO,ingredient_type.TOMATO,ingredient_type.PICKLE,ingredient_type.HAM,ingredient_type.TURKEY,ingredient_type.BACON]
static var all_recipes: Array[recipe] = [recipe.NONE,recipe.GRILLED_CHEESE,recipe.HAM_SWISS,recipe.BLT,recipe.TURKEY_CLUB,recipe.CUBANO,recipe.CREEKSIDE]

static var CURSOR_PALM_CROP = Rect2(36,3,148,31)
static var CURSOR_REACH_CROP = Rect2(171,66,74,95)
static var MIN_LAYERS = 4
static var MAX_LAYERS = 8

static var ingredient_crops: Dictionary[ingredient_type,Rect2] = {
	ingredient_type.HAM: Rect2(2,272,157,32),
	ingredient_type.TURKEY: Rect2(2,307,157,32),
	ingredient_type.TOMATO: Rect2(2,201,157,32),
	ingredient_type.AVOCADO: Rect2(2,444,157,32),
	ingredient_type.BACON: Rect2(2,410,157,32),
	ingredient_type.CHEDDAR: Rect2(2,237,157,32),
	ingredient_type.SWISS: Rect2(2,376,157,32),
	ingredient_type.PICKLE: Rect2(2,342,157,32),
	ingredient_type.LETTUCE: Rect2(2,96,157,32),
	ingredient_type.BREAD: Rect2(2,131,157,32),
}

static func random_ingredient() -> ingredient_type:
	return Types.ingredients_no_bread.pick_random()
	
static func ingredient_name(igdt: ingredient_type) -> String:
	match igdt:
		Types.ingredient_type.BREAD:
			return "BREAD"
		Types.ingredient_type.HAM:
			return "HAM"
		Types.ingredient_type.TURKEY:
			return "TURKEY"
		Types.ingredient_type.SWISS:
			return "SWISS"
		Types.ingredient_type.CHEDDAR:
			return "CHEDDAR"
		Types.ingredient_type.LETTUCE:
			return "LETTUCE"
		Types.ingredient_type.AVOCADO:
			return "AVOCADO"
		Types.ingredient_type.TOMATO:
			return "TOMATO"
		Types.ingredient_type.PICKLE:
			return "PICKLE"
		Types.ingredient_type.BACON:
			return "BACON"
		_:
			push_error("WTF IS THIS IGDT? (NAME): ",igdt)
			return "ERR IGDT"
	
static func random_sauce() -> sauce:
	return sauce.values().pick_random()

static func get_ingredient_crop(type: Types.ingredient_type) -> Rect2:
	return ingredient_crops.get(type)

static func ingredient_base_score(igdt: ingredient_type) -> int:
	match igdt:
		Types.ingredient_type.BREAD:
			return 0
		Types.ingredient_type.HAM:
			return 200
		Types.ingredient_type.TURKEY:
			return 250
		Types.ingredient_type.SWISS:
			return 200
		Types.ingredient_type.CHEDDAR:
			return 250
		Types.ingredient_type.LETTUCE:
			return 200
		Types.ingredient_type.AVOCADO:
			return 250
		Types.ingredient_type.TOMATO:
			return 200
		Types.ingredient_type.PICKLE:
			return 250
		Types.ingredient_type.BACON:
			return 300
		_:
			push_error("CAN'T SCORE INGREDIENT: ",igdt," - ",Types.ingredient_name(igdt))
			return 0

static func recipe_name(_recipe: recipe) -> String:
	match _recipe:
		recipe.GRILLED_CHEESE:
			return "Grilled Cheese"
		recipe.HAM_SWISS:
			return "Ham & Swiss"
		recipe.BLT:
			return "BLT"
		recipe.TURKEY_CLUB:
			return "Turkey Club"
		recipe.CUBANO:
			return "Cubano"
		recipe.CREEKSIDE:
			return "Creekside Club"
		recipe.NONE:
			return "Basic sandwich"
		_:
			push_error("WTF is this recipe? (name)",_recipe)
			return "ERR RECIPE"

static func recipe_bonus(_recipe: recipe) -> int:
	match _recipe:
		recipe.GRILLED_CHEESE:
			return 200
		recipe.HAM_SWISS:
			return 300
		recipe.BLT:
			return 450
		recipe.TURKEY_CLUB:
			return 550
		recipe.CUBANO:
			return 750
		recipe.CREEKSIDE:
			return 1000
		recipe.NONE:
			return 0
		_:
			push_error("WTF is this recipe? (Bonus)",_recipe)
			return 0

static func modifier_name(mod: modifier) -> String:
	match mod:
		modifier.OPEN_FACED:
			return "Open-Faced"
		modifier.EXTRA_BREAD:
			return "Doubled bread"
		modifier.EXTRA_INGREDIENT:
			return "Doubled ingredient"
		modifier.TOO_SMALL:
			return "Too small"
		modifier.TOO_LARGE:
			return "Too large"
		modifier.DOUBLE_DECKER:
			return "Double decker!!!"
		modifier.MEAT_AND_CHEESE:
			return "Meat+Cheese"
		modifier.VEGETARIAN:
			return "Vegetarian"
		modifier.WELL_ROUNDED:
			return "Well-rounded"
		modifier.DAILY_SPECIAL:
			return "Daily special"
		_:
			push_error("WTF is this modifier name?",mod)
			return "ERR MODIFIER"
			

static func modifier_bonus(mod: modifier) -> int:
	match mod:
		modifier.OPEN_FACED:
			return -100
		modifier.EXTRA_BREAD:
			return -100
		modifier.EXTRA_INGREDIENT:
			return -50
		modifier.TOO_SMALL:
			return -250
		modifier.TOO_LARGE:
			return -150
		modifier.DOUBLE_DECKER:
			return 200
		modifier.MEAT_AND_CHEESE:
			return 100
		modifier.VEGETARIAN:
			return 200
		modifier.WELL_ROUNDED:
			return 300
		modifier.DAILY_SPECIAL:
			return 1000
		_:
			push_error("WTF is this modifier?",mod)
			return 0
			
