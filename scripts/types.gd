class_name Types

enum ingredient_type {BREAD,HAM,TURKEY,SWISS,CHEDDAR,LETTUCE,AVOCADO,TOMATO,PICKLE,BACON}
enum sauce {MUSTARD,MAYO,RANCH}

static var cheeses: Array[ingredient_type] = [ingredient_type.SWISS,ingredient_type.CHEDDAR]
static var veggies: Array[ingredient_type] = [ingredient_type.LETTUCE,ingredient_type.AVOCADO,ingredient_type.TOMATO,ingredient_type.PICKLE]
static var meats: Array[ingredient_type] = [ingredient_type.HAM,ingredient_type.TURKEY,ingredient_type.BACON]

static func random_ingredient() -> ingredient_type:
	var igdt: ingredient_type = ingredient_type.BREAD
	while igdt == ingredient_type.BREAD:
		igdt = ingredient_type.values().pick_random()
	return igdt
	
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
			push_error("NOPE WTF")
			return "NOPE WTF"
	
static func random_sauce() -> sauce:
	return sauce.values().pick_random()
