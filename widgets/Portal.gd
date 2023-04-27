extends Node


var portal_peer := 1


func _ready():
	Signals.set_portal_peer.connect(_on_set_portal_peer)


func _on_set_portal_peer(id: int):
	portal_peer = id


func send(costume_json: String):
	receive.rpc_id(portal_peer, costume_json)


@rpc("any_peer", "call_local")
func receive(costume_json: String):
	print("received from: " + str(multiplayer.get_remote_sender_id()) + ": " + costume_json)
	Signals.portal_spawn.emit(costume_json)
