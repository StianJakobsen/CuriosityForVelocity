extends Control

onready var track_var = get_node("/root/TrackVariables")


# Called when the node enters the scene tree for the first time.
func _ready():
	if not track_var.savegame.file_exists(track_var.save_path):
		$UsernameRace.text = "No time recorded"
		$UsernameTruck.text = 'No time recorded'
	else:
		if track_var.track == 0:
			if track_var.read_savegame('snow_race') == INF:
				$UsernameRace.text = "No time recorded"
			else:
				$UsernameRace.text = track_var.get_username('snow_race')
				$TimeLabelRace.text = track_var.msec_to_time_string(track_var.read_savegame('snow_race'))
			
			if track_var.read_savegame('snow_truck') == INF:
				$UsernameTruck.text = "No time recorded"
			else:
				$UsernameTruck.text = track_var.get_username('snow_truck')
				$TimeLabelTruck.text = track_var.msec_to_time_string(track_var.read_savegame('snow_truck'))
		if track_var.track == 1:
			if track_var.read_savegame('desert_race') == INF:
				$UsernameRace.text = "No time recorded"
			else:
				$UsernameRace.text = track_var.get_username('desert_race')
				$TimeLabelRace.text = track_var.msec_to_time_string(track_var.read_savegame('desert_race'))
			
			if track_var.read_savegame('desert_truck') == INF:
				$UsernameTruck.text = "No time recorded"
			else:
				$UsernameTruck.text = track_var.get_username('desert_truck')
				$TimeLabelTruck.text = track_var.msec_to_time_string(track_var.read_savegame('desert_truck'))

				
		
	
		
