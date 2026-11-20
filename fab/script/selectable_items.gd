extends Node2D

class_name SelectableItems

@export var focused: bool = true
@export var mode: Types.menu_modes
@export var grid_columns: int = 99
@export var cursor_offset: Vector2 = Vector2.ZERO
@export var cursor_texture: CompressedTexture2D
@export var cursor_default_region: Rect2
@export var rollover: bool = false

var items: Node2D
var item_map: Dictionary[Types.ingredient_type,Marker2D]
var cursor: Sprite2D = Sprite2D.new()

var cursor_index: int = 0

func _init(points: Array[Vector2] = []) -> void:
	for i in range(points.size()):
		var point = points[i]
		var marker = Marker2D.new()
		var debug = Label.new()
		debug.text = str(i)
		debug.global_position = point
		marker.add_child(debug)
		marker.global_position = point
		items.add_child(marker)

func _ready() -> void:
	items = $items
	cursor = $Cursor
	cursor.visible = true
	cursor.region_enabled = true
	cursor.region_rect = cursor_default_region

func _process(_delta: float) -> void:
	
	var input := Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_just_pressed("ui_down"):
		input.y += 1
	if Input.is_action_just_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_just_pressed("ui_right"):
		input.x += 1
	
	match mode:
		Types.menu_modes.vertical:
			if input.y != 0:
				set_cursor(cursor_index + int(input.y * grid_columns))
		Types.menu_modes.horizontal:
			if input.x != 0:
				set_cursor(cursor_index + int(input.x))
		Types.menu_modes.grid:
			if input.x != 0:
				set_cursor(cursor_index + int(input.x))
			if input.y != 0:
				set_cursor(cursor_index + int(input.y))

func get_item(index: int) -> Marker2D:
	if items == null:
		return null
	if index < 0 or index > items.get_child_count():
		return null
	
	var child = item_map.get(index)
	if child is not Marker2D:
		return null
	
	return child

func set_items(_items: Dictionary[Types.ingredient_type,Vector2]) -> void:
	print(_items)
	for child in items.get_children():
		items.remove_child(child)
	for _item in _items.keys():
		var new_marker = Marker2D.new()
		new_marker.global_position = _items.get(_item)
		items.add_child(new_marker)
		item_map.set(_item,new_marker)
	set_cursor(0)

func set_rollover(set_to: bool = true):
	rollover = set_to
	
func set_mode(set_to: Types.menu_modes) -> void:
	mode = set_to
	
func set_focus(set_to: bool = true):
	focused = set_to
	cursor.visible = true

func set_cursor(index: int) -> void:
	var item = get_item(index)
	if item == null:
		return
	
	global_position = Vector2(item.global_position.x, item.global_position.y)

func set_cols(cols: int) -> void:
	grid_columns = cols
