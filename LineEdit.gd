extends LineEdit

onready var track_var = get_node("/root/TrackVariables")

func _ready():
	grab_focus()
	set_cursor_position(len(text))
	select_all()


func _on_LineEdit_text_entered(username):
	var new_highscore = {username: track_var.best_time}
	track_var.save(new_highscore)
	track_var.clear()
	get_tree().change_scene("res://Assets/Scenes/Menu/titleScreen.tscn")
