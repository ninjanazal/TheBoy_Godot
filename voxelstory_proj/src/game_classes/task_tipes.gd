class_name TaskTypes

# ###################################|
#               PUBLIC               |
# ###################################|


# - - - - - - - - - -
# Loades the menu_scene and registes the progress on the scene reference
# Ths should be called on an incubated thread
# @
# - - - - - - - - - -
static func load_menu_scene(requester_thread):

	var __loader = ResourceLoader.load_interactive(
		Application.scene_referencer().getMenuScenePath()
	);

	while(true):
		var err = __loader.poll();
		match(err):
			ERR_FILE_EOF:
				Application.scene_referencer().setLoadedReference(
					'menu_scene',
					__loader.get_resource()
				);
				requester_thread.task_finished();
				break;
			
			OK:
				Application.scene_referencer().setLoadPercent(
					'menu_scene',
					float(__loader.get_stage() / __loader.get_stage_count())
				);
