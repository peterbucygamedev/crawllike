extends Control
@onready var button = $Button
@onready var button_2 = $Button2
const GAME = preload("res://scenes/game.tscn")
# Called when the node enters the scene tree for the first time.


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_2_pressed():
	get_tree().quit()
