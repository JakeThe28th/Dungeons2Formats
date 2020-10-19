// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function util_ds_path(ds, seperator, path, type){
	//This script requires util_split_string
	//types: map_only, list_only, both
	
	path = split_string(path, seperator)
	
	var value = ds
	var ds_type;
	var i = 0
	repeat array_length(path) {
		if type = "map_only" ds_type = "ds_map"
		if type = "list_only" ds_type = "ds_list"
		
		if is_real(path[i]) show_debug_message("yolo") //path[i] = real(path[i])
		
		try {
			path[i] = real(path[i])
			} catch (e) {
				
				}
		
		if type = "both" {
			//If type is both, check if numbers are list entries before changing to map.
			ds_type = "ds_list"
			if !is_real(path[i]) or ds_list_find_value(value, real(path[i])) = undefined ds_type = "ds_map"
			}
			
	//	show_debug_message(current_block)
			
		if is_undefined(value) return undefined
		
		if path[i] = "?" {
			
			if ds_type = "ds_map" {
				path[i] = ds_map_find_first(value)
				value = ds_map_find_value(value, path[i])
				}
			if ds_type = "ds_list" value = ds_list_find_value(value, 0)
			
			debug_log("DS_PATH", "MISSING '" + current_block + "'")
			
			} else {
				
			if ds_type = "ds_map" value = ds_map_find_value(value, path[i])
			if ds_type = "ds_list" value = ds_list_find_value(value, real(path[i]))
			
			}
			
		if is_undefined(value) return undefined
		
		
		//if is_undefined(value) {
		//	if current_block !="minecraft:stone" debug_log("DS_PATH", current_block)
		//	}
		
		i++
		}
		
		return value
}