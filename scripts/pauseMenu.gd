extends Control
@onready var resume = $Resume
@onready var exit = $Exit
@onready var menu = $Menu


# Called when the node enters the scene tree for the first time.
func _ready():
	resume.hide()
	exit.hide()


func _on_menu_pressed():
	get_tree().paused = true
	resume.show()
	exit.show()
	
func _on_resume_pressed():
	resume.hide()
	exit.hide()
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().quit()
