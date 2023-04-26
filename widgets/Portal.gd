extends Node


var to_id := 1


func send(costume_id: String):
	receive.rpc_id(1, var_to_str(costume_id))


@rpc("any_peer", "call_local")
func receive(costume_id: String):
	print("received from: " + str(multiplayer.get_remote_sender_id()))
	print(costume_id)
