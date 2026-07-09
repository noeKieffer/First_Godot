extends Area2D

var check = 0

func is_checked():
	return (check)

func _on_body_entered(_sswdawsasaswbody: Node2D) -> void:
	if (check == 0):
		$Sprite2D.region_rect.position += Vector2(0, 16)
		check = 1

func reset():
	if (check == 1):
		$Sprite2D.region_rect.position -= Vector2(0, 16)
		check = 0
