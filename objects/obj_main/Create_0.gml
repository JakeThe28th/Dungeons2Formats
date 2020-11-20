global.objectgroup = "false"

global.dataDirectory = filename_path(get_save_filename("Data directory|*.*", "Enter the directory and press save.sav"))

global.filter = false

global.current_resource_pack = "squidcoast"

global.ds_map_list = ds_list_create()

instance_create_depth(0, 0, 1, obj_gui)

//global.currentfilter = get_open_filename("Dungeons Map Filters|*.json", "")
//instance_create_depth(0, 0, 1, obj_parse_filter) //temp

