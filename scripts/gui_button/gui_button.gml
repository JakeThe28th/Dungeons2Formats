///gui_button(x1, y1, x2, y2, color, color_hover, text, y_offset, x_offset)
///@param x1
///@param y1
///@param x2
///@param y2
///@param color
///@param color_hover
///@param string
///@param y_offset
///@param x_offset
function gui_button(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {
	var x1 = argument0
	var y1 = argument1
	var x2 = argument2
	var y2 = argument3
	var color = argument4
	var color_hover = argument5
	var text = argument6
	var y_offset = argument7
	var x_offset = argument8

	var order = order_least_greatest(x1, x2)
	x1 = order[0]
	x2 = order[1]

	var order = order_least_greatest(y1, y2)
	y1 = order[0]
	y2 = order[1]

	var vreturn = 0

	draw_set_color(color)
	draw_rectangle(x1, y1, x2, y2, false)
	if point_in_area(x1+x_offset, y1+y_offset, x2+x_offset, y2+y_offset, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)) and grayed_out_buttons = false { 
		draw_set_color(color_hover)
		draw_rectangle(x1, y1, x2, y2, false)
	
		var vreturn = 1
	
		if mouse_check_button_released(mb_left) { 
			var vreturn = 2
			//If the left mouse button is released, return 2
			}
		
	
		//If the mouse is hovering, return 1.
		}
	
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		draw_set_color(c_black)
		draw_text((x1+x2)/2, (y1+y2)/2, text)
	

	return vreturn
	//If nothing happens, return 0.


}
