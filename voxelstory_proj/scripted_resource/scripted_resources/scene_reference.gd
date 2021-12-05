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


# - - - - - - - - - -
# Loads a reference for the allready loaded scenes
# - - - - - - - - - -
var __loaded_scenes : Dictionary = {

	'transition' : {
		'percent' : 0.0,
		'reference' : null
	},

	'menu_scene' : {
		'percent' : 0.0,
		'reference' : null
	},

	'game_scene' : {
		'percent' : 0.0,
		'reference' : null
	}
}


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


# - - - - - - - - - -
# Gets the loaded amount for a defined scene, if not found will return -1.0
# @scene_name (String): Scene Name to be consulted
# Return (float): Loaded percent value
# - - - - - - - - - -
func getLoadPercent(scene_name : String)-> float:
	if(__loaded_scenes.has(scene_name)):
		return __loaded_scenes[scene_name].percent;
	return -1.0;


# - - - - - - - - - -
# Gets the loaded reference for a defined scene, if not found will return null
# @scene_name (String): Scene Name to be consulted
# Return (Reference): Loaded scene reference
# - - - - - - - - - -
func getLoadReference(scene_name : String):
	if(__loaded_scenes.has(scene_name) && __loaded_scenes[scene_name].percent == 1.0):
		return __loaded_scenes[scene_name].reference;
	return null;


# - - - - - - - - - -
# Defines the current scene load percent value
# @scene_name (String): Scene Name to be consulted
# @amount (float): Percent amount to be defined
# - - - - - - - - - -
func setLoadPercent(scene_name : String, amount : float):
	if(__loaded_scenes.has(scene_name)):
		__loaded_scenes[scene_name].percent = amount;


# - - - - - - - - - -
# Defines the loaded reference for a defined scene
# @scene_name (String): Scene Name to be consulted
# @scene_ref (Reference): Reference to a loaded scene
# - - - - - - - - - -
func setLoadedReference(scene_name : String, scene_ref):
	if(__loaded_scenes.has(scene_name)):
		__loaded_scenes[scene_name].percent = 1.0;
		__loaded_scenes[scene_name].reference = scene_ref;


# - - - - - - - - - -
# Clears a defined and loaded scene reference
# @scene_name (String): Scene Name to be consulted
# - - - - - - - - - -
func clearLoadedReference(scene_name : String):
	if(__loaded_scenes.has(scene_name) && __loaded_scenes[scene_name].percent == 1.0):
		__loaded_scenes[scene_name].reference.queue_free();
		__loaded_scenes[scene_name].reference = null;
		__loaded_scenes[scene_name].percent = 0.0;
