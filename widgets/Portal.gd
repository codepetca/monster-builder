extends Node


var to_id := 1


func send(mob: Monster):
	receive.rpc_id(to_id, mob)


@rpc("any_peer", "call_local")
func receive(mob: Monster):
	print("received " + mob.to_string())
