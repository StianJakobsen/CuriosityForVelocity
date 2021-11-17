extends Area

var lap = 1
var sector1 = false
var sector2 = false


func _on_GoalLine_body_entered(body):
	if body.is_in_group('RaceCar'):
		if sector1 and sector2:
			lap += 1
			sector1 = false
			sector2 = false
			print('You are on lap ' + lap)
		else:
			print('You have to cross sector 1 and 2')
		


func _on_Sector1_body_entered(body):
	if body.is_in_group('RaceCar'):
		sector1 = true
		print('Sector 1 is entered')


func _on_Sector2_body_entered(body):
	if body.is_in_group('RaceCar'):
		sector2 = true
		print('Sector 2 is eneterd')
		print(sector1)
