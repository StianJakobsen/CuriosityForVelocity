extends Area

onready var track_var = get_node("/root/TrackVariables")
var time_elapsed = 0
var highscore



func _ready():
	if not track_var.savegame.file_exists(track_var.save_path):
		print('file not exist')
		track_var.create_save()
	highscore = track_var.read_savegame(track_var.higscore_key)
	print(highscore)

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
	if body.is_in_group('Car'):
		if track_var.start:
			track_var.time_start = OS.get_ticks_msec()
			track_var.time_start_lap = OS.get_ticks_msec()
			track_var.start = false
			$LapTimeInterface/Lap.text = 'Lap: 1'
			
		if track_var.sector1 and track_var.sector2:
			time_elapsed = OS.get_ticks_msec() - track_var.time_start_lap
			if time_elapsed < track_var.best_time:
				track_var.best_time = time_elapsed
			track_var.last_lap_time = msec_to_time_string(time_elapsed)
			
			track_var.lap = track_var.lap + 1
			track_var.time_start_lap = OS.get_ticks_msec()
			
			
			$LapTimeInterface/LapTime.text = $LapTimeInterface/LapTime.text + "Time: " + str(track_var.last_lap_time) + ' \n'
			
			if (track_var.lap - 1) == track_var.num_laps:				
				if track_var.best_time < highscore:
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverScreenHighscore.tscn")
				else:
					clear()
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverScreen.tscn")
			else:
				$LapTimeInterface/Lap.text = $LapTimeInterface/Lap.text  + "\nLap: " + str(track_var.lap)
			
			track_var.sector1 = false
			track_var.sector2 = false
		else:
			print('You have to cross sector 1 and 2')
				
func _on_Sector1_body_entered(body):
	if body.is_in_group('Car'):
		track_var.sector1 = true


func _on_Sector2_body_entered(body):
	if body.is_in_group('Car'):
		track_var.sector2 = true

func clear():
	track_var.clear()
