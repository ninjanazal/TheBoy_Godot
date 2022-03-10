extends CanvasLayer;

# - - - - - - - - - -
# Holding needed components
# - - - - - - - - - -
onready var _components : Dictionary  = {
	'animation' : get_node('AnimationPlayer')
};

# - - - - - - - - - -
# Holds a reference for the current and the target scene, used to manage the switch operation
# - - - - - - - - - -
var _scene_refs : Dictionary = {
	'current_scene' : null,
	'next_scene_path' : null,
	'next_scene_ref' : null,
	'on_end' : null,
	'on_end_args' : null
};


# - - - - - - - - - -
# Internal load thread reference
# - - - - - - - - - -
var __inner_thread__ : Thread = null;

# ###################################|
#               PUBLIC               |
# ###################################|

# - - - - - - - - - -
# Defines the transition setup
# @current_scene_ref (Reference): Reference to the current scene, this will be released
# @to_scene_ref (String): Path to the next scene
# @on_transition_end (FuncRef): Define a function to be called at the transition end
# - - - - - - - - - -
func setUp(current_scene_ref, to_scene_ref, on_transition_end : FuncRef = null, on_end_args : Array = []):
	__reset();

	_scene_refs.current_scene = current_scene_ref;
	_scene_refs.next_scene_path = to_scene_ref;

	_scene_refs.on_end = on_transition_end;
	_scene_refs.on_end_args = on_end_args;

	__inner_thread__ = Thread.new();
	Application.validate_operation(__inner_thread__.start(
		self, '__thread_body__',
		ResourceLoader.load_interactive(_scene_refs.next_scene_path)
	));


# - - - - - - - - - -
# Triggers a start transition animation, this can be waited
# On animation finished will call the callback function defined on the setup
# - - - - - - - - - -
func trigger_transition():
	_components.animation.play('transition_1_in');
	yield(_components.animation, 'animation_finished');

	changeSceneSet();


# - - - - - - - - - -
# Called from the animation to change the current scene
# - - - - - - - - - -
func changeSceneSet():
	var parent_reference = _scene_refs.current_scene.get_parent();
	
	parent_reference.remove_child(_scene_refs.current_scene);
	_scene_refs.current_scene.queue_free();
	_scene_refs.current_scene = null;

	
	while(_scene_refs.next_scene_ref == null):
		yield(get_tree(), 'idle_frame');

	
	_scene_refs.next_scene_ref = _scene_refs.next_scene_ref.instance();

	parent_reference.add_child(_scene_refs.next_scene_ref);
	get_tree().set_current_scene(_scene_refs.next_scene_ref);

	__end_transition_sequence();


# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# Internal function used to reset the animation state
# - - - - - - - - - -
func __reset():
	_components.animation.set_assigned_animation('transition_1_in');
	_components.animation.seek(0.0, true);


# - - - - - - - - - -
# Completes the transition calls, this will trigger a callback if defined
# - - - - - - - - - -
func __end_transition_sequence():
	_components.animation.play('transition_1_out');
	yield(_components.animation, 'animation_finished');

	if(_scene_refs.on_end):
		_scene_refs.on_end.call_funcv(_scene_refs.on_end_args);
	
	Application.clear_transition(self);
	get_parent().remove_child(self);


# - - - - - - - - - -
# Function to be run on an internal thread, should pass the target scene as parameter
# @userdata (String): Target scene path
# - - - - - - - - - -
func __thread_body__(userdata):
	while (true):
		match(userdata.poll()):
			ERR_FILE_EOF:
				# _components.next_scene_ref = userdata.get_resource();
				call_deferred('__on_thread_end__');
				return userdata.get_resource();


# - - - - - - - - - -
# On thread function end callback, this will store the loaded scene object
# - - - - - - - - - -
func __on_thread_end__():
	var temp_result = __inner_thread__.wait_to_finish();
	_scene_refs.next_scene_ref = temp_result;
	__inner_thread__ = null;
