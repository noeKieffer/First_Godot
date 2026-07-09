class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Start_Button
@onready var close_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Close_Button
@onready var start_level: PackedScene = preload("res://scenes/main.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(on_start_pressed)
	close_button.button_down.connect(on_close_pressed)


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_close_pressed() -> void:
	get_tree().quit()
