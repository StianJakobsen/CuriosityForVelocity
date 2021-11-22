extends Control

onready var track_var = get_node("/root/TrackVariables")

func _on_resumeButton_pressed():
	get_tree().paused = false
	hide()
	offset_track_timer()
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused == false: # if not paused, pause
			track_var.time_paused = OS.get_ticks_msec()
			get_tree().paused = true
			show()
		else: # else, resume game
			get_tree().paused = false
			hide()
			offset_track_timer()
	pass

func offset_track_timer():
	track_var.time_paused = OS.get_ticks_msec() - track_var.time_paused
	track_var.time_start += track_var.time_paused
	track_var.time_start_lap += track_var.time_paused
