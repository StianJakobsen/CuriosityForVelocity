extends Control

onready var track_var = get_node("/root/TrackVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = track_var.msec_to_time_string(track_var.best_time)

