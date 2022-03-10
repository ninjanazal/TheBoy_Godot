extends Resource;
class_name ScenePack


# - - - - - - - - - -
# Exported var holding the transition scene path
# - - - - - - - - - -
export (String) var transition_scene_path setget ,getTransitionScenePath;


# - - - - - - - - - -
# Exported var holding the menu scene path
# - - - - - - - - - -
export (String) var menu_scene_path setget ,getMenuScenePath;



# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Gets the path to the transition scene
# Return (String): Transition Scene Path
# - - - - - - - - - -
func getTransitionScenePath()-> String:
	return transition_scene_path;


# - - - - - - - - - -
# Gets the path to the menu scene
# Return (String): Menu Scene Path
# - - - - - - - - - -
func getMenuScenePath()-> String:
	return menu_scene_path;