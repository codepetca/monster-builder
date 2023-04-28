extends Node

# Network
signal set_portal_peer(peer: int)
signal portal_spawn(costume_id: String)

# HUD
signal score_updated(score: int)
signal time_updated(time: int)

# UI signals
signal start_game
signal pop_screen
signal push_screen(screen: Screen)

