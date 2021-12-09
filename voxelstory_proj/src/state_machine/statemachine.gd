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
# Function used to request a machine state switch based on a transition name
# @transition_name (String): Target transition name
# - - - - - - - - - -
func attendTransition(transition_name : String):
	if(__transition_stack__.keys().has(transition_name)):
		if(__transition_stack__[transition_name].verifyFromState(_current_state)):
			_last_state = _current_state;
			_current_state = __transition_stack__[transition_name].getToState();

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
