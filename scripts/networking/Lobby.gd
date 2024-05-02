extends Node2D

func _on_map_1_button_down():
	var min_players: int = 2
	var max_players: int = 3
	await GameNetworkHandler.nakama_socket.add_matchmaker_async("*", min_players, max_players)
