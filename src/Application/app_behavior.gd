extends Node;
class_name AppBehavior


#---------------------------------
# * Controls the application main state machine behavior
#---------------------------------



# - - - - - - - - - -
# Holds a reference to the application state machine
# - - - - - - - - - -
var __app_machine : StateMachine = null;


# ###################################|
#                PUBLIC              |
# ###################################|


# - - - - - - - - - -
# Starts the app behavior state machine, restore state will be triggered
# - - - - - - - - - -
func start_machine():
	__app_machine.attendTransition('gotoRestoreState');


# - - - - - - - - - -
# Callback funtion to handles the intro state completed
# - - - - - - - - - -
func intro_completed():
	_validation_transition_scene();


func __after_to_menu_scene__():
	__app_machine.attendTransition('gotoMainMenu');



# ###################################|
#               PRIVATE              |
# ###################################|

# - - - - - - - - - -
# On enter tree Godot Api override
# - - - - - - - - - -
func _enter_tree():
	__app_machine = StateMachine.new(
		'AppMainMachine',
		AppTransitions.new().app_transitions
	);

	if(!__app_machine):
		Application.validate_operation(GameTypes.kERROR.ERR_UNAVAILABLE);
		return;

	Application.validate_operation(__app_machine.connect(
		'stateChanged', self, '__on_machine_changed__', [], CONNECT_DEFERRED
	));


# - - - - - - - - - -
# ! Current Mocked
# Loads a player state information
# Return (Reference): Loaded player object
# - - - - - - - - - -
func __load_player()-> Reference:
	Application.print_msg(
		GameTypes.kTYPES.APPLICATION,
		'Loading player state configuration ...'
	);

	var __inner_player = PlayerClass.PlayState.new('Player');
	return __inner_player;


# - - - - - - - - - -
# Validation funtion used to verify the state of the transition scene reference and the menu scene
# This will hold the state machine until all needed references are loaded
# Can be waited
# - - - - - - - - - -
func _validation_transition_scene():
	while(Application.scene_referencer().getLoadPercent('transition') != 1.0 ||\
			Application.scene_referencer().getLoadPercent('menu_scene') != 1.0):
		yield(get_tree(), 'idle_frame');

	var transition_scene = Application.scene_referencer().getLoadReference('transition');
	var main_menu_scene = Application.scene_referencer().getLoadReference('menu_scene');

	if(!transition_scene || !main_menu_scene):
		Application.print_msg(
			GameTypes.kTYPES.APPBEHAVIOR,
			'Transition reference or main menu invalid ... force quiting'
		);

		Application.validate_operation(GameTypes.kERROR.FAILED);

	get_tree().root.add_child(transition_scene);

	transition_scene.setUp(
		get_tree().get_current_scene(),
		main_menu_scene,
		funcref(self, '__after_to_menu_scene__')
	);

	transition_scene.trigger_transition();


# - - - - - - - - - -
# Callback funtion for the application state switch
# @new_state (int): New state enum value
# - - - - - - - - - -
func __on_machine_changed__(new_state : int):
	match new_state:
		# - - - - - - - - - -
		# On change to RESTORE
		GameStates.kAPPSTATES.RESTORE:
			Application.set_player(__load_player());

			var _requested_thread = Application.request_incubate_thread('transition_load');
			_requested_thread.define_thread_action(
				TaskTypes, 'load_transition_scene', _requested_thread
			);
			_requested_thread.start_task();

			__app_machine.attendTransition('gotoIntroScene');


		# - - - - - - - - - -
		# On change to INTRO
		GameStates.kAPPSTATES.INTRO:
			Application.main_node.start_animation();


		# - - - - - - - - - -
		# On change to MAINMENU
		GameStates.kAPPSTATES.MAIN_MENU:
			pass;
