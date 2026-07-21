extends Node

#var score
@export var car_color: String
var time_elapsed: float
var turn: int
var best_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/LapTimerLabel.hide()
	new_game()
	time_elapsed = 0.0
	turn = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time_elapsed += _delta
	$CanvasLayer/LapTimerLabel.text = "%02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed * 100, 100)]


func new_game():
	var star_rot = $desert_map/start_line.rotation
	var start_size = $desert_map/start_line/CollisionShape2D.shape.get_rect().size.x + $desert_map/start_line/CollisionShape2D.shape.get_rect().size.y
	var start_center = Vector2(((start_size / 2) * -sin(star_rot)) - (10 * cos(star_rot)), ((start_size / 2) * cos(star_rot)) + (10 * -sin(star_rot)))
	$StartPosition.position = ($desert_map/start_line.position + start_center) * 5
	$Red_car.start($StartPosition.position, $desert_map/start_line.rotation + PI / 2)


func _new_turn() -> void:
	if (turn == 0):
		$CanvasLayer/LastTurnLabel.text = "Last Lap : XX:XX:XX"
		$CanvasLayer/BestTurnLabel.text = "Best Lap : XX:XX:XX"
		turn += 1
	elif (turn == 1):
		$CanvasLayer/LastTurnLabel.text = "Last Lap : %02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed * 100, 100)]
		$CanvasLayer/BestTurnLabel.text = "Best Lap : %02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed * 100, 100)]
		best_time = time_elapsed
		turn += 1
	elif (time_elapsed < best_time):
		best_time = time_elapsed
		$CanvasLayer/LastTurnLabel.text = "Last Lap : %02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed * 100, 100)]
		$CanvasLayer/BestTurnLabel.text = "Best Lap : %02d:%02d:%02d" % [best_time / 60, fmod(best_time, 60), fmod(best_time * 100, 100)]
	else:
		$CanvasLayer/LastTurnLabel.text = "Last Lap : %02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed * 100, 100)]
	time_elapsed = 0.0
	$CanvasLayer/LapTimerLabel.show()
