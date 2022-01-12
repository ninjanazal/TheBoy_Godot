extends Node;

# --------------------------------------------------------------
#                                                              |
#  * Script manages main menu state                            |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Onready var holding the main components
# - - - - - - - - - -
onready var _components : Dictionary = {};


# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# Entre tree Godot Api overload
# - - - - - - - - - -
func _enter_tree():
	Application.main_node = self;