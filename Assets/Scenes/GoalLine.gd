extends Area

onready var track_var = get_node("/root/TrackVariables")

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
			track_var.start = false
			
		if track_var.sector1 and track_var.sector2:
			track_var.last_lap_time = msec_to_time_string(
				OS.get_ticks_msec() - track_var.time_start)
					
			track_var.lap = track_var.lap + 1
			track_var.sector1 = false
			track_var.sector2 = false
			track_var.time_start = OS.get_ticks_msec()
			
			$LapTimeInterface/Lap.text = "Lap: " + str(track_var.lap)
			$LapTimeInterface/Time.text = "Time: " + str(track_var.last_lap_time)
			
		else:
			print('You have to cross sector 1 and 2')
			if track_var.lap == 1:
				$LapTimeInterface/Lap.text = 'Lap: 1'
				
func _on_Sector1_body_entered(body):
	if body.is_in_group('RaceCar'):
		track_var.sector1 = true
		print('Sector 1 is entered')


func _on_Sector2_body_entered(body):
	if body.is_in_group('RaceCar'):
		track_var.sector2 = true
		print('Sector 2 is eneterd')
