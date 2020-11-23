//Init GUI Builder functions
global.gui_ds = ds_map_create()
gui_functions()

ds = ds_list_create()
var i = 0
repeat array_length(global.level_array) {
	
	ds[| i] = global.level_array[i]
	i++
	
	}
	
scroll_amount = 0
ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")