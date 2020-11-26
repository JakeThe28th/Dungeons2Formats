vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])

if keyboard_check(vk_right) {
	scroll_amount+=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
if keyboard_check(vk_left) {
	scroll_amount-=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
	
ds_map_set(tile_list_values, "scroll_amount", scroll_amount)
gui_draw_ds_list(5, 80, vw-5, (vh/2)-15, tile_list_values, ds, "dungeons", "tiles")

draw_rectangle_color(5, 5, vw/3-3, 80, col_normal,col_normal,col_normal,col_normal,false)
level_dropdown_values = gui_draw_dropdown(15, 15, vw/3-10, 75, ds_levels, level_dropdown_values, "Level name", "levelDropDown")

draw_rectangle_color(vw/3+3, 5,vw/3+(vw/3-3) , 80, col_normal,col_normal,col_normal,col_normal,false)
objects_dropdown_values = gui_draw_dropdown(vw/3+10, 15, vw/3+(vw/3-10), 75, obj_ds, objects_dropdown_values, "Objectgroup name", "ObjDropDown")



update_level(level_dropdown_values[? "selected_name"])
update_group(objects_dropdown_values[? "selected"])

var current_level_temp = level_dropdown_values[? "selected_name"]
if global.current_level != current_level_temp { 
	

	
	global.current_level = level_dropdown_values[? "selected_name"]
	instance_create_depth(0, 0, 1, obj_load_level)
	ds_map_destroy(ds)
	
	global.level_json = obj_load_level.json
	ds = json_get(json_load(ma_lovika + "objectgroups\\" + json_get(global.level_json, "object-groups", global.selected_group) + ".json"), "objects")
	
	obj_ds = json_get(global.level_json, "object-groups")
	}