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
# Holds a reference to the created hosticng threads
# - - - - - - - - - -
var __thread_incubator : Dictionary = {};


# - - - - - - - - - -
# Holds a reference to the app behavior node
# - - - - - - - - - -
var app_behavior : Node = null;


# - - - - - - - - - -
# Holds a reference to the scenePack resource object
# The path to this file should be static
# - - - - - - - - - -
onready var __scene_referencer = preload('res://scripted_resource/ScenePack.tres');


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Gets a reference to the scene referencer object
# Return (Reference): reference to the scene referencer object
# - - - - - - - - - -
func scene_referencer():
	return __scene_referencer;


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


# - - - - - - - - - -
# Request an incubate thread instance
# Return (Reference): Created thread reference
# - - - - - - - - - -
func request_incubate_thread(incubate_name : String):
	__thread_incubator[incubate_name] = IncubatedThrd.new(incubate_name);
	return __thread_incubator[incubate_name];


# - - - - - - - - - -
# Removes a incubated thread from the thread pool
# - - - - - - - - - -
func remove_incubate_thread(incubate_name : String)-> bool:
	return __thread_incubator.erase(incubate_name);


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
	app_behavior = AppBehavior.new();
	add_child(app_behavior);


# - - - - - - - - - -
# Ready Godot API override
# - - - - - - - - - -
func _ready():
	print_msg(
		GameTypes.kTYPES.APPLICATION,
		'Application requesting start behavior'
	);

	app_behavior.start_machine();

	var _requested_thread = request_incubate_thread('transition_load');
	_requested_thread.define_thread_action(
		TaskTypes, 'load_transition_scene', _requested_thread
	);
	_requested_thread.start_task();

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
