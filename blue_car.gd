extends Area2D
#signal hit

@export var max_speed = 600
@export var speed = 0
var acceleration = 20
var rotation_factor = 8
var screen_size
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if !Input.is_action_pressed("handbrake"):
		velocity = Vector2.ZERO
		velocity.x += sin(rotation)#toujours entre 0 et 1
		velocity.y -= cos(rotation)#toujours entre 0 et 1

		if Input.is_action_pressed("move_forward"):
			if speed < max_speed:
				if speed < 0:
					speed += 2 * acceleration
				speed += acceleration
		elif Input.is_action_pressed("move_back"): #need to find out why brake don't work when move_back
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
	else:
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
		degrees = rotation_factor * (max_speed / 2 + speed / 2) / (2 * max_speed)
	elif speed < -acceleration:
		degrees = -(rotation_factor * (max_speed / 2 + abs(speed) / 2) / (2 * max_speed))
	if Input.is_action_pressed("turn_right"):
		rotation_degrees += degrees
	elif Input.is_action_pressed("turn_left"):
		rotation_degrees -= degrees


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
