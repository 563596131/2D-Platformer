extends Node

#difficulty: true-difficult false-eazy
var difficulty = false setget difficultySet
var BulletPicked = 10
var EnemyPicked = 0 
var BulletNum = 1
 
func difficultySet(value):
	difficulty = value
	EnemyPicked = 0
	if value:
		BulletPicked = 0
	else:
		BulletPicked = 10
