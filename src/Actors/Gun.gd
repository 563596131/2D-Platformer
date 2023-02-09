class_name Gun
extends Position2D
# Represents a weapon that spawns and shoots bullets.
# The Cooldown timer controls the cooldown duration between shots.


const BULLET_VELOCITY = 500.0
const Bullet = preload("res://src/Objects/Bullet.tscn")

onready var sound_shoot = $Shoot
onready var timer = $Cooldown


# This method is only called by Player.gd.
func shoot(direction = 1):
	if Communal.BulletPicked> 0:
		Communal.BulletPicked -=1
		if not timer.is_stopped():
			return false
		for i in Communal.BulletNum:
			var bullet = Bullet.instance()
			bullet.global_position = global_position
			bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0)

			bullet.set_as_toplevel(true)
			add_child(bullet)
			yield(get_tree().create_timer(0.1),"timeout")
		sound_shoot.play()
		timer.start()
		return true
