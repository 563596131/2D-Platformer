extends Control

func _ready():
	pass # Replace with function body.

func _on_Button3_pressed():
	Communal.difficulty = !Communal.difficulty
	$AnimatedSprite.visible = Communal.difficulty


func _on_Button2_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://src/Main/Game.tscn")
	pass # Replace with function body.
