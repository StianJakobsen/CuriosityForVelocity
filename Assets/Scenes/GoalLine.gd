extends Area

var laps = 0



func _on_GoalLine_body_entered(body):
	if body.is_in_group('RaceCar'):
		laps += 1
		print('Driven')
