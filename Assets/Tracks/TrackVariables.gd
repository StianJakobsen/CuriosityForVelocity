extends Node

var lap = 1
var num_laps = 1

var sector1 = false
var sector2 = false
var start = true

var last_lap_time

var time_start = 0
var time_start_lap = 0

# Settings
var volume = 100	# 0 to 100

# Track/car selection
var track = 1		# 1 = desert. 2 = snow.
var car = 1			# 1 = racecar. 2 = car2. 3 = car3.

var tracks =  [load('res://Assets/Scenes/DesertLevel.tscn'), load('res://Assets/Scenes/SnowLevel.tscn')]
var cars = [load('res://Assets/Cars/cars_kenny/RaceCar.tscn')]

var input_allowed = false
