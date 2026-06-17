extends Area2D
signal hit

@export var max_speed = 300
@export var speed = 0 #en 3 secondes (d'apres valentin)
var screen_size
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var velocity = Vector2.ZERO

	if !Input.is_action_pressed("handbrake"):
		velocity.y -= cos(rotation)
		velocity.x += sin(rotation)
	if Input.is_action_pressed("move_forward"):
		if speed < max_speed:
			if speed < 0 || speed > max_speed * 2 / 3:
				speed += 1.0
			speed += 0.5
		#if Input.is_action_pressed("turn_right"):
			#rotation_degrees += 0.75
		#elif Input.is_action_pressed("turn_left"):
			#rotation_degrees -= 0.75
	elif Input.is_action_pressed("move_back"):
		if speed > -max_speed:
			if speed > 0 || speed < -max_speed * 2 / 3:
				speed -= 1.0
			speed -= 0.5
		#if Input.is_action_pressed("turn_right"):
			#rotation_degrees -= 0.75
		#elif Input.is_action_pressed("turn_left"):
			#rotation_degrees += 0.75
	else:
		if speed > 0:
			speed -= 1.0
		elif speed < 0:
			speed += 1.0
	#if speed > 200:
	if Input.is_action_pressed("turn_right"):
		rotation_degrees += speed / 500
	elif Input.is_action_pressed("turn_left"):
		rotation_degrees -= speed / 500
	#if speed < -200:
		#if Input.is_action_pressed("turn_right"):
			#rotation_degrees -= 0.75
		#elif Input.is_action_pressed("turn_left"):
			#rotation_degrees += 0.75
	
	#print(delta)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var rot8 = fmod(rotation, 2 * PI)
	if rot8 < 0:
		rot8 += 2 * PI
	rot8 *= 16 / (2 * PI)
	$AnimatedSprite2D.animation = str(int(rot8))

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
