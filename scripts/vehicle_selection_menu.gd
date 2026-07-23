extends Control


#func _menu_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
#
#
#func _prev_button_pressed() -> void:
	#if (!$Select_menu.select_previous_available()):
		#$Select_menu.current_tab = $Select_menu.get_tab_count() - 1
#
#
#func _next_button_pressed() -> void:
	#if (!$Select_menu.select_next_available()):
		#$Select_menu.current_tab = 0
#
#
#func _on_select_button_button_down() -> void:
	#Globals.car_color = $Select_menu.get_tab_title($Select_menu.current_tab)
	#get_tree().change_scene_to_file("res://scenes/main.tscn")


var color = ["blue","red","green","yellow"]
var i = 0
var tween_lifetime = 0.7
#@onready var tween = get_tree().create_tween()


func _menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _prev_button_pressed() -> void:
	$Prev_Button.disabled = true
	$Next_Button.disabled = true
	var tween = get_tree().create_tween()
	if ($Select_menu/road.position.y == 0):
		i = 3
		tween.tween_property($Select_menu/road, "position", $Select_menu/road.position + Vector2(0, -900), tween_lifetime)
	else:
		i -= 1
		tween.tween_property($Select_menu/road, "position", $Select_menu/road.position + Vector2(0, 300), tween_lifetime)
	await get_tree().create_timer(tween_lifetime).timeout
	$Prev_Button.disabled = false
	$Next_Button.disabled = false


func _next_button_pressed() -> void:
	$Prev_Button.disabled = true
	$Next_Button.disabled = true
	var tween = get_tree().create_tween()
	if ($Select_menu/road.position.y == -900):
		i = 0
		tween.tween_property($Select_menu/road, "position", $Select_menu/road.position + Vector2(0, 900), tween_lifetime)
	else:
		i += 1
		tween.tween_property($Select_menu/road, "position", $Select_menu/road.position + Vector2(0, -300), tween_lifetime)
	await get_tree().create_timer(tween_lifetime).timeout
	$Prev_Button.disabled = false
	$Next_Button.disabled = false


func _on_select_button_button_down() -> void:
	Globals.car_color = color[i]
	get_tree().change_scene_to_file("res://scenes/main.tscn")
