extends Node2D

## Simulate mob leaving main room and changing and then returning

signal go_back(monster: Monster)


func _on_level_01_room_relocate(monster):
#	monster.reparent.call_deferred()
	print("relocated")
	monster.textures["body"] = G.all_textures["bodies"][randi_range(0,1)]#.pick_random()
	monster.textures["eye"] = G.all_textures["eyes"][randi_range(0,1)]#.pick_random()
	await get_tree().create_timer(1).timeout
	go_back.emit(monster)
	
	
