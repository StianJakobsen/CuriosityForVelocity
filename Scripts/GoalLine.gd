extends Area

onready var glob_var = get_node("/root/GlobalVariables")
var time_elapsed = 0
var highscore


func _ready():
	if not glob_var.savegame.file_exists(glob_var.save_path):
		print('file not exist')
		glob_var.create_save()
	
	if not glob_var.ai_race:
		highscore = glob_var.read_savegame(glob_var.higscore_key)
	else:
		highscore = INF

func _process(delta):
	if not glob_var.start:
		var time = glob_var.msec_to_time_string(OS.get_ticks_msec() - glob_var.time_start_lap)
		$LapTimeInterface/Timer.text = str(time)
		


func _on_GoalLine_body_entered(body):
	if glob_var.start and body.is_in_group('Car'):
			glob_var.time_start = OS.get_ticks_msec()
			glob_var.time_start_lap = OS.get_ticks_msec()
			glob_var.start = false
			$LapTimeInterface/Lap.text = 'Lap: 1'
	
	if glob_var.sector1 and glob_var.sector2:
		if glob_var.ai_race:
			if glob_var.lap == glob_var.num_laps:
				if body.is_in_group('Car'):
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverAILost.tscn")
				elif body.is_in_group('AiCar'):
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverAIWon.tscn")
		
		elif body.is_in_group('Car'):
			time_elapsed = OS.get_ticks_msec() - glob_var.time_start_lap
			if time_elapsed < glob_var.best_time:
				glob_var.best_time = time_elapsed
			glob_var.last_lap_time = glob_var.msec_to_time_string(time_elapsed)
			
			glob_var.lap = glob_var.lap + 1
			glob_var.time_start_lap = OS.get_ticks_msec()
			
			
			$LapTimeInterface/LapTime.text = $LapTimeInterface/LapTime.text + "Time: " + str(glob_var.last_lap_time) + ' \n'
			
			if (glob_var.lap - 1) == glob_var.num_laps:				
				if glob_var.best_time < highscore:
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverScreenHighscore.tscn")
				else:
					get_tree().change_scene("res://Assets/Scenes/Menu/gameOverScreen.tscn")
			else:
				$LapTimeInterface/Lap.text = $LapTimeInterface/Lap.text  + "\nLap: " + str(glob_var.lap)
			
			glob_var.sector1 = false
			glob_var.sector2 = false
				
func _on_Sector1_body_entered(body):
	if body.is_in_group('Car') or body.is_in_group('AiCar'):
		glob_var.sector1 = true


func _on_Sector2_body_entered(body):
	if body.is_in_group('Car') or body.is_in_group('AiCar'):
		glob_var.sector2 = true

func clear():
	glob_var.clear()
