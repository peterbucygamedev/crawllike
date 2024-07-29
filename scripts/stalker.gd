extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var deathTimer = $deathTimer
@onready var attackTimer = $attackTimer
@onready var healthBar = $Health
var player = null
var target = null
var health = 100
var speed = 20


# Called when the node enters the scene tree for the first time.

func _ready():
	animated_sprite.play("idle")
	deathTimer.timeout.connect(_on_deathTimer_timeout)
	attackTimer.timeout.connect(_on_attackTimer_timeout)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#print (dead)
	
	if health <= 0:
		#timerStalker.start()
		animated_sprite.play("death")
		if deathTimer.is_stopped():
			deathTimer.start()
		#print("you died")
		
	if health <= 10:
		healthBar.play("health 10")
		
		
	if health > 10 and health <= 20:
		healthBar.play("health 20")
		
	if health > 20 and health <= 30:
		healthBar.play("health 30")
		
	if health > 30 and health <= 40:
		healthBar.play("health 40")
		
	if health > 40 and health <= 50:
		healthBar.play("health 50")
		
	if health > 50 and health <= 60:
		healthBar.play("health 60")
		
	if health > 60 and health <= 70:
		healthBar.play("health 70")
		
	if health > 70 and health <= 80:
		healthBar.play("health 80")
		
	if health > 80 and health <= 90:
		healthBar.play("health 90")
		
	if health > 90 and health <= 100:
		healthBar.play("health 100")
	#print(health)
	
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed * delta)
		#print(velocity)
		
		animated_sprite.play("move")
		
		if velocity.x > 0:
			animated_sprite.flip_h = false

		if velocity.x < 0:
			animated_sprite.flip_h = true
	
		
	if health <= 0:
		#print("stalker is dead")
		pass


func _on_area_2d_body_entered(body):
	#print(body.name)
	if body.name == "player":
		target = body
		if health > 0:
			animated_sprite.play("attack")


func _on_area_2d_body_exited(body):
	if body.name == "player":
		target = null
	if health > 0:
		animated_sprite.play("idle")


func _on_attack_area_body_entered(body):
	if player == null and body.name == "player":
		attackTimer.start()
		player = body
		target = null
	
	if body.name == "player":
		if health > 0:
			animated_sprite.play("attack")
		
		
		#print("colliding")


func _on_attack_area_body_exited(body):
	if body.name == "player":
		attackTimer.stop()
		target = body
		player = null
	if player == null:
		if health > 0:
			animated_sprite.play("idle")
			
		
func _on_deathTimer_timeout():
	Engine.time_scale = 1
	if health <= 0:
		queue_free()
		
func _on_attackTimer_timeout():
	Engine.time_scale = 1
	if player != null:
		player.health -= 5
		
	
		
