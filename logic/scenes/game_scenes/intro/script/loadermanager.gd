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
#               PUBLIC              #
# ###################################


# - - - - - - - - - -
# Starts the intro animation, and holds until animation completed
# - - - - - - - - - -
func start_animation():
	_components.main_player.play();
	yield(_components.main_player, "animation_finished");
	Application.app_behavior.intro_completed();



# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# Entre tree Godot Api overload
# - - - - - - - - - -
func _enter_tree():
	Application.main_node = self;


# - - - - - - - - - -
# On ready call
# - - - - - - - - - -
func _ready():
	__reset_animators();

	var __created_thread = Application.request_incubate_thread('main_menu_load');
	__created_thread.define_thread_action(TaskTypes, 'load_menu_scene', __created_thread);

	__created_thread.start_task();

	Application.print_msg(
		GameTypes.kTYPES.LOADMANAGER, 'Requesting a load main menu scene on a thread'
	);


# - - - - - - - - - -
# Resets the scene players
# - - - - - - - - - -
func __reset_animators():
	_components.logo_player.set_assigned_animation('slide_in');
	_components.logo_player.seek(0.0, true);
	_components.main_player.set_assigned_animation('game_intro');
	_components.main_player.seek(0.0, true);
