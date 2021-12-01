extends Node

var lap = 1
var num_laps = 1

var sector1 = false
var sector2 = false
var start = true

var time_paused = 0
var last_lap_time

var time_start = 0
var time_start_lap = 0

# Settings
var volume = 100	# 0 to 100

# Track/car selection
var track = 1		# 1 = desert. 2 = snow.
var higscore_key

var input_allowed = false

var best_time = INF
var ai_race = false

var savegame = File.new() #file
var save_path = "user://highscores.save" #place of the file
var save_data = {"snow_race": {'username': INF},
				"snow_truck": {'username': INF},
				"desert_race": {'username': INF},
				"desert_truck": {'username': INF}} #variable to store data

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()

func save(high_score):    
   save_data[higscore_key] = high_score #data to save
   savegame.open(save_path, File.WRITE) #open file to write
   savegame.store_var(save_data) #store the data
   savegame.close() # close the file

func read_savegame(key):
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data[key].values()[0] #return the value

func get_username(key):
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data[key].keys()[0] #return the value

func msec_to_time_string(time):
	var total_sec = time / 1000
	var minute = floor(total_sec / 60)
	var sec = total_sec - 60 * minute
	var msec = (time - sec * 1000) - (60000*minute)
	return str(minute) + ":" + str(sec) + ":" + str(msec)

func clear():
	lap = 1
	num_laps = 1
	sector1 = false
	sector2 = false
	start = true
	last_lap_time
	time_start = 0
	time_start_lap = 0
	# Track/car selection
	track = 1		# 1 = desert. 2 = snow.
	input_allowed = false
	best_time = INF
	ai_race = false
