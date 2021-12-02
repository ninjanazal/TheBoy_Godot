extends Node;

# --------------------------------------------------------------
#                                                              |
#  * Script manages the load process                           |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Onready var holding the main components
# - - - - - - - - - -
onready var _components : Dictionary = {
	'logo_player' : get_node('visuals/godot_logo/AnimationPlayer'),
	'main_player' : get_node('anim_intro')
};


# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# On ready call
# - - - - - - - - - -
func _ready():
	__reset_animators();
	_components.main_player.play();



# - - - - - - - - - -
# Resets the scene players
# - - - - - - - - - -
func __reset_animators():
	_components.logo_player.set_assigned_animation('slide_in');
	_components.logo_player.seek(0.0, true);
	_components.main_player.set_assigned_animation('game_intro');
	_components.main_player.seek(0.0, true);
