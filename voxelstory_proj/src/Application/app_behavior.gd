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
# Callback funtion for the application state switch
# @new_state (int): New state enum value
# - - - - - - - - - -
func __on_machine_changed__(new_state : int):
	match new_state:
		GameStates.kAPPSTATES.RESTORE:
			pass;