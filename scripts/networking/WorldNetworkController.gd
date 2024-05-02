extends Node

var Player = preload ("res://scenes/development/prototype_character.tscn")
# Called when the node enters the scene tree for the first time.
var activePlayers = {}

func _ready():
	for p in MatchMaker.players:
		var obj = Player.instance()
		activePlayers[p.session_id] = obj
	MatchMaker.player_joined.connect(on_player_join)
	
func on_player_leave(p):
	if activePlayers.has(p.session_id):
		activePlayers[p.session_id].queue_free()
		activePlayers.erase(p.session_id)

func on_player_join(p):
	if not activePlayers.has(p.session_id):
		var obj = Player.instance()
		activePlayers[p.session_id] = obj
