extends Control

onready var glob_var = get_node("/root/GlobalVariables")


# Called when the node enters the scene tree for the first time.
func _ready():
	if not glob_var.savegame.file_exists(glob_var.save_path):
		$UsernameRace.text = "No time recorded"
		$UsernameTruck.text = 'No time recorded'
	else:
		if glob_var.track == 0:
			if glob_var.read_savegame('snow_race') == INF:
				$UsernameRace.text = "No time recorded"
			else:
				$UsernameRace.text = glob_var.get_username('snow_race')
				$TimeLabelRace.text = glob_var.msec_to_time_string(glob_var.read_savegame('snow_race'))
			
			if glob_var.read_savegame('snow_truck') == INF:
				$UsernameTruck.text = "No time recorded"
			else:
				$UsernameTruck.text = glob_var.get_username('snow_truck')
				$TimeLabelTruck.text = glob_var.msec_to_time_string(glob_var.read_savegame('snow_truck'))
		if glob_var.track == 1:
			if glob_var.read_savegame('desert_race') == INF:
				$UsernameRace.text = "No time recorded"
			else:
				$UsernameRace.text = glob_var.get_username('desert_race')
				$TimeLabelRace.text = glob_var.msec_to_time_string(glob_var.read_savegame('desert_race'))
			
			if glob_var.read_savegame('desert_truck') == INF:
				$UsernameTruck.text = "No time recorded"
			else:
				$UsernameTruck.text = glob_var.get_username('desert_truck')
				$TimeLabelTruck.text = glob_var.msec_to_time_string(glob_var.read_savegame('desert_truck'))

				
		
	
		
