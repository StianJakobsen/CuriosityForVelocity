extends Label

onready var track_var = get_node("/root/TrackVariables")

func _ready():
	if not track_var.savegame.file_exists(track_var.save_path):
		
