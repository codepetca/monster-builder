extends Screen


func _on_back_button_pressed():
	Signals.pop_screen.emit()
	queue_free()
