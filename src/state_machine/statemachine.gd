extends Node;
class_name StateMachine

# - - - - - - - - - -
# * State Machine voxelGame implementation
# - - - - - - - - - -


# - - - - - - - - - -
# Signal used to inform that the machine has switched states
# - - - - - - - - - -
signal stateChanged(new_state);


# - - - - - - - - - -
# Holds the machine name
# - - - - - - - - - -
var __machine_name__ : String = '';


# - - - - - - - - - -
# Holds an dictionary with the available transition for this machine
# - - - - - - - - - -
var __transition_stack__ : Dictionary;


# - - - - - - - - - -
# Holds a reference to the current machine state
# - - - - - - - - - -
var _current_state : int = 0;


# - - - - - - - - - -
# Holds a reference to the last machine state
# - - - - - - - - - -
var _last_state : int = 0;

# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Forces the current state, this will trigger the stateChanged signal
# @target_state (int): Target state enum value
# - - - - - - - - - -
func define_state(target_state : int):
	_last_state = _current_state;
	_current_state = target_state;

	emit_signal('stateChanged', _current_state);


# - - - - - - - - - -
# Evaluates if a defined transition is valid for the current state
# @transition_name (String): Transition name to be checked
# Return (bool): True/False if is a valid transition for the current state
# - - - - - - - - - -
func evaluate_state(transition_name : String)-> bool:
	if(__transition_stack__.keys().has(transition_name)):
		return __transition_stack__[transition_name].verifyFromState(_current_state);
	return false;


# - - - - - - - - - -
# Function used to request a machine state switch based on a transition name
# @transition_name (String): Target transition name
# - - - - - - - - - -
func attendTransition(transition_name : String):
	if(__transition_stack__.keys().has(transition_name)):
		Application.print_msg(
			GameTypes.kTYPES.FSMACHINE,
			'Requested a valid transition named ( %s )' % transition_name
		);

		if(__transition_stack__[transition_name].verifyFromState(_current_state)):
			_last_state = _current_state;
			_current_state = __transition_stack__[transition_name].getToState();

			Application.print_msg(
				GameTypes.kTYPES.FSMACHINE,
				'Changing machine state from ( %s ) to ( %s )' % [
					GameStates.kAPPSTATES.keys()[_last_state],
					GameStates.kAPPSTATES.keys()[_current_state]
				]
			);
			
			emit_signal('stateChanged', _current_state);


# ###################################
#               PRIVATE             #
# ###################################

# - - - - - - - - - -
# State Machine constructor
# - - - - - - - - - -
func _init(name : String, transitions : Dictionary):
	self.__machine_name__ = name;
	self.__transition_stack__ = transitions;
