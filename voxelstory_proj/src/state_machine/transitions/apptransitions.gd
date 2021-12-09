#--------------------------------------------
# * Script holds the game transitions for all the machines
#--------------------------------------------


class_name AppTransitions


# - - - - - - - - - -
# Holds the initial transitions for the application machine state
# - - - - - - - - - -
var app_transitions : Dictionary = {
	'gotoMainMenu' : MachineTransition.new(
		[GameStates.kAPPSTATES.INTRO],
		GameStates.kAPPSTATES.MAIN_MENU
	)
};