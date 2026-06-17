extends Node

@export var coin_scene : PackedScene
@export var playtime = 30

var level = 1
var score = 0
var time_left = 0
var screensize = Vector2.ZERO
var playing = false


func _process(delta):
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()

func _ready():
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	
	#$Player.hide()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start()
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$hud.update_score(0)
	$hud.update_timer(0)
	
func spawn_coins():
	for i in level + 4:
		var c = coin_scene.instantiate()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))


func _on_player_hurt() -> void:
	game_over()
	

func game_over():
	playing = false
	$GameTimer.stop()

	for coin in $CoinContainer.get_children():
		coin.queue_free()

	$hud.show_game_over()
