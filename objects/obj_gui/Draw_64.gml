vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])

if keyboard_check(vk_right) {
	scroll_amount+=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
if keyboard_check(vk_left) {
	scroll_amount-=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
gui_draw_ds_list(5, 80, vw-5, (vh/2)-15, c_gray, c_silver, c_navy, c_teal, ds, "horizontal", scroll_amount, "dungeons")