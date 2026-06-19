extends Node

@export var monster_scene: PackedScene
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
	$Blue_car.start($StartPosition.position)




func _on_score_timer_timeout() -> void:
	score += 1


#func _on_monster_timer_timeout() -> void:
	#$MonsterTimer.wait_time = 0.5 - score * 0.005
	#var monster = monster_scene.instantiate()
	#
	#var monster_spawn_location = get_node("MonsterPath/MonsterSpawnLocation")
	#monster_spawn_location.progress_ratio = randf()
	#
	#var direction = monster_spawn_location.rotation + PI / 2
	#
	#monster.position = monster_spawn_location.position
	#
	#var velocity = Vector2(randf_range(150.0, 250.0 + score * 2), 0.0)
	#monster.linear_velocity = velocity.rotated(direction)
	#
	#add_child(monster)
