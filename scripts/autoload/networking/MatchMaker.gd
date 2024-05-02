extends Node

const FALLBACK_ROLE = "tank"

@onready var players = {}

signal player_joined
signal current_players(players)

func _ready():
	GameNetworkHandler.nakama_socket.received_matchmaker_matched.connect(self.on_matchmaker_matched)
	GameNetworkHandler.nakama_socket.received_match_presence.connect(self.on_match_presence)

func on_matchmaker_matched(p_matched: NakamaRTAPI.MatchmakerMatched):
	print("MatchMaker Trigger %s" % p_matched)
	#	var joined_match: NakamaRTAPI.Match =
	await GameNetworkHandler.nakama_socket.join_matched_async(p_matched)
	print("Match Joined %s" % p_matched)

func on_match_presence(p_presence: NakamaRTAPI.MatchPresenceEvent):
	print("Match Presence %s" % p_presence)
	for p in p_presence.joins:
		
		players[p.session_id] = {p: p}
		player_joined.emit(p)
	for p in p_presence.leaves:
		if p.session_id in players:
			players.erase(p.session_id)
	current_players.emit()
	print("Players %s" % players)
