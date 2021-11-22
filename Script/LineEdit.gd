extends LineEdit

onready var glob_var = get_node("/root/GlobalVariables")

func _ready():
	grab_focus()
	set_cursor_position(len(text))
	select_all()


func _on_LineEdit_text_entered(username):
	var new_highscore = {username: glob_var.best_time}
	glob_var.save(new_highscore)
	glob_var.clear()
	get_tree().change_scene("res://Assets/Scenes/Menu/titleScreen.tscn")
