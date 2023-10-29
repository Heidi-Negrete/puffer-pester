extends Node

@onready var screen_size = get_viewport().get_visible_rect().size
@export var current_scene: PackedScene


func spawn_current():
	var spawn_anchor = ['x', 'y'].pick_random()
	var spawn_origin
	var spawn_direction = 0
	if spawn_anchor == 'x':
		spawn_origin = randi_range(0, screen_size.x)
		while spawn_direction < screen_size.y + 48:
			var current = current_scene.instantiate()
			current.position = Vector2(spawn_origin, spawn_direction)
			current.z_index = 1
			current.get_node("AnimatedSprite2D").set_frame_and_progress([0,1,2].pick_random(), 0.0)
			current.get_node("AnimatedSprite2D").play()
			get_owner().add_child(current)
			current.add_to_group("current")
			spawn_direction += 48
	else: #spawn_anchor == y
		spawn_origin = randi_range(0, screen_size.y)
		while spawn_direction < screen_size.x + 48:
			var current = current_scene.instantiate()
			current.position = Vector2(spawn_direction, spawn_origin)
			current.z_index = 1
			current.get_node("AnimatedSprite2D").set_frame_and_progress([0,1,2].pick_random(), 0.0)
			current.get_node("AnimatedSprite2D").play()
			get_owner().add_child(current)
			current.add_to_group("current")
			spawn_direction += 48
	$CurrentTimer.start()

func _on_current_timer_timeout():
	get_tree().call_group("current", "queue_free") # change queue_free to custom method that reverse tweens them out of existence for a flow away animation.
	$SpawnTimer.start()


func _on_spawn_timer_timeout():
	spawn_current()


func _on_main_currents_started():
	spawn_current()
