extends HScrollBar

onready var track_var = get_node("/root/TrackVariables")

func _ready():
	if self.name == "volumeBar":
		self.value = track_var.volume
	if self.name == "lapsBar":
		self.value = track_var.num_laps
	pass

func _on_volumeBar_value_changed(value):
	$volumeLevel.text = str(round(value)) + "%"
	BackgroundMusic.adjust_volume(round(value))
	pass

func _on_lapsBar_value_changed(value):
	$lapsNumber.text = str(round(value))
	track_var.num_laps = round(value)
	pass


func _on_resumeButton_pressed():
	get_tree().paused = false
	hide()
	pass # Replace with function body.
