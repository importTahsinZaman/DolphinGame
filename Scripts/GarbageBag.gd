extends KinematicBody2D

const BULLET = preload("res://Scenes/Trash.tscn")
onready var player = get_parent().get_node("Shark")

var speed = 30
var velocity = Vector2.ZERO

const MAX_ATTACKS = 24
var attacks = 0


func _process(delta):
	rotation_degrees += 5
	velocity = Vector2.ZERO
	velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	if $VisibilityNotifier2D.is_on_screen():
		var explode_chance = rand_range(0, 5)
		if explode_chance <= 3:
			set_process(false)
			$AttackRate.start()


func _on_AttackRate_timeout():
	if attacks >= MAX_ATTACKS:
		queue_free()
	else:
		attacks += 1
		rotation_degrees += 15
		var bullet = BULLET.instance()
		bullet.position = $Position2D.get_global_position()
		bullet.rotation = rotation
		get_tree().root.add_child(bullet)
		
	


func _on_LifeTimer_timeout():
	queue_free()
