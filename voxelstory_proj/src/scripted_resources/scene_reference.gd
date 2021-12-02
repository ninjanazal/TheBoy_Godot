extends Resource;
class_name ScenePack


# - - - - - - - - - -
# Exported var holding the menu scene packed
# - - - - - - - - - -
export (PackedScene) var menu_scene setget get_menu_scene;


# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Gets the packed menu scene
# Return (Packed Scene): Packed Menu Scene
# - - - - - - - - - -
func get_menu_scene()-> PackedScene:
	return menu_scene;
