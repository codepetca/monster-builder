class_name MultiplayerScreen
extends Screen


@onready var label = $UI/Options/Label
@onready var remote = $UI/Options/Remote
@onready var host_button = $UI/Options/HBoxContainer/HostButton
@onready var join_button = $UI/Options/HBoxContainer/JoinButton

const PORT = 4433


func _ready():
	# Start paused.
	#	get_tree().paused = true
	# You can save bandwidth by disabling server relay and peer notifications.
	multiplayer.server_relay = false

	# Automatically start the server in headless mode.
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_button_pressed.call_deferred()
	
	multiplayer.peer_connected.connect(_on_peer_connected)


func _on_host_button_pressed():
	# Start as server.
	print("hosting")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	start()


func _on_join_button_pressed():
	print("joining")
	# Start as client.
	var txt : String = remote.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start()


func start():
	hide()

	Signals.start_game.emit()
#	get_tree().paused = false


func _on_peer_connected(id: int):
	print(id)
	Signals.set_portal_peer.emit(id)


func _on_button_pressed():
	Signals.pop_screen.emit()
	queue_free()
