class_name MachineTransition

# --------------------------------------------------------------
#                                                              |
#  * Script holding the transition definition                  |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Holds the transition name
# - - - - - - - - - -
var __name__ : String;


# - - - - - - - - - -
# Holds possible from array
# - - - - - - - - - -
var __from__ : Array;


# - - - - - - - - - -
# Holds the transition exit state
# - - - - - - - - - -
var __to__ : int;


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Gets the to State
# Return (int): 
# - - - - - - - - - -
func getToState()-> int:
	return __to__;


# - - - - - - - - - -
# Evaluates if the defined target State ia an valid from state
# - - - - - - - - - -
func verifyFromState(target_state : int)-> bool:
	return __from__.has(GameStates.kAPPSTATES.ANY) ||\
		__from__.has(target_state);


# ###################################|
#               PRIVATE              |
# ###################################|


# - - - - - - - - - -
# Transition constructor function
# @name (String): Transition Name
# @from (Array): Array with the from possible states
# @to (int): To State enum value
# - - - - - - - - - -
func _init(name : String, from : Array, to : int):
	__name__ = name;
	__from__ = from;
	__to__ = to;