extends Node;
class_name StateMachine

# - - - - - - - - - -
# * State Machine voxelGame implementation
# - - - - - - - - - -

# - - - - - - - - - -
# Holds the machine name
# - - - - - - - - - -
var __machine_name__ : String = '';


# - - - - - - - - - -
# Holds an array with the available transition for this machine
# - - - - - - - - - -
var __transition_stack__ : Array;


# - - - - - - - - - -
# Holds a reference to the current machine state
# - - - - - - - - - -
var _current_state : int = 0;


# - - - - - - - - - -
# Holds a reference to the last machine state
# - - - - - - - - - -
var _last_state : int = 0;


# ###################################
#               PRIVATE             #
# ###################################

# - - - - - - - - - -
# State Machine constructor
# - - - - - - - - - -
func _init(name : String, transitions : Array):
	self.__machine_name__ = name;
	self.__transition_stack__ = transitions;