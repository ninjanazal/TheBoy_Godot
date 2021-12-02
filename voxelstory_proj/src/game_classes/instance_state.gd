class_name PlayerClass

# --------------------------------------------------------------
#                                                              |
# *  Class holding all the player information                  |
#                                                              |
# -------------------------------------------------------------|
class PlayState:
	# - - - - - - - - - -
	# Holds the player Name
	# - - - - - - - - - -
	var name : String = '';


	# ###################################
	#               PUBLIC              #
	# ###################################


	# - - - - - - - - - -
	# Class Constructor
	# @name (String): player name string
	# - - - - - - - - - -

	func _init(name : String):
		self.name = name;
