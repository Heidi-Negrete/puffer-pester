extends RigidBody2D


func _ready():
	scale = Vector2(randf() + 1, randf() + 1)
	$AnimatedSprite2D.play()


func _process(_delta):
	if linear_velocity.x < 0:
		$AnimatedSprite2D.flip_v = true
	else:
		$AnimatedSprite2D.flip_v = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
