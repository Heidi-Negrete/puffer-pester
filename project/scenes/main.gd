extends Node

@export var enemy_scene: PackedScene
var score


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Puffer Party!\nSWIMMMM!")

func _on_mob_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var spawn_location = $MobPath/MobSpawnLocation
	spawn_location.progress_ratio = randf()
	enemy.position = spawn_location.position
	var direction = spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)
	add_child(enemy)


func _on_start_timer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
