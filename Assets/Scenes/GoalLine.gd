extends Area

onready var track_var = get_node("/root/TrackVariables")
var time_elapsed = 0

func _process(delta):
	if not track_var.start:
		var time = msec_to_time_string(OS.get_ticks_msec() - track_var.time_start)
		$LapTimeInterface/Timer.text = str(time)
		
func msec_to_time_string(time):
	var total_sec = time / 1000
	var minute = floor(total_sec / 60)
	var sec = total_sec - 60 * minute
	var msec = time - sec * 1000
	return str(minute) + ":" + str(sec) + ":" + str(msec)

func _on_GoalLine_body_entered(body):
	if body.is_in_group('RaceCar'):
		if track_var.start:
			track_var.time_start = OS.get_ticks_msec()
			track_var.time_start_lap = OS.get_ticks_msec()
			track_var.start = false
			$LapTimeInterface/Lap.text = 'Lap: 1'
			
		if track_var.sector1 and track_var.sector2:
			time_elapsed = OS.get_ticks_msec() - track_var.time_start_lap
			track_var.last_lap_time = msec_to_time_string(time_elapsed)
			
			track_var.lap = track_var.lap + 1
			track_var.time_start_lap = OS.get_ticks_msec()
			
			
			$LapTimeInterface/LapTime.text = $LapTimeInterface/LapTime.text + "Time: " + str(track_var.last_lap_time) + ' \n'
			
			if (track_var.lap - 1) == track_var.num_laps:
				get_tree().change_scene("res://Assets/Scenes/Menu/gameOverScreen.tscn")
			else:
				$LapTimeInterface/Lap.text = $LapTimeInterface/Lap.text  + "\nLap: " + str(track_var.lap)
			
			track_var.sector1 = false
			track_var.sector2 = false
		else:
			print('You have to cross sector 1 and 2')
				
func _on_Sector1_body_entered(body):
	if body.is_in_group('RaceCar'):
		track_var.sector1 = true
		print('Sector 1 is entered')


func _on_Sector2_body_entered(body):
	if body.is_in_group('RaceCar'):
		track_var.sector2 = true
		print('Sector 2 is eneterd')
