class_name MachineTransition

# --------------------------------------------------------------
#                                                              |
#  * Script holding the transition definition                  |
#                                                              |
# -------------------------------------------------------------|


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
# @from (Array): Array with the from possible states
# @to (int): To State enum value
# - - - - - - - - - -
func _init(from : Array, to : int):
	__from__ = from;
	__to__ = to;