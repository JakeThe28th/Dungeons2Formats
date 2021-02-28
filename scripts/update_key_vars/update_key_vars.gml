// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_group(group_entry) {
	if group_entry != global.selected_group or prevlevel != global.current_level {
		
	global.selected_group = group_entry
	ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")
	global.group_json = json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json")
	
	if ds = undefined {
		ds = json_decode("[{\"blocks\" : \"aaaa\",\"pos\" : [ 0, 0, 0 ],\"id\" : \"Failed to load.\",\"size\" : [ 1, 1, 1 ],}]")[? "default"]
		//global.current_level = prevlevel
		//update_level(global.current_level)
		//update_group(group_entry)
		//show_message("Failed to load.")
		return -1
		}
	}
}

function update_level(level_name) {
if global.current_level != level_name { 
	
	global.current_level = level_name
	instance_create_depth(0, 0, 1, obj_load_level)
	ds_map_destroy(ds)
	
	ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")
	
	
	obj_ds = json_get(global.level_json, "object-groups")
	}
}

function update_object(object_entry) {
	global.selected_object = object_entry
	}