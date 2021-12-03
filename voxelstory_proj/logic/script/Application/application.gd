extends Node;

# --------------------------------------------------------------
#                                                              |
# *  Script that manages the main aplication functionality     |
#                                                              |
# -------------------------------------------------------------|

# - - - - - - - - - -
# Holds an instance of the current playState informations
# - - - - - - - - - -
var __inner_player : Reference = null;


# - - - - - - - - - -
# Holds a reference to the created hosting threads
# - - - - - - - - - -
var __thread_incubator : Dictionary = {};


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Evaluates a return operation code, this can close the application or handle the error
# @error_code (int): Returned action error code
# - - - - - - - - - -
func validate_operation(error_code : int):
	if(error_code != GameTypes.kERROR.OK):
		__force_quit();


# - - - - - - - - - -
# Prints a debug mesage with the trigger type name
# @type_id (int): Requester type enum value
# @msg (String): Message to be printed
# - - - - - - - - - -
func print_msg(type_id : int,  msg : String):
	print('--> %s \t::: \t%s' % [
		GameTypes.kTYPES.keys()[type_id],
		msg
	]);


# ###################################|
#               PRIVATE              |
# ###################################|


# - - - - - - - - - -
# Enter tree Godot API override
# - - - - - - - - - -
func _enter_tree():
	print_msg(
		GameTypes.kTYPES.APPLICATION,
		'Application started ...'
	);


# - - - - - - - - - -
# Ready Godot API override
# - - - - - - - - - -
func _ready():
	print_msg(
		GameTypes.kTYPES.APPLICATION,
		'Loading player state configuration ...'
	);

	__load_player();


# - - - - - - - - - -
# ! Current Mocked
# Loads a player state information
# - - - - - - - - - -
func __load_player():
	__inner_player = PlayerClass.PlayState.new('Player');


# - - - - - - - - - -
# Forces the application to quit, this will print the stack
# - - - - - - - - - -
func __force_quit():
	print_msg(
		GameTypes.kTYPES.APPLICATION,
		'Force quit requested, closing ...'
	);
	print_stack();
	get_tree().quit();
