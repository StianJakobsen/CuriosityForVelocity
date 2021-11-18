extends Node

var lap = 1
var num_laps = 2

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

var input_allowed = false
