extends Area2D

signal hit

@export var speed = 400
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	var angle = 0
	if Input.is_action_pressed("move-up"):
		velocity.y -= 1
	if Input.is_action_pressed("move-down"):
		velocity.y += 1
	if Input.is_action_pressed("move-left"):
		velocity.x -= 1
	if Input.is_action_pressed("move-right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("swim")
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	angle = Vector2(velocity).angle()
	rotation = angle
	if velocity.x < 0:
		$AnimatedSprite2D.flip_v = true
	else:
		$AnimatedSprite2D.flip_v = false


func _on_body_entered(body):
	# add death animation
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
