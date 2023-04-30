extends Node

# Network
signal set_portal_peer(peer: int)
signal portal_spawn(costume_id: String)

# HUD
signal score_updated(score: int)
signal score_increased_by(amount: int)
signal time_updated(time: int)
signal target_updated(costume: Costume)

# UI signals
signal start_game
signal pop_screen
signal push_screen(screen: Screen)

# Game
signal pickable_dropped(object: Pickable)
signal level_complete(score: int)
