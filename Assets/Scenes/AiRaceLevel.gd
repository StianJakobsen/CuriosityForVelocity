extends Spatial

func get_path_direction(position):
	var offset = $AiTrack.curve.get_closest_offset(position)
	$AiTrack/PathFollow.offset = offset
	return $AiTrack/PathFollow.transform.basis.z
