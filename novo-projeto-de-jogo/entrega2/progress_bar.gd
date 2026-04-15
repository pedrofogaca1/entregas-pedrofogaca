extends Control

var nivel = 1
var xp = 0
func _on_timer_timeout() -> void:
	xp += 1
	$TextureProgressBar.value = xp
	
	$ProgressBar.value = xp
	

func _on_texture_progress_bar_value_changed(value: float) -> void:
	if xp >= $TextureProgressBar.max_value:
		xp = 0
		$TextureProgressBar.max_value = $TextureProgressBar.max_value * 1.1
		nivel +=1
		$Label.text = str(nivel)
	
