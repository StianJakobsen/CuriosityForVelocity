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

func _on_gotoCredits_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/creditsScreen.tscn")
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


# Car select
func _on_car1Button_pressed(): # Racecar
	track_var.car = 1
	start_game()
	pass

func _on_car2Button_pressed(): # Truck
	track_var.car = 2
	start_game()
	pass

func _on_car3Button_pressed(): # Buggy
	track_var.car = 3
	start_game()
	pass

func start_game(): # Lacks implementation.
	var track = track_var.track
	var car = track_var.car
	# add selected car to the selected map and position
	# add_child_node()?
	pass

# Music control
func _on_playSeaShanty_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/seaShanty2.mp3"))
	pass

func _on_playFanfare_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/fanfare.mp3"))
	pass

func _on_playRacingMusic_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/aggressive_racing.mp3"))
	pass
