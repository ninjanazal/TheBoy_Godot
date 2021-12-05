extends Resource;
class_name ScenePack


# - - - - - - - - - -
# Loads a reference for the allready loaded scenes
# - - - - - - - - - -
var __loaded_scenes : Dictionary = {

	'menu_scene' : {
		'percent' : 0.0,
		'reference' : null
	},

	'game_scene' : {
		'percent' : 0.0,
		'reference' : null
	}
}

# - - - - - - - - - -
# Exported var holding the menu scene packed
# - - - - - - - - - -
export (String) var menu_scene_path setget ,getMenuScenePath;


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Gets the packed menu scene
# Return (Packed Scene): Packed Menu Scene
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
