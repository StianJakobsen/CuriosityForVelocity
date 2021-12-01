extends Control

onready var glob_var = get_node("/root/GlobalVariables")

func _on_resumeButton_pressed():
	get_tree().paused = false
	hide()
	offset_track_timer()
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused == false: # if not paused, pause
			glob_var.time_paused = OS.get_ticks_msec()
			get_tree().paused = true
			show()
		else: # else, resume game
			get_tree().paused = false
			hide()
			offset_track_timer()
	pass

func offset_track_timer():
	glob_var.time_paused = OS.get_ticks_msec() - glob_var.time_paused
	glob_var.time_start += glob_var.time_paused
	glob_var.time_start_lap += glob_var.time_paused
