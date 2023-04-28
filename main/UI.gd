class_name UI
extends CanvasLayer


func clear():
	for child in get_children():
		remove_child(child)
		child.queue_free()
