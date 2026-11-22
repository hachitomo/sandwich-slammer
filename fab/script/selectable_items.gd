extends Node2D 

#TODO
# WHY DOES THE CURSOR ADJUST ONLY AFTER REFOCUSING??? >:(

class_name SelectableItems

@export var focused: bool = false
@export var mode: Types.menu_modes
@export var grid_columns: int = 99
@export var cursor_offset: Vector2 = Vector2.ZERO
@export var cursor_texture: CompressedTexture2D
@export var cursor_default_region: Rect2
@export var rollover: bool = false

@onready var timer: Timer = $Timer

signal selected(selection)

var item_map: Dictionary[int,Vector2] = {}
var offset_map: Dictionary[int,Vector2] = {}

var cursor_index: int = 0
var enabled: bool = false
var accept_callback: Callable

func _init(points: Array[Vector2] = []) -> void:
	for i in range(points.size()):
		var point = points[i]
		var marker = Marker2D.new()
		
		# Debug
		var debug = Label.new()
		debug.text = str(i)
		debug.global_position = point
		marker.add_child(debug)
		
		marker.global_position = point
		$Items.add_child(marker)

func _ready() -> void:
	$Cursor.visible = focused
	$Cursor.region_enabled = true
	$Cursor.region_rect = cursor_default_region
	timer.wait_time = 0.05
	timer.one_shot = true
	timer.timeout.connect(_timer_timeout)

func _timer_timeout() -> void:
	self.enabled = true
	timer.stop()

func _process(_delta: float) -> void:
	if not (enabled and focused):
		return
	
	var input := Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_accept"):
		selected.emit(cursor_index)
		return
	
	if Input.is_action_just_pressed("ui_up"):
		input.y = -1
	if Input.is_action_just_pressed("ui_down"):
		input.y = 1
	if Input.is_action_just_pressed("ui_left"):
		input.x = -1
	if Input.is_action_just_pressed("ui_right"):
		input.x = 1
	
	match mode:
		Types.menu_modes.vertical:
			set_cursor(cursor_index + int(input.y))
		Types.menu_modes.horizontal:
			set_cursor(cursor_index + int(input.x))
		Types.menu_modes.grid:
			if input.x != 0:
				set_cursor(cursor_index + int(input.x))
			if input.y != 0:
				set_cursor(cursor_index + int(input.y * grid_columns))

func get_item_position(index: int) -> Vector2:
	var curval = item_map.get(cursor_index)
	if offset_map.has(index):
		curval += offset_map.get(index)
	if item_map.size() == 0:
		push_error("get item position called with no items!")
		return Vector2.ZERO
	if index < 0 or index >= item_map.size():
		return curval
	
	if not item_map.has(index):
		return curval
	var pos = item_map.get(index)
	
	return pos

# repaint markers, e.g. on stack resize
func reset_items() -> void:
	set_items(item_map)

func set_items(_items: Dictionary[int,Vector2]) -> void:
	for child in $Items.get_children():
		$Items.remove_child(child)
	for _item in _items.keys():
		item_map.set(_item,_items.get(_item))

func set_offset(item: int, offset: Vector2) -> void:
	offset_map.set(item,offset)
	reset_items()

func set_rollover(set_to: bool = true):
	rollover = set_to
	
func set_mode(set_to: Types.menu_modes) -> void:
	mode = set_to
	
func set_focus(set_to: bool = true):
	focused = set_to
	$Cursor.visible = set_to
	self.enabled = false
	timer.start()
	print("Focus set to ",set_to)

func set_cursor(index: int) -> void:
	var item = get_item_position(index)
	if item == null or index < 0 or index >= item_map.size():
		return
	
	var offset = offset_map.get(index) if offset_map.has(index) else Vector2.ZERO
	$Cursor.global_position = Vector2(item.x, item.y) + offset
	cursor_index = index

func set_cols(cols: int) -> void:
	grid_columns = cols
