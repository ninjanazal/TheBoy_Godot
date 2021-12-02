extends Node;

# --------------------------------------------------------------
#                                                              |
# *  Script that manages the main aplication functionality     |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Holds an instance of the current playState informations
# - - - - - - - - - -
var __inner_player : PlayerClass.PlayState;


# - - - - - - - - - -
# Holds a reference to the created hosting threads
# - - - - - - - - - -
var __thread_incubator : Dictionary = {};


# ###################################|
#               PRIVATE              |
# ###################################|


# - - - - - - - - - -
# On ready call
# - - - - - - - - - -
func _ready():
	__load_player();


# - - - - - - - - - -
# ! Current Mocked
# Loads a player state information
# - - - - - - - - - -
func __load_player():
	_inner_player.new('Player');