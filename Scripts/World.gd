extends Node2D

const TRASH = preload("res://Scenes/GarbageBag.tscn")

func _ready():
	randomize()
	$ParallaxBackground/ParallaxLayer/Ocean1.show()
	$ParallaxBackground/ParallaxLayer2/Midground.show()

func _on_SpawnTimer_timeout():
	var trash = TRASH.instance()
	trash.global_position = Vector2(rand_range(-5020, 5615), rand_range(-4055, 4357))
	add_child(trash)
