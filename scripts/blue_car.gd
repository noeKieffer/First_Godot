extends CharacterBody2D

@export var max_speed = 600
@export var speed = 0
var acceleration = 20
var rotation_factor = 8
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if !Input.is_action_pressed("handbrake"):
		velocity = Vector2.ZERO
		velocity.x += sin(rotation)
		velocity.y -= cos(rotation)
	
		if Input.is_action_pressed("move_forward"):
			if speed < max_speed:
				if speed < 0:
					speed += 2 * acceleration
				speed += acceleration
		elif Input.is_action_pressed("move_back"):
			if speed > -max_speed:
				if speed > 0:
					speed -= 2 * acceleration
				speed -= acceleration
		else:
			if speed > 0:
				speed -= acceleration
				if speed < acceleration:
					speed = 0 
			elif speed < 0:
				speed += acceleration
				if speed > -acceleration:
					speed = 0 
	else: #"drift mode"
		if speed < 0:
			velocity = -velocity
		velocity.x += sin(rotation)
		velocity.y -= cos(rotation)
		
		if speed > 0:
			speed -= acceleration
			if speed < acceleration:
				speed = 0 
		if speed < 0:
			speed += acceleration
			if speed > -acceleration:
				speed = 0 
	
	#direction
	var degrees = 0
	if acceleration < speed:
		degrees = rotation_factor * (max_speed / 2.0 + speed / 2.0) / (2.0 * max_speed)
	elif speed < -acceleration:
		degrees = -(rotation_factor * (max_speed / 2.0 + abs(speed) / 2.0) / (2.0 * max_speed))
	if Input.is_action_pressed("turn_right"):
		rotation_degrees += degrees
	elif Input.is_action_pressed("turn_left"):
		rotation_degrees -= degrees

	if velocity.length() > 0:   
		velocity = velocity.normalized() * speed * get_tile_speed()
	
	move_and_collide(velocity * delta)
	
	var rot8 = fmod(rotation, 2 * PI)
	if rot8 < 0:
		rot8 += 2 * PI
	rot8 *= 16 / (2 * PI)
	$AnimatedSprite2D.animation = str(int(rot8))


#Get speed value of actual tile (ex:sand tile slow the car)
func get_tile_speed() -> float:
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("tilemap")
	if !tilemap:
		return 1
	
	var cell := tilemap.local_to_map(position) / 5.0
	var data: TileData = tilemap.get_cell_tile_data(cell)
	if data:
		var tile_speed:float = data.get_custom_data("tile_speed")
		if tile_speed > 0:
			return tile_speed
	return 1


func start(pos, rot):
	position = pos
	rotation = rot
	show()
	$CollisionShape2D.disabled = false
