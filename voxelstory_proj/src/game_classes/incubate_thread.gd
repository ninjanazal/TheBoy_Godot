class_name IncubatedThrd

# - - - - - - - - - -
# Internal thread reference
# - - - - - - - - - -
var __thrd__ : Thread = Thread.new();


# - - - - - - - - - -
# Func Refecerence to be triggered on the incubated thread
# - - - - - - - - - -
var __task__ : Reference= null;


# - - - - - - - - - -
# Incubate thread constructor, a func reference should be passed
# @task (FuncRef): Reference to the needed task
# - - - - - - - - - -
func _init(task : FuncRef):
	self.__task__ = task;
