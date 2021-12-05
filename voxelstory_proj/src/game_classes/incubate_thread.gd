class_name IncubatedThrd

# - - - - - - - - - -
# Internal thread reference
# - - - - - - - - - -
var __thrd__ : Thread = Thread.new();


# - - - - - - - - - -
# Holds the thread name
# - - - - - - - - - -
var __name__ : String = '';


# - - - - - - - - - -
# Task components needed to handle a threaded task
# - - - - - - - - - -
var __task__ : Dictionary= {
	'target_obj' : null,
	'method' : null,
	'params' : null
};


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Defines the task for the 
# - - - - - - - - - -
func define_thread_action(target_obj : Object, method : String, params = null):
	__task__.target_obj = target_obj;
	__task__.method = method;
	__task__.params = params;


# - - - - - - - - - -
# Starts a defined task
# Return (bool): True/False if was able to start
# - - - - - - - - - -
func start_task()-> bool:
	var _validator = __task__.target_obj != null &&\
			__task__.method != null;
	if(!_validator):
		Application.print_msg(
			GameTypes.kTYPES.INCUBATED,
			'Failed to start the main menu scene load on a thread'
		);
		return false;
	
	Application.validate_operation(
		__thrd__.start(
			__task__.target_obj,
			__task__.method,
			__task__.params
	));
	
	Application.print_msg(
			GameTypes.kTYPES.INCUBATED,
			'Task Started on a thread with success!'
		);
	return true;


# - - - - - - - - - -
# Should be called from the thread, informing the conclusion
# - - - - - - - - - -
func task_finished():
	Application.print_msg(
		GameTypes.kTYPES.INCUBATED,
		'\'%s\' thread just finished' % __name__
	);

	Application.remove_incubate_thread(__name__);



# ###################################|
#               PRIVATE              |
# ###################################|


# - - - - - - - - - -
# Incubate thread constructor
# @thread_name (String): Current thread name
# - - - - - - - - - -
func _init(thread_name : String):
	__name__ = thread_name;
