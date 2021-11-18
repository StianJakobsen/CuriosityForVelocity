extends "res://Assets/Cars/cars_kenny/car_base.gd"

signal change_camera

var current_camera = 0
onready var num_cameras = $CameraPositions.get_child_count()
var timer
var timer2
var timer3
var timer4
var timer5

var nuOfFinishedTimers = 0

var sound_has_played = false

func _ready():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout_1")
	timer.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 
	emit_signal("change_camera", $CameraPositions.get_child(current_camera))
	nuOfFinishedTimers += 1

func _on_timer_timeout_1():
	if nuOfFinishedTimers < 2:
		timer2 = Timer.new()
		timer2.connect("timeout",self,"_on_timer_timeout_2")
		timer2.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer2)
		if !sound_has_played:
				sound_has_played = true
				$MarioStartSound.play()
		timer2.start()
		$Countdown/Label.add_color_override("font_color",Color("ff0000"))
		$Countdown/Label.set('text', '3')
		nuOfFinishedTimers += 1

func _on_timer_timeout_2():
	if nuOfFinishedTimers < 3:
		timer3 = Timer.new()
		timer3.connect("timeout",self,"_on_timer_timeout_3")
		timer3.set_wait_time(1)
		add_child(timer3) 
		timer3.start() 
		$Countdown/Label.set('text', '2')
		nuOfFinishedTimers += 1
	
func _on_timer_timeout_3():
	if nuOfFinishedTimers < 4:
		timer4 = Timer.new()
		timer4.connect("timeout",self,"_on_timer_timeout_4")
		timer4.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer4) 
		timer4.start() 
		$Countdown/Label.set('text', '1')
		nuOfFinishedTimers += 1

func _on_timer_timeout_4():
	if nuOfFinishedTimers < 5:
		timer5 = Timer.new()
		timer5.connect("timeout",self,"_on_timer_timeout_5")
		timer5.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer5) 
		timer5.start()
		track_var.input_allowed = true
		$Countdown/Label.add_color_override("font_color",Color("00ff00"))
		$Countdown/Label.set('text', 'GO!')
		nuOfFinishedTimers += 1
	
func _on_timer_timeout_5():
	if nuOfFinishedTimers < 6:
		$Countdown/Label.set('text', '')
		nuOfFinishedTimers += 1

func _input(event):
	if event.is_action_pressed("change_camera"):
		current_camera = wrapi(current_camera + 1, 0, num_cameras)
		emit_signal("change_camera", $CameraPositions.get_child(current_camera))


func get_input():
	var turn = Input.get_action_strength("steer_left")
	turn -= Input.get_action_strength("steer_right")
	steer_angle = turn * deg2rad(steering_limit)
	$tmpParent/race/wheel_frontRight.rotation.y = steer_angle*2
	$tmpParent/race/wheel_frontLeft.rotation.y = deg2rad(180) + steer_angle*2
	acceleration = Vector3.ZERO
	if Input.is_action_pressed("accelerate"):
		
		acceleration = -transform.basis.z * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = -transform.basis.z * braking
