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
var volume = 1

# Track/car selection
var track = 0		# 1 = desert. 2 = snow. 3 = not implemented
var car = 0			# 1 = car1. 2 = car2. 3 = car3.

var best_time = 0
