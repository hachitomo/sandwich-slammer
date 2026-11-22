extends Node2D

class_name Sandwich

# DING DING DING IT'S THE THEME!!! :D
var layers: Array[Types.ingredient_type] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_items() -> void:
	while $Layers.get_child_count() < layers.size():
		var new_idx = $Layers.get_child_count()
		var new_item = Sprite2D.new()
		new_item.region_enabled = true
		new_item.region_rect = Types.get_ingredient_crop(layers[new_idx])
		new_item.position.y = new_idx * -32
		$Layers.add_child(new_item)
	while $Layers.get_child_count() > layers.size():
		$Layers.remove_child($Layers.get_child($Layers.get_child_count()))

func add_ingredient(igdt: Types.ingredient_type) -> void:
	layers.append(igdt)
	update_items()
