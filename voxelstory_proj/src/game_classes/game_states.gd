# --------------------------------------------------------------
#                                                              |
#  * Script holding the available game states                  |
#                                                              |
# -------------------------------------------------------------|

class_name GameStates


# - - - - - - - - - -
# Holds a referece for the core application states
# - - - - - - - - - -
enum kAPPSTATES {
	ANY,
	# Restoring the game state, used on startup
	RESTORE,
	
	# Application boot
	INTRO,
	MAIN_MENU,

	# Local multiplayer server
	CREATING_SERVER

	# Multiplayer Connections
	CONNECTING_TO_SERVER
};