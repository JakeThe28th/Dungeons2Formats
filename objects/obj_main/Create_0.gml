global.ds_map_list = ds_list_create()

global.filter = false

global.current_resource_pack = "squidcoast"
global.current_level = "squidcoast"


global.selected_level = "squidcoast"
global.selected_group = 0
global.selected_object = 0


global.level_array = dng_levels_list()

instance_create_depth(0, 0, 1, obj_load_level)
global.level_json = obj_load_level.json

instance_create_depth(0, 0, 1, obj_gui)



