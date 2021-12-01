extends Node2D

onready var glob_var = get_node("/root/GlobalVariables")

var default = load("res://Assets/Music/MEGALOVANIA.mp3")

func _ready():
	$Music.stream = default
	$Music.play()

func change_to_song(song):
	$Music.stream = song
	$Music.play()
	pass

func adjust_volume(vol):
	$Music.volume_db = vol*0.8 - 80 # from % to Db
	glob_var.volume = vol
	pass
