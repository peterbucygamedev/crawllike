extends CharacterBody2D
@onready var healthBar = $Health
@onready var attack_area = $attackArea
@onready var animated_sprite = $AnimatedSprite2D
@onready var swingTimer = $swingTimer
@onready var dashTimer = $dashTimer

var speed = 200  # Adjust speed as needed
var timerNumber = 0.1
var nextAnimation = true
var swing2 = false
var health = 100
var isColliding = false
var inAttackArea = false
var stalker = null
var stalkers = []

func _ready():
	animated_sprite.play("idle")
	var swingTimer = get_node("swingTimer")
	var dashTimer = get_node("dashTimer")
	swingTimer.timeout.connect(_on_swingTimer_timeout)
	dashTimer.timeout.connect(_on_dashTimer_timeout)
	
func _physics_process(delta):
	#print(stalkers)
	#print(health)
	if health <= 0:
		#print("you died")
		pass
		
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
		
	#if inAttackArea == true and animated_sprite.is_playing:
		#stalker.health -= 0.1
		
		
	#print(nextAnimation)
	var hDirection = Input.get_axis("move_left", "move_right") 
	var vDirection = Input.get_axis("move_up", "move_down")
	
	for bodies in stalkers:
		if bodies.health <= 0:
			stalkers.erase(bodies)
			
	if Input.is_action_just_pressed("swing"):
		swingTimer.start()
		nextAnimation = false
		animated_sprite.play("downswing")
			
		#if swing2 == false:
			#animated_sprite.play("upswing")
			
		#if swing2 == true:
			#animated_sprite.play("downswing")
			
		if inAttackArea and stalkers != null:
			for bodies in stalkers:
				bodies.health -= 20
			
		swing2 = !swing2
	
		
	elif (hDirection != 0 or vDirection != 0) and nextAnimation == true:
		animated_sprite.play("run")		
	
	elif (hDirection == 0 and vDirection == 0) and nextAnimation == true:
		animated_sprite.play("idle")
		
		
	if Input.is_action_just_pressed("dash"):
		speed += 500
		if dashTimer.is_stopped():
			dashTimer.start()

	if hDirection > 0:
		animated_sprite.flip_h = false
		attack_area.position.x = -65

	if hDirection < 0:
		animated_sprite.flip_h = true
		attack_area.position.x = -75
		
	
	if hDirection:
		velocity.x = hDirection * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if vDirection:
		velocity.y = vDirection * speed
	else:
		velocity.y = move_toward(velocity.x, 0, speed)

	# Move the KinematicBody2D
	move_and_slide()

func _on_swingTimer_timeout():
	Engine.time_scale = 1
	nextAnimation = true
	
func _on_dashTimer_timeout():
	Engine.time_scale = 1
	speed = 200
	

func _on_attack_area_body_entered(body):
	#print("entered")
	if body.is_in_group("stalker"):
		stalkers.append(body)
		inAttackArea = true

func _on_attack_area_body_exited(body):
	#print("exited")
	if body.is_in_group("stalker"):
		stalkers.erase(body)
		inAttackArea = false


