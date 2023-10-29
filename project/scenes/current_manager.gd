extends Node

@onready var screen_size = get_viewport().get_visible_rect().size
# returns Vector2 == (480, 720)

'''
CURRENT LOOP:
Begin spawning currents when game score = 20.
Spawn an initial current group and then start currenttimer.
when current timer expires, the current group is queue_free()'d and the spawn timer starts.
When spawn timer timeouts, spawn a new currentgroup/start current timer ETC

CURRENT SPAWNING:
First set spawn_direction to x or y (50/50 chance)
set spawn_start to random point along x or y as chosen.
iterate each spawn_position with size of current tile until spawn_position >= width/height of screen as appropriate.
'''

func spawn_current():
	$CurrentTimer.start()

func _on_current_timer_timeout():
	get_tree().call_group("current", "queue_free") # change queue_free to custom method that reverse tweens them out of existence for a flow away animation.
	$SpawnTimer.start()


func _on_spawn_timer_timeout():
	spawn_current()
	$CurrentTimer.start()


func _on_main_currents_started():
	spawn_current() # score is now = 20 and can begin spawning currents
