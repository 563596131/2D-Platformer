extends Node
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.


# The "_" prefix is a convention to indicate that variables are private,
# that is to say, another node or script should not access them.
onready var _pause_menu = $InterfaceLayer/PauseMenu
func _ready():
	Communal.difficulty = Communal.difficulty

func _physics_process(delta):
	$InterfaceLayerInGame/Control/VBoxContainer/HeartsCounter2/Label.text = str(Communal.BulletPicked)
	$InterfaceLayerInGame/Control/VBoxContainer/HeartsCounter3/Label.text = str(Communal.EnemyPicked)
func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()


func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		# We need to clean up a little bit first to avoid Viewport errors.
		if name == "Splitscreen":
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()


func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
	elif event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().set_input_as_handled()

	elif event.is_action_pressed("splitscreen"):
		if name == "Splitscreen":
			# We need to clean up a little bit first to avoid Viewport errors.
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Game.tscn")
		else:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Splitscreen.tscn")
			
			
func _on_Player_collect_coin(fs):
	$InterfaceLayerInGame/Control/VBoxContainer/CoinsCounter/Label.text = str(int($InterfaceLayerInGame/Control/VBoxContainer/CoinsCounter/Label.text) + fs)
	
func _on_Player_collect_hp(hp):
	$InterfaceLayerInGame/Control/VBoxContainer/HeartsCounter/Label.text = str(hp)
	if hp < 1:
		get_tree().change_scene("res://Hongyi/Control.tscn")
func CoinCost(value):
	if int($InterfaceLayerInGame/Control/VBoxContainer/CoinsCounter/Label.text)-value >= 0:
		$InterfaceLayerInGame/Control/VBoxContainer/CoinsCounter/Label.text = str(int($InterfaceLayerInGame/Control/VBoxContainer/CoinsCounter/Label.text) - value)
		return true
	return false
func _on_Button_pressed():
	if CoinCost(1):
		Communal.BulletPicked += 1
	pass # Replace with function body.


func _on_Buttonhp_pressed():
	if CoinCost(5):
		$Level/Player.hp += 1
		$InterfaceLayerInGame/Control/VBoxContainer/HeartsCounter/Label.text = str($Level/Player.hp)
	pass # Replace with function body.


func _on_Buttongw_pressed():
	if CoinCost(10):
		Communal.EnemyPicked += 1
	pass # Replace with function body.

var edt = false
func _on_Buttonedt_pressed():
	if !edt:
		if CoinCost(5):
			$Level/Player.doubleJump = 2
			$Level/Player.doubleJump_max = 2
			edt = true
	pass # Replace with function body.


func _on_Buttoncc_pressed():
	if !$Level/Player.yxflash:
		if CoinCost(10):
			$Level/Player.yxflash = true
	pass # Replace with function body.


func _on_Buttonvq_pressed():
	if CoinCost(50):
		get_tree().change_scene("res://Control.tscn")
	pass # Replace with function body.


func _on_Buttonsj_pressed():
	if Communal.EnemyPicked - 3 >= 0:
		Communal.BulletNum += 1
		Communal.EnemyPicked -= 3
		print("aaaee")
		$InterfaceLayerInGame/Control/VBoxContainer/HeartsCounter3/Label.text = str(Communal.EnemyPicked)
	pass # Replace with function body.
