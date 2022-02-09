extends Node;

# --------------------------------------------------------------
#                                                              |
#  * Script manages main menu state                            |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Onready var holding the main components
# - - - - - - - - - -
onready var _components : Dictionary = {
	'find_btn' : get_node('front_layer/menu_main/menu_background/VBoxContainer/match_container/btn_find'),
	'host_btn' : get_node('front_layer/menu_main/menu_background/VBoxContainer/match_container/btn_host'),
	'settings_btn' : get_node('front_layer/menu_main/menu_background/VBoxContainer/btn_settings')
};


# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# Entre tree Godot Api overload
# - - - - - - - - - -
func _enter_tree():
	Application.main_node = self;
	#print(str('this is a test value'.to_ascii()));
