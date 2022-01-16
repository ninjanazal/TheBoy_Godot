extends Node;

# --------------------------------------------------------------
#                                                              |
# *  Script that manages the main aplication functionality     |
#                                                              |
# -------------------------------------------------------------|


# - - - - - - - - - -
# Constant var holding the scene pack resource path
# - - - - - - - - - -
const __SCENE_PACK_PATH : String = 'res://scripted_resource/ScenePack.tres';


# - - - - - - - - - -
# Holds a reference to the scenePack resource object
# The path to this file should be static
# - - - - - - - - - -
onready var __scene_referencer = preload(__SCENE_PACK_PATH);

# - - - - - - - - - -
# Holds an instance of the current playState informations
# - - - - - - - - - -
var __inner_player : Reference = null setget set_player, get_player;


# - - - - - - - - - -
# Holds a reference to the created hosticng threads
# - - - - - - - - - -
var __thread_incubator : Dictionary = {};


# - - - - - - - - - -
# Holds a reference to the app behavior node
# - - - - - - - - - -
var app_behavior : Node = null;


# - - - - - - - - - -
# Holds a reference for the current main node on the tree
# - - - - - - - - - -
var main_node : Node = null;


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


# - - - - - - - - - -
# Defines a new player information
# @new_player (Reference): New player reference value
# - - - - - - - - - -
func set_player(new_player : Reference):
	if(__inner_player):
		return;
	__inner_player = new_player;


# - - - - - - - - - -
# Gets the current player object
# Return (Reference): Current player reference
# - - - - - - - - - -
func get_player()-> Reference:
	return __inner_player;


# ###################################|
#               PRIVATE              |
# ###################################|


# - - - - - - - - - -
# Enter tree Godot API override
# - - - - - - - - - -
func _enter_tree():
	VisualServer.texture_set_shrink_all_x2_on_set_data(true);

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

	#__load_player();


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