extends Area2D
signal hit

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
		
	if Input.is_action_pressed("move_forward"):
		velocity.y -= cos(rotation)
		velocity.x += sin(rotation)
		if Input.is_action_pressed("turn_right"):
			rotation_degrees += 0.75
		elif Input.is_action_pressed("turn_left"):
			rotation_degrees -= 0.75
			
	elif Input.is_action_pressed("move_back"):
		velocity.y += cos(rotation)
		velocity.x -= sin(rotation)
		if Input.is_action_pressed("turn_right"):
			rotation_degrees -= 0.75
		elif Input.is_action_pressed("turn_left"):
			rotation_degrees += 0.75
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
