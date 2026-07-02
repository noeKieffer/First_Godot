extends Node

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()


func new_game():
	score = 0
	var star_rot = $desert_map/start_line.rotation
	var start_size = $desert_map/start_line/CollisionShape2D.shape.get_rect().size.x + $desert_map/start_line/CollisionShape2D.shape.get_rect().size.y
	var start_center = Vector2(((start_size / 2) * -sin(star_rot)) - (10 * cos(star_rot)), ((start_size / 2) * cos(star_rot)) + (10 * -sin(star_rot)))
	$StartPosition.position = ($desert_map/start_line.position + start_center) * 5
	$Blue_car.start($StartPosition.position)




func _on_score_timer_timeout() -> void:
	score += 1
