class_name IncubatedThrd

# - - - - - - - - - -
# Internal thread reference
# - - - - - - - - - -
var __thrd__ : Thread = Thread.new();


# - - - - - - - - - -
#
# - - - - - - - - - -
var __task__ : Funcref = null;


# - - - - - - - - - -
# Incubate thread constructor, a func reference should be passed
# @task (FuncRef): Reference to the needed task
# - - - - - - - - - -
func _init(task : Funcref):
