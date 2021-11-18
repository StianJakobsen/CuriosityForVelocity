extends HScrollBar

onready var track_var = get_node("/root/TrackVariables")

func _ready():
	self.value = track_var.volume
	pass

func _on_volumeBar_value_changed(value):
	$volumeLevel.text = str(round(value)) + "%"
	BackgroundMusic.adjust_volume(round(value))
	pass
