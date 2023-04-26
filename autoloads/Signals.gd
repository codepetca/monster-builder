extends Node

# Network
signal set_portal_peer(peer: int)

# HUD
signal score_updated(score: int)

# UI signals
signal start_game
signal pop_screen
signal push_screen(screen: Screen)

