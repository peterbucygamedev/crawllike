extends Area2D
@onready var animated_sprite = $AnimatedSprite2D
var inArea = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if inArea == true:
		if Input.is_action_pressed("left_click"):
			animated_sprite.play("move_left")
			#print("move_left")
		elif Input.is_action_pressed("right_click"):
			animated_sprite.play("move_right")
		#print("move_right")
		else:
			animated_sprite.play("default")




func _on_body_entered(body):
	inArea = true
	#print("bodyentered") # Replace with function body.


func _on_body_exited(body):
	inArea = false
	#print("bodyexited") # Replace with function body.
