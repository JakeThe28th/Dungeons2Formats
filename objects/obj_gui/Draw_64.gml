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

draw_rectangle_color(5, 5, vh/3-3, 80, col_normal,col_normal,col_normal,col_normal,false)
level_dropdown_values = gui_draw_dropdown(15, 15, vh/3-10, 75, ds_levels, level_dropdown_values, "Level name", "levelDropDown")