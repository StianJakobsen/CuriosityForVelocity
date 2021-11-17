extends Button

onready var track_var = get_node("/root/TrackVariables")

# Button presses
func _on_gotoMenu_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/titleScreen.tscn")
	pass

func _on_gotoSettings_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/settingsScreen.tscn")
	pass

func _on_gotoLevelSelect_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/levelSelectScreen.tscn")
	pass

func _on_gotoCarSelect_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/carSelectScreen.tscn")
	pass

func _on_startGame_pressed():
	# not implemented
	pass

func _on_gotoCredits_pressed():
	# not implemented
	pass

func _on_quitButton_pressed():
	get_tree().quit()
	pass


# Level select
func _on_snowButton_pressed():
	track_var.track = 1
	get_tree().change_scene("res://Assets/Scenes/Menu/carSelectScreen.tscn")
	pass

func _on_desertButton_pressed():
	track_var.track = 2
	get_tree().change_scene("res://Assets/Scenes/Menu/carSelectScreen.tscn")
	pass

func _on_unknownLvlButton_pressed(): # not implemented as of 17. dec
	track_var.track = 0
	pass


# Car select
func _on_car1Button_pressed():
	track_var.car = 1
	# lacking goto level implementation
	pass

func _on_car2Button_pressed():
	track_var.car = 2
	# lacking goto level implementation
	pass

func _on_car3Button_pressed():
	track_var.car = 3
	# lacking goto level implementation
	pass
