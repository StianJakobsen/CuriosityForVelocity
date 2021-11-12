tool
extends Path

export var track_width = 8.0 setget set_track_width, get_track_width
export var ground_width = 12.0 setget set_ground_width, get_ground_width
export var distance_to_rail = 1.0 setget set_distance_to_rail, get_distance_to_rail
export var post_distance = 1.0 setget set_post_distance, get_post_distance

var change_track = true

func set_track_width(new_width):
	if track_width != new_width:
		track_width = new_width
		change_track = true
		call_deferred("_update")

func get_track_width():
	return track_width

func set_ground_width(new_width):
	if ground_width != new_width:
		ground_width = new_width
		change_track = true
		call_deferred("_update")

func get_ground_width():
	return ground_width

func set_distance_to_rail(new_dist):
	if distance_to_rail != new_dist:
		distance_to_rail = new_dist
		change_track = true
		call_deferred("_update")

func get_distance_to_rail():
	return distance_to_rail

func set_post_distance(new_dist):
	if post_distance != new_dist:
		post_distance = new_dist
		change_track = true
		call_deferred("_update")

func get_post_distance():
	return post_distance

func _update():
	if !change_track:
		return
	
	# Find track distance
	var curve_length = curve.get_baked_length()
	
	###################################################################################
	# update track
	var half_track_width = track_width * 1/2
	var half_ground_width = ground_width * 1/2
	
	var track = $Road.polygon
	track.set(0, Vector2(-half_track_width-distance_to_rail, 0.0))
	track.set(1, Vector2(-half_track_width-distance_to_rail, -0.1))
	track.set(2, Vector2( half_track_width+distance_to_rail, -0.1))
	track.set(3, Vector2( half_track_width+distance_to_rail, 0.0))
	$Road.polygon = track
	$Road.path_joined = true
	$Road.invert_faces = true
	
	var ground = $Ground.polygon
	ground.set(1, Vector2( half_track_width + distance_to_rail, -0.1))
	ground.set(0, Vector2(-half_track_width - distance_to_rail, -0.1))
	ground.set(2, Vector2( ground_width, -8.01))
	ground.set(3, Vector2( ground_width + 0.1, -8.1))
	if ground.size()==6:
		ground.set(4, Vector2(-ground_width - 0.1, -8.1))
		ground.set(5, Vector2(-ground_width, -8.0))
	else:
		ground.append(Vector2(-ground_width - 0.1, -8.1))
		ground.append(Vector2(-ground_width, -8.0))
	$Ground.polygon = ground
	$Ground.invert_faces = true
	$Ground.path_joined = true
	
	###################################################################################
	# update our rails
	var rail_position = half_track_width + distance_to_rail
	
	var rail_left = $"Rail-Left".polygon
	rail_left.set(0, Vector2(rail_position, 0.5))
	rail_left.set(1, Vector2(rail_position - 0.05, 0.47))
	rail_left.set(2, Vector2(rail_position - 0.05, 0.43))
	rail_left.set(3, Vector2(rail_position, 0.4))
	if rail_left.size() == 10:
		rail_left.set(4, Vector2(rail_position, 0.55))
		rail_left.set(5, Vector2(rail_position - 0.05, 0.32))
		rail_left.set(6, Vector2(rail_position - 0.05, 0.28))
		rail_left.set(7, Vector2(rail_position, 0.25))
		rail_left.set(8, Vector2(rail_position + 0.05, 0.25))
		rail_left.set(9, Vector2(rail_position + 0.05, 0.5))
	else:
		rail_left.append(Vector2(rail_position, 0.55))
		rail_left.append(Vector2(rail_position - 0.05, 0.32))
		rail_left.append(Vector2(rail_position - 0.05, 0.28))
		rail_left.append(Vector2(rail_position, 0.25))
		rail_left.append(Vector2(rail_position + 0.05, 0.25))
		rail_left.append(Vector2(rail_position + 0.05, 0.5))
	$"Rail-Left".polygon = rail_left
	$"Rail-Left".path_joined = true
	$"Rail-Left".invert_faces = true
	
	var rail_right = $"Rail-Right".polygon
	rail_right.set(0, Vector2(-rail_position, 0.5))
	rail_right.set(1, Vector2(-rail_position + 0.05, 0.47))
	rail_right.set(2, Vector2(-rail_position + 0.05, 0.43))
	rail_right.set(3, Vector2(-rail_position, 0.4))
	if rail_right.size() == 10:
		rail_right.set(4, Vector2(-rail_position, 0.55))
		rail_right.set(5, Vector2(-rail_position + 0.05, 0.32))
		rail_right.set(6, Vector2(-rail_position + 0.05, 0.28))
		rail_right.set(7, Vector2(-rail_position, 0.25))
		rail_right.set(8, Vector2(-rail_position - 0.05, 0.25))
		rail_right.set(9, Vector2(-rail_position - 0.05, 0.5))
	else:
		rail_right.append(Vector2(-rail_position, 0.55))
		rail_right.append(Vector2(-rail_position + 0.05, 0.32))
		rail_right.append(Vector2(-rail_position + 0.05, 0.28))
		rail_right.append(Vector2(-rail_position, 0.25))
		rail_right.append(Vector2(-rail_position - 0.05, 0.25))
		rail_right.append(Vector2(-rail_position - 0.05, 0.5))
	$"Rail-Right".polygon = rail_right
	$"Rail-Right".path_joined = true
	$"Rail-Right".invert_faces = true
	
	###################################################################################
	# update our posts
	var post_count = floor(curve_length / post_distance)
	var real_post_dist = curve_length / post_count
	
	$Posts.multimesh.instance_count = post_count * 2
	
	# Place posts on each side of road with post_distance between them
	for i in range(0, post_count):
		var t = Transform()
		var xf = Transform()
		var f = i * real_post_dist
		
		xf.origin = curve.interpolate_baked(f)
		var lookat = (curve.interpolate_baked(f + 0.1) - xf.origin).normalized()
		
		var up = Vector3(0.0, 1.0, 0.0)
		xf.basis.z = lookat
		xf.basis.x = lookat.cross(up).normalized()
		xf.basis.y = xf.basis.x.cross(lookat).normalized()
		
		var v = Vector3(rail_position, 0.0, 0.0)
		
		t.basis = Basis()
		t.origin = xf.xform(-v)
		$Posts.multimesh.set_instance_transform(i, t)
		
		t.basis = Basis()
		t.origin = xf.xform(v)
		$Posts.multimesh.set_instance_transform(post_count + i, t)
	
	###################################################################################
	# update our collision
	
	var collision = $CollisionShape.polygon
	
	collision.set(0, Vector2(-rail_position, 0.0))
	collision.set(1, Vector2( rail_position, 0.0))
	collision.set(2, Vector2( rail_position, 3.0))
	collision.set(3, Vector2( rail_position + 3.0, 3.0))
	if collision.size() == 8:
		collision.set(4, Vector2(rail_position + 3.0, -1.0))
		collision.set(5, Vector2(-rail_position - 3.0, -1.0))
		collision.set(6, Vector2(-rail_position - 3.0, 3.0))
		collision.set(7, Vector2(-rail_position, 3.0))
	else:
		collision.append(Vector2( rail_position + 3.0, -1.0))
		collision.append(Vector2(-rail_position - 3.0, -1.0))
		collision.append(Vector2(-rail_position - 3.0, 3.0))
		collision.append(Vector2(-rail_position, 3.0))

	$CollisionShape.polygon=collision
	$CollisionShape.smooth_faces = true
	$CollisionShape.path_joined = true
	$CollisionShape.invert_faces = true
	$CollisionShape.use_collision = true
	
	change_track = false

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_update")

func _on_Path_curve_changed():
	change_track = true
	call_deferred("_update")


func _on_SnowTrack_curve_changed():
	call_deferred('_update')


func _on_DessertTrack_curve_changed():
	call_deferred('_update')
