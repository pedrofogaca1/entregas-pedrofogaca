extends Node

signal start_game
var time_left = 10
var playing = false

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)
	
func update_timer(value):
	$MarginContainer/TimerLabel.text = str(value)



	
func show_message(text):
	$hud/MessageLabel.text = text
	$hud/MessageLabel.show()
	$hud/MessageTimer.start()

	

func _on_game_timer_timeout() -> void:
	time_left -= 1
	$".".update_timer(time_left)
	if time_left <= 0:
		$"..".game_over()
	$MessageLabel.hide()

func _on_start_pressed() -> void:
	$MessageLabel.hide()
	$Start.hide()
	emit_signal("start_game")
	
func show_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	
	$Start.show()
	$MessageLabel.text = "Coin Dash!!"
	$MessageLabel.show()
