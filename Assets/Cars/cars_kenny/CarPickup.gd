extends Spatial


var red_paint = preload("res://Assets/Cars/cars_kenny/paintPink.material")

onready var ball = $Ball
onready var car_mesh = $CarMesh
onready var ground_ray = $CarMesh/RayCast
# mesh references
onready var right_wheel = $CarMesh/tmpParent/truck/wheel_frontRight
onready var left_wheel = $CarMesh/tmpParent/truck/wheel_frontLeft
onready var body_mesh = $CarMesh/tmpParent/truck/body


export (bool) var show_debug = false
export var sphere_offset = Vector3(0, -1.0, 0)
export var acceleration = 50
export var steering = 21
export var turn_speed = 5
export var turn_stop_limit = 0.75
export var body_tilt = 35

var speed_input = 0
var rotate_input = 0

signal change_camera

var current_camera = 0
onready var num_cameras = $CarMesh/CameraPositions.get_child_count()
var timer
var timer2
var timer3
var timer4
var timer5

var nuOfFinishedTimers = 0
var sound_has_played = false

onready var track_var = get_node("/root/TrackVariables")

func _ready():
	$CarMesh/tmpParent/truck/body.mesh.surface_set_material(1, red_paint)
	$Ball/DebugMesh.visible = show_debug
	ground_ray.add_exception(ball)
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout_1")
	timer.set_wait_time(1) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 
	emit_signal("change_camera", $CarMesh/CameraPositions.get_child(current_camera))
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

	
func _process(delta):
	# Can't steer/accelerate when in the air
	if not ground_ray.is_colliding() or not track_var.input_allowed:
		return
	# f/b input
	speed_input = 0
	speed_input += Input.get_action_strength("accelerate")
	speed_input -= Input.get_action_strength("brake") 
	speed_input *= acceleration
	# steer input
#	rotate_target = lerp(rotate_target, rotate_input, 5 * delta)
	rotate_input = 0
	rotate_input += Input.get_action_strength("steer_left")
	rotate_input -= Input.get_action_strength("steer_right")
	rotate_input *= deg2rad(steering)
	
	# rotate wheels for effect
	right_wheel.rotation.y = rotate_input
	left_wheel.rotation.y = rotate_input

	# smoke?
	var d = ball.linear_velocity.normalized().dot(-car_mesh.transform.basis.z)
	if ball.linear_velocity.length() > 5.5 and d < 0.9:
		$CarMesh/Smoke.emitting = true
		$CarMesh/Smoke2.emitting = true
	else:
		$CarMesh/Smoke.emitting = false
		$CarMesh/Smoke2.emitting = false
		
	# rotate car mesh
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, rotate_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		
		# tilt body for effect
		var t = -rotate_input * ball.linear_velocity.length() / body_tilt
		body_mesh.rotation.z = lerp(body_mesh.rotation.z, t, 10 * delta)
		
	# align mesh with ground normal
	var n = ground_ray.get_collision_normal()
	var xform = align_with_y(car_mesh.global_transform, n.normalized())
	car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10 * delta)
	
func _physics_process(delta):
#	car_mesh.transform.origin = ball.transform.origin + sphere_offset
	# just lerp the y due to trimesh bouncing
	car_mesh.transform.origin.x = ball.transform.origin.x + sphere_offset.x
	car_mesh.transform.origin.z = ball.transform.origin.z + sphere_offset.z
	car_mesh.transform.origin.y = lerp(car_mesh.transform.origin.y, ball.transform.origin.y + sphere_offset.y, 10 * delta)
#	car_mesh.transform.origin = lerp(car_mesh.transform.origin, ball.transform.origin + sphere_offset, 0.3)
	ball.add_central_force(-car_mesh.global_transform.basis.z * speed_input)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func _input(event):
	if event.is_action_pressed("change_camera"):
		current_camera = wrapi(current_camera + 1, 0, num_cameras)
		emit_signal("change_camera", $CarMesh/CameraPositions.get_child(current_camera))
