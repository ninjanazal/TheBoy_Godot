#--------------------------------------------
# * Script holds the game transitions for all the machines
#--------------------------------------------

class_name AppTransitions


# - - - - - - - - - -
# Holds the initial transitions for the application machine state
# - - - - - - - - - -
var app_transitions : Dictionary = {
	# - - - - - - - - - -
	# Boot game with restore state
	
	'gotoRestoreState' : MachineTransition.new(
		[GameStates.kAPPSTATES.ANY],
		GameStates.kAPPSTATES.RESTORE
	),

	'gotoIntroScene' : MachineTransition.new(
		[GameStates.kAPPSTATES.RESTORE],
		GameStates.kAPPSTATES.INTRO
	),
	'gotoMainMenu' : MachineTransition.new(
			[GameStates.kAPPSTATES.INTRO],
			GameStates.kAPPSTATES.MAIN_MENU
	)
};