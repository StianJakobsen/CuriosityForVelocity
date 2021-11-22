extends Spatial


var paint_job = preload("res://Assets/Cars/car_models/paintPink.material")

onready var right_wheel = $CarMesh/tmpParent/truck/wheel_frontRight
onready var left_wheel = $CarMesh/tmpParent/truck/wheel_frontLeft
onready var left_smoke = $CarMesh/SmokeLeft
onready var right_smoke = $CarMesh/SmokeRight
onready var pickup_body = $CarMesh/tmpParent/truck/body
onready var camera_positions = $CarMesh/CameraPositions
onready var countdown_label = $Countdown/Label
onready var ball = $Ball
onready var pickup_mesh = $CarMesh
onready var ground_ray = $CarMesh/RayCast

export var sphere_offset = Vector3(0, -1.0, 0)
export var acceleration = 50
export var steering = 21
export var turn_speed = 5
export var turn_stop_limit = 0.75
export var body_tilt = 35
#Initialize controls
var steering_input = 0
var speed_input = 0


signal change_camera

var current_camera = 0
onready var num_cameras = camera_positions.get_child_count()
var timer 
var timer2
var timer3
var timer4
var timer5

var nuOfFinishedTimers = 0
var sound_has_played = false

onready var glob_var = get_node("/root/GlobalVariables")

func _ready():
	$pauseScreen.hide()
	pickup_body.mesh.surface_set_material(1, paint_job)
	ground_ray.add_exception(ball)
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout_1")
	timer.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 
	emit_signal("change_camera", camera_positions.get_child(current_camera))
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
		countdown_label.add_color_override("font_color",Color("ff0000"))
		countdown_label.set('text', '3')
		nuOfFinishedTimers += 1

func _on_timer_timeout_2():
	if nuOfFinishedTimers < 3:
		timer3 = Timer.new()
		timer3.connect("timeout",self,"_on_timer_timeout_3")
		timer3.set_wait_time(1)
		add_child(timer3) 
		timer3.start() 
		countdown_label.set('text', '2')
		nuOfFinishedTimers += 1
	
func _on_timer_timeout_3():
	if nuOfFinishedTimers < 4:
		timer4 = Timer.new()
		timer4.connect("timeout",self,"_on_timer_timeout_4")
		timer4.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer4) 
		timer4.start() 
		countdown_label.set('text', '1')
		nuOfFinishedTimers += 1

func _on_timer_timeout_4():
	if nuOfFinishedTimers < 5:
		timer5 = Timer.new()
		timer5.connect("timeout",self,"_on_timer_timeout_5")
		timer5.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer5) 
		timer5.start()
		glob_var.input_allowed = true
		$Countdown/Label.add_color_override("font_color",Color("00ff00"))
		$Countdown/Label.set('text', 'GO!')
		nuOfFinishedTimers += 1
	
func _on_timer_timeout_5():
	if nuOfFinishedTimers < 6:
		countdown_label.set('text', '')
		nuOfFinishedTimers += 1

	
func _process(delta):
#	if Input.is_action_pressed("pause") and glob_var.input_allowed:
#		glob_var.time_paused = OS.get_ticks_msec()
#		get_tree().paused = true
#		$pauseScreen.show()
	
	# Can't steer/accelerate when in the air
	if not ground_ray.is_colliding() or not glob_var.input_allowed:
		return
	speed_input = 0
	speed_input += Input.get_action_strength("accelerate") - Input.get_action_strength("brake")*0.2
	speed_input *= acceleration
#	rotate_target = lerp(rotate_target, rotate_input, 5 * delta)
	steering_input = 0
	steering_input += Input.get_action_strength("steer_left") - Input.get_action_strength("steer_right")
	steering_input *= deg2rad(steering)
	
	# animation for wheels
	right_wheel.rotation.y = steering_input
	left_wheel.rotation.y = steering_input

	if ball.linear_velocity.length() > 5.5:
		left_smoke.emitting = true
		right_smoke.emitting = true
	else:
		left_smoke.emitting = false
		right_smoke.emitting = false
		
	#Turn the pickup
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = pickup_mesh.global_transform.basis.rotated(pickup_mesh.global_transform.basis.y, steering_input*1.75)
		pickup_mesh.global_transform.basis = pickup_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		pickup_mesh.global_transform = pickup_mesh.global_transform.orthonormalized()
		
		#Tilt animation
		var t = -steering_input * ball.linear_velocity.length() / body_tilt
		pickup_body.rotation.z = lerp(pickup_body.rotation.z, t, 10 * delta)
		
	# align mesh with ground normal
	var n = ground_ray.get_collision_normal()
	var xform = align_with_y(pickup_mesh.global_transform, n.normalized())
	pickup_mesh.global_transform = pickup_mesh.global_transform.interpolate_with(xform, 10 * delta)
	
func _physics_process(delta):
	pickup_mesh.transform.origin.x = ball.transform.origin.x + sphere_offset.x
	pickup_mesh.transform.origin.z = ball.transform.origin.z + sphere_offset.z
	#LERP y to avoid bouncing
	pickup_mesh.transform.origin.y = lerp(pickup_mesh.transform.origin.y, ball.transform.origin.y + sphere_offset.y, 10 * delta)
	ball.add_central_force(-pickup_mesh.global_transform.basis.z * speed_input)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func _input(event):
	if event.is_action_pressed("change_camera"):
		current_camera = wrapi(current_camera + 1, 0, num_cameras)
		emit_signal("change_camera", camera_positions.get_child(current_camera))
