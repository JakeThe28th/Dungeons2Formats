macros()

global.ds_map_list = ds_list_create()

global.filter = json_load(ma_directory + "filter.json")

global.current_resource_pack = "squidcoast"
global.current_level = "squidcoast"


//global.selected_level = "squidcoast"
global.selected_group = 0
global.selected_object = 0


global.level_array = dng_levels_list()

instance_create_depth(0, 0, 1, obj_load_level)
global.level_json = obj_load_level.json

global.group_json = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"))

instance_create_depth(0, 0, 1, obj_gui)

	obj_gui.loading_bar_done = 100
	obj_gui.grayed_out_buttons = false

debug_log("INFO", ma_directory)


