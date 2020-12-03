//Init GUI Builder functions
global.gui_ds = ds_map_create()
gui_functions()

ds_levels = ds_list_create()
var i = 0
repeat array_length(global.level_array) {
	
	ds_levels[| i] = global.level_array[i]
	i++
	
	}
	
scroll_amount = 0
ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")


level_dropdown_values = ds_map_create()
//values = color, hovercolor, scr_barcolor, scr_thumbcolor, scroll_amount,
//gui_draw_dropdown(5, 5, vh/5, 80, ds_levels, level_dropdown_open, c_aqua, c_green, c_black, c_fuchsia, 0, "Level name")
ds_map_add(level_dropdown_values, "color", col_dark)
ds_map_add(level_dropdown_values, "hovercolor", col_med_light)
ds_map_add(level_dropdown_values, "scr_barcolor", col_normal)
ds_map_add(level_dropdown_values, "scr_thumbcolor", col_dark)
ds_map_add(level_dropdown_values, "scroll_amount", 0)
ds_map_add(level_dropdown_values, "scroll", false)
ds_map_add(level_dropdown_values, "selected", 0)
ds_map_add(level_dropdown_values, "selected_name", global.current_level)


obj_ds = json_get(global.level_json, "object-groups")
objects_dropdown_values = ds_map_create()
//values = color, hovercolor, scr_barcolor, scr_thumbcolor, scroll_amount,
//gui_draw_dropdown(5, 5, vh/5, 80, ds_levels, level_dropdown_open, c_aqua, c_green, c_black, c_fuchsia, 0, "Level name")
ds_map_add(objects_dropdown_values, "color", col_dark)
ds_map_add(objects_dropdown_values, "hovercolor", col_med_light)
ds_map_add(objects_dropdown_values, "scr_barcolor", col_normal)
ds_map_add(objects_dropdown_values, "scr_thumbcolor", col_dark)
ds_map_add(objects_dropdown_values, "scroll_amount", 0)
ds_map_add(objects_dropdown_values, "scroll", false)
ds_map_add(level_dropdown_values, "selected", 0)



tile_list_values = ds_map_create()
//values = color, hovercolor, scr_barcolor, scr_thumbcolor, scroll_amount,
//gui_draw_ds_list(5, 80, vw-5, (vh/2)-15, c_gray, c_silver, c_lime, c_orange, ds, scroll_amount, "dungeons")
ds_map_add(tile_list_values, "color", col_normal)
ds_map_add(tile_list_values, "hovercolor", col_med_light)
ds_map_add(tile_list_values, "scr_barcolor", col_med_light)
ds_map_add(tile_list_values, "scr_thumbcolor", col_light)
ds_map_add(tile_list_values, "scroll_amount", 0)

global.current_menu = "tiles"