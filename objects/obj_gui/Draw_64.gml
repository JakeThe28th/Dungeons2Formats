vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])

if keyboard_check(vk_right) {
	scroll_amount+=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
if keyboard_check(vk_left) {
	scroll_amount-=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
	
ds_map_set(tile_list_values, "scroll_amount", scroll_amount)
gui_draw_ds_list(5, 80, vw-5, (vh/2)-5, tile_list_values, ds, "dungeons", "tiles")

draw_rectangle_color(5, 5, vw/3-3, 80, col_normal,col_normal,col_normal,col_normal,false)
level_dropdown_values = gui_draw_dropdown(15, 15, vw/3-10, 75, ds_levels, level_dropdown_values, "Level name", "levelDropDown")

draw_rectangle_color(vw/3+3, 5,vw/3+(vw/3-3) , 80, col_normal,col_normal,col_normal,col_normal,false)
objects_dropdown_values = gui_draw_dropdown(vw/3+10, 15, vw/3+(vw/3-10), 75, obj_ds, objects_dropdown_values, "Objectgroup name", "ObjDropDown")

draw_rectangle_color((vw/3)*2, (vh/2), vw-5, vh-5, col_normal,col_normal,col_normal,col_normal,false)
filetype_checklist_values = gui_draw_checklist(((vw/3)*2)+5, (vh/2)+5, vw-10, vh-10, ds_filetype, filetype_checklist_values, "fileTypeChecklist")

draw_rectangle_color(5, (vh/2), ((vw/3)*2)-5, vh-(vh/3), col_normal,col_normal,col_normal,col_normal,false)
export_options_values = gui_draw_checklist(10, (vh/2), ((vw/3)*2)-5, vh-(vh/3)-5, ds_exportoptions, export_options_values, "exportOptionsChecklist")

update_level(level_dropdown_values[? "selected_name"])
update_group(objects_dropdown_values[? "selected"])

