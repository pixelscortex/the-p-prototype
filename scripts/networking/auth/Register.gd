extends Node

func _on_register_button_down():
	var email = $EmailText.text.strip_edges()
	var password = $PasswordText.text.strip_edges()
	var username = $UsernameText.text.strip_edges()
	
	var session = await GameNetworkHandler.nakama_client.authenticate_email_async(
		email, password, username, true
	)
	
	if session.is_exception():
		printerr("An error occurred: %s" % session)
		return
	print("Successfully authenticated: %s" % session)
	GameNetworkHandler.nakama_session = session
	
	GameNetworkHandler.connect_to_server()
