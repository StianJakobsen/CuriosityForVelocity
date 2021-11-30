extends Control

onready var glob_var = get_node("/root/GlobalVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = glob_var.msec_to_time_string(glob_var.best_time)

