extends Node2D

signal start_line_pass
var turn = 0

@onready var all_checkpoints = get_tree().get_nodes_in_group("checkpoints")

func check_all():
	for c in all_checkpoints:
		if (!c.is_checked()):
			return 0
	return 1

func _new_turn(body: Node2D) -> void:
	if (turn == 0):
		start_line_pass.emit()
		turn += 1
	if (check_all()):
		start_line_pass.emit()
		turn += 1
		for c in all_checkpoints:
			c.reset()
