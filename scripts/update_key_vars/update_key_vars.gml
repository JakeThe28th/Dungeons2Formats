// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_group(group_entry) {
	if group_entry != global.selected_group or prevlevel != global.current_level {
	global.selected_group = group_entry
	ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")
	global.group_json = json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json")
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