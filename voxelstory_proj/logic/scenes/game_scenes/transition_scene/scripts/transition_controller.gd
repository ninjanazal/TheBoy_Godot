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
	'next_scene' : null,
	'on_end' : null
};


# ###################################|
#               PUBLIC               |
# ###################################|

# - - - - - - - - - -
# Defines the transition setup
# @current_scene_ref (Reference): Reference to the current scene, this will be released
# @to_scene_ref (Reference): Reference to the next scene
# @on_transition_end (FuncRef): Define a function to be called at the transition end
# - - - - - - - - - -
func setUp(current_scene_ref, to_scene_ref, on_transition_end : FuncRef = null):
	_scene_refs.current_scene = current_scene_ref;
	_scene_refs.next_scene = to_scene_ref;

	_scene_refs.on_end = on_transition_end;


# - - - - - - - - - -
# Triggers a start transition animation, this can be waited
# On animation finished will call the callback function defined on the setup
# - - - - - - - - - -
func trigger_transition():
	_components.animation.play('transition_1');
	yield(_components.animation, 'animation_finished');
	if(_scene_refs.on_end):
		_scene_refs.on_end.call_func();


# - - - - - - - - - -
# Called from the animation to change the current scene
# - - - - - - - - - -
func changeSceneSet():
	var parent_reference = _scene_refs.current_scene.get_parent();
	
	parent_reference.remove_child(_scene_refs.current_scene);
	_scene_refs.current_scene.queue_free();
	_scene_refs.current_scene = null;

	parent_reference.add_child(_scene_refs.next_scene);



# ###################################
#               PRIVATE             #
# ###################################


# - - - - - - - - - -
# On ready call
# - - - - - - - - - -
func _ready():
	pass;
