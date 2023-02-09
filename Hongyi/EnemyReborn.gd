extends Position2D

var enemy = null

func _ready():
	enemy = load("res://src/Actors/Enemy.tscn").instance()
	enemy.connect("collect_destroy",self,"collect_destroy")
	add_child(enemy)

func collect_destroy():
	$Timer.start(10)
	enemy = null

func _on_Timer_timeout():
	if enemy == null:
		enemy = load("res://src/Actors/Enemy.tscn").instance()
		enemy.connect("collect_destroy",self,"collect_destroy")
		add_child(enemy)
