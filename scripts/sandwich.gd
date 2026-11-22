extends Node2D

class_name Sandwich

const sandwich_texture = preload("res://assets/img/sandwich2.png")

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
		$Layers.remove_child($Layers.get_child($Layers.get_child_count()))

func add_ingredient(igdt: Types.ingredient_type) -> void:
	layers.append(igdt)

func size() -> int:
	return $Layers.get_child_count()
