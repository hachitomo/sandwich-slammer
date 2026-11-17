extends Sprite2D

class_name Ingredient

@export var ingredient: Types.ingredient_type

# enum ingredient_type {BREAD,HAM,TURKEY,SWISS,CHEDDAR,LETTUCE,AVOCADO,TOMATO,PICKLE,BACON}
var layer_pos: Dictionary = {
	"BREAD": 96,
	"HAM": 192,
	"TURKEY": 224,
	"SWISS": 288,
	"CHEDDAR": 160,
	"LETTUCE": 0,
	"AVOCADO": 416,
	"TOMATO": 128,
	"PICKLE": 256,
	"BACON": 320,
	"WTF": 352,
}
var layer_width = 160
var layer_height = 32

func _init(igdt: Types.ingredient_type) -> void:
	texture = load("res://assets/img/sandwich.png")
	self.ingredient = igdt
	print("Creating new ingredient: ",igdt)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ingredient_name = type_to_string(ingredient)
	var source_y = layer_pos.get(ingredient_name)
	region_enabled = true
	region_rect = Rect2(0,source_y,layer_width,layer_height)
	print("Adding new ",ingredient_name, region_rect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func type_to_string(igdt: Types.ingredient_type) -> String:
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
	return "WTF"
