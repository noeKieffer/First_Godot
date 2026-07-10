extends Control

#@onready var main_menu: PackedScene = preload("res://scenes/main_menu.tscn")
#@onready var start_level: PackedScene = preload("res://scenes/main.tscn")
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _prev_button_pressed() -> void:
	if ($BlueCarStats.visible == true):
		$RedCarStats.show()
		$BlueCarStats.hide()
	else:
		$BlueCarStats.show()
		$RedCarStats.hide()


func _next_button_pressed() -> void:
	if ($BlueCarStats.visible == true):
		$RedCarStats.show()
		$BlueCarStats.hide()
	else:
		$BlueCarStats.show()
		$RedCarStats.hide()


#func _select_button_pressed() -> void:
	#get_tree().change_scene_to_packed(start_level)


func _on_select_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
