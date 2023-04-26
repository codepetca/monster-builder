extends Node


var portal_peer := 1


func _ready():
	Signals.set_portal_peer.connect(_on_set_portal_peer)


func _on_set_portal_peer(id: int):
	portal_peer = id


func send(costume_id: String):
	receive.rpc_id(portal_peer, costume_id)


@rpc("any_peer")
func receive(costume_id: String):
	if not multiplayer.get_remote_sender_id() == multiplayer.get_unique_id():
		print("received from: " + str(multiplayer.get_remote_sender_id()) + ": " + costume_id)
