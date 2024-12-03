extends Control




var Input_Mode = ""


func _ready():
	check_connected_controllers()


func _process(delta):
	check_connected_controllers()
	if Input_Mode == "Steam_Deck":
		$Failure.hide()
		$Playstation.hide()
		$Xbox.hide()
		$Other.hide()
		$SteamOther.hide()
		$SteamDeck.show()
	elif Input_Mode == "Steam_Other":
		$Failure.hide()
		$Playstation.hide()
		$Xbox.hide()
		$Other.hide()
		$SteamDeck.hide()
		$SteamOther.show()
	elif Input_Mode == "Playstation":
		$Failure.hide()
		$SteamDeck.hide()
		$Xbox.hide()
		$Other.hide()
		$SteamOther.hide()
		$Playstation.show()
	elif Input_Mode == "Xbox":
		$Failure.hide()
		$SteamDeck.hide()
		$Playstation.hide()
		$Other.hide()
		$SteamOther.hide()
		$Xbox.show()
	elif Input_Mode == "":
		$SteamDeck.hide()
		$Playstation.hide()
		$Xbox.hide()
		$Other.hide()
		$SteamOther.hide()
		$Failure.show()
	else:
		$SteamDeck.hide()
		$Playstation.hide()
		$Xbox.hide()
		$Failure.hide()
		$SteamOther.hide()
		$Other.show()


func check_connected_controllers():
	var joypads = Input.get_connected_joypads()
	if joypads.size() ==0:
		Input_Mode = ""
		print("No controllers detected")
	else:
		for joypad in joypads:
			var joy_name = Input.get_joy_name(joypad).to_lower()
			
			if joy_name.find("steam virtual") != -1:
				Input_Mode = "Steam_Deck"
				print("Player is using a Steam Deck.")
				$SteamDeck/InputIdentity.text = ("Controller Name: %s" % joy_name)
			elif joy_name.find("steam") != -1:
				Input_Mode = "Steam_Other"
				print("Player is using a Steam controller.")
				$SteamOther/InputIdentity.text = ("Controller Name: %s" % joy_name)
			elif joy_name.find("ps5 controller") != -1 or joy_name.find("playstation") != -1 or joy_name.find("dualshock") != -1 or joy_name.find("dualsense") != -1 or joy_name.find("ps4") != -1 or joy_name.find("ps3") != -1 or joy_name.find("ps2") != -1 or joy_name.find("ps1") != -1 or joy_name.find("psx") != -1:
				Input_Mode = "Playstation"
				print("Player is using a Playstation controller.")
				$Playstation/InputIdentity.text = ("Controller Name: %s" % joy_name)
			elif joy_name.find("xbox") != -1 or joy_name.find("xinput") != -1 or joy_name.find("x-box") != -1:
				Input_Mode = "Xbox"
				print("Player is using an Xbox controller.")
				$Xbox/InputIdentity.text = ("Controller Name: %s" % joy_name)
			else:
				Input_Mode = "Other"
				print("Player is using a different controller: %s" % joy_name)
				$Other/InputIdentity.text = ("Controller Name: %s" % joy_name)
	
	print("Input Mode: %s" % Input_Mode)
