extends RigidBody2D

onready var sprites = [$Apple, $SodaCan]
var sprite

func _ready():
	sprite = sprites[randi() % sprites.size()]
	sprite.show()
	
func _physics_process(delta):
	apply_impulse(Vector2(), Vector2(10, 0).rotated(rotation))
	sprite.rotation_degrees += 15


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	pass
