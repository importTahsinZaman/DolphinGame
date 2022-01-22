extends RigidBody2D


func _physics_process(delta):
	apply_impulse(Vector2(), Vector2(200, rand_range(-50, 50)).rotated(rotation))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	pass
