extends Node

class_name ClientNetworkHandler

var nakama_server_key: String = 'defaultkey'
var nakama_host: String = 'localhost'
var nakama_port: int = 7350
var nakama_scheme: String = 'http'

var nakama_client: NakamaClient
var nakama_socket: NakamaSocket
var nakama_session: NakamaSession

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nakama_client = Nakama.create_client(nakama_server_key, nakama_host, nakama_port, nakama_scheme)
	nakama_client.timeout = 20
	
func connect_to_server():
	
	nakama_socket = Nakama.create_socket_from(nakama_client)
	
	if (nakama_session == null):
		printerr("No session found")
		return
	var connected: NakamaAsyncResult = await nakama_socket.connect_async(nakama_session)

	if (connected.is_exception()):
		printerr("An error occurred: %s" % connected)
		return
	print("Socket Connected")
	get_tree().change_scene_to_file("res://scenes/lobby.tscn")
