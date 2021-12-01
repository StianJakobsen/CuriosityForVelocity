extends Button

onready var glob_var = get_node("/root/GlobalVariables")

# Button presses
func _on_gotoMenu_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/titleScreen.tscn")
	get_tree().paused = false
	glob_var.clear()
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
func _on_gotoRaceMode_pressed():
	get_tree().change_scene("res://Assets/Scenes/Menu/raceModeScreen.tscn")
	pass

func _on_snowButton_pressed():
	glob_var.track = 0
	get_tree().change_scene("res://Assets/Scenes/Menu/carSelectScreen.tscn")
	pass

func _on_desertButton_pressed():
	glob_var.track = 1
	get_tree().change_scene("res://Assets/Scenes/Menu/carSelectScreen.tscn")
	pass


# Car select
func _on_car1Button_pressed(): # Racecar
	if glob_var.track == 0:
		glob_var.higscore_key = 'snow_race'
		get_tree().change_scene("res://Assets/Scenes/SnowLevelRace.tscn")
	if glob_var.track == 1:
		glob_var.higscore_key = 'desert_race'
		get_tree().change_scene("res://Assets/Scenes/DesertLevelRace.tscn")

func _on_car2Button_pressed(): # Truck
	if glob_var.track == 0:
		glob_var.higscore_key = 'snow_truck'
		get_tree().change_scene("res://Assets/Scenes/SnowLevelPickup.tscn")
	if glob_var.track == 1:
		glob_var.higscore_key = 'desert_truck'
		get_tree().change_scene("res://Assets/Scenes/DesertLevelPickup.tscn")

func _on_startAIRace_pressed():
	glob_var.ai_race = true
	get_tree().change_scene("res://Assets/Scenes/AiRaceLevel.tscn")
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

func _on_playMegalovania_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/MEGALOVANIA.mp3"))
	pass

func _on_playFluff_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/fluff.mp3"))
	pass
	
func _on_playMario_pressed():
	BackgroundMusic.change_to_song(load("res://Assets/Music/Mario.mp3"))
	pass
