extends KinematicBody2D

export var ACCELERATION = 1000
export var MAX_SPEED = 400
export var FRICTION = 300
var velocity = Vector2.ZERO
var gun_knockback = 30

const BULLET = preload("res://Scenes/Bullet.tscn")
var can_fire = true

func _ready():
	$GunFireEffect.hide()

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()
		#Knockback:
		var diff = (global_position - get_global_mouse_position()).normalized() * gun_knockback
		velocity = move_and_slide(velocity + diff)
		
	if input_vector == Vector2(0,0):
		$Rocket.hide()
	else:
		$AnimationPlayer2.play("rocket")
	
	if Input.is_action_just_pressed("dash"):
		dash()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)

func shoot():
	$AnimationPlayer.play("GunFireEffect")
	$AudioStreamPlayer.play()
	$Crosshair/AnimationPlayer.play("shoot_animation")
	$MainCamera.shake(300, 0.4, 300)
	for i in range(3):
		var bullet = BULLET.instance()
		bullet.position = $Gun1.get_global_position()
		bullet.rotation = rotation
		get_tree().root.add_child(bullet)
	can_fire = false
	yield(get_tree().create_timer(0.09), "timeout")
	can_fire = true

func dash():
	MAX_SPEED = MAX_SPEED #work in progress, multiply for dash
	ACCELERATION = ACCELERATION
	$DashCoolDown.start()


func _on_DashCoolDown_timeout():
	MAX_SPEED = 400
	ACCELERATION = 800

