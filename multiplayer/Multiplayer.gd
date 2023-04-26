extends Screen


@onready var ui = $UI
@onready var label = $UI/Options/Label
@onready var host_button = $UI/Options/HostButton
@onready var join_button = $UI/Options/JoinButton
@onready var remote = $UI/Options/Remote

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


func _on_host_button_pressed():
	# Start as server.
	print("hosting")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(func(x): print(x))
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
	multiplayer.peer_connected.connect(func(x): print(x))
	start()


func start():
	ui.hide()
	Signals.start_game.emit()
	get_tree().paused = false
