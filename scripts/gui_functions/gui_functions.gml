// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

	
function gui_draw_button(x1, y1, x2, y2, color, hovercolor, text) {
	var state = false
	
	if point_in_area(x1, y1, x2, y2, mouse_x, mouse_y) {
		if mouse_check_button_released(mb_left) state = true
		draw_rectangle_color(x1, y1, x2, y2, hovercolor, hovercolor, hovercolor, hovercolor, false) 
		} else {
			draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false) 
			}
			
	var orderx = order_least_greatest(x1, x2)
	var ordery = order_least_greatest(y1, y2)
	draw_set_halign(fa_middle)
	draw_set_valign(fa_center)
	draw_text((orderx[1]+orderx[0])/2, (ordery[1]+ordery[0])/2, text)
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
		
	return state
}

//order_mode have the options vertical and horizontal, horizontal = scrolls horizontally, 
//and goes down the list vertically until it hits the bounds, vertical = scrolls vertical, goes horizonally.
//Drawing includes a scroll bar at the end of bounds, so i subtract that from bounds for the array itself.
function gui_draw_ds_list(x1, y1, x2, y2, color, hovercolor, scr_barcolor, scr_thumbcolor, ds, order_mode, scroll_amount, dungeons) {
	var orderx = order_least_greatest(x1, x2)
	var ordery = order_least_greatest(y1, y2)
		x1 = orderx[0]
		x2 = orderx[1]
		y1 = ordery[0]
		y2 = ordery[1]
		var w_y2 = ordery[1]-20 //y1 minus scroll bar (horizontal)
		var w_x2 = orderx[1]-20 //x1 minus scroll bar (vertical)
		
	var s_bc = scr_barcolor
	var c = color
	var c_h = hovercolor
	
	
		
	if order_mode = "horizontal" { 
		#region button size
		var divideby = 6
		var min_size = 40
		do {
		//Divide the size to fit it into the bounds
		var b_size_y = (w_y2-y1)/divideby 
		//If we can't divide by less to get the button size over the minimum,
		//set it to the minimum.
		if divideby = 1 and b_size_y < min_size b_size_y = min_size
		
		
		divideby-- //If the size is less than the minimum,
		//this will decrement (until statement)
		
		} until b_size_y >= min_size
	
		var b_size_x = 180 //button size
		var ix = 0
		var iy = 0
		var i = 0
		#endregion
		
		draw_rectangle_color(x1, y1, x2, w_y2, c,c,c,c, false)
		draw_rectangle_color(x1, w_y2, x2, w_y2+20, s_bc,s_bc,s_bc,s_bc, false)
		
		repeat ds_list_size(ds) {
			if (y1+(b_size_y*(iy+1))-5) >= w_y2 {
				iy=  0
				ix++
				}
			
			var x1_inc = x1+(b_size_x*ix) + scroll_amount
			var x2_inc = x1+(b_size_x*(ix+1))-5 + scroll_amount
			var y1_inc = y1+(b_size_y*iy)
			var y2_inc = y1+(b_size_y*(iy+1))-5
			
			//clamp(, x1, x2)
			
			//if x1_inc > x1 and x2_inc < x2 {
			
			if dungeons = "dungeons" {
				gui_draw_button(x1_inc, y1_inc, x2_inc, y2_inc, c_blue, c_h, ds_map_find_value(ds[| i], "id")) 
				} else { gui_draw_button(x1_inc, y1_inc, x2_inc, y2_inc, c_blue, c_h, ds[| i]) }
			
			//}
		
			i++
			iy++
			
			
			}
		}
		
	if order_mode = "vertical" { 
		draw_rectangle_color(x1, y1, w_x2, y2, c,c,c,c, false)
		draw_rectangle_color(w_x2, y1, w_x2+20, y2, s_bc,s_bc,s_bc,s_bc, false)
		
		#region button size
		var divideby = 4
		var min_size = 180
		do {
		//Divide the size to fit it into the bounds
		var b_size_x = (x2-x1)/divideby 
		//If we can't divide by less to get the button size over the minimum,
		//set it to the minimum.
		if divideby = 1 and b_size_x < min_size b_size_x = min_size
		
		divideby-- //If the size is less than the minimum,
		//this will decrement (until statement)
		
		} until b_size_x >= min_size
	
		var b_size_y = 40 //button size
		var ix = 0
		var iy = 0
		var i = 0
		#endregion
		
		draw_rectangle_color(x1, y1, x2, w_y2, c,c,c,c, false)
		draw_rectangle_color(x1, w_y2, x2, w_y2+20, s_bc,s_bc,s_bc,s_bc, false)
		
		repeat ds_list_size(ds) {
			if (x1+(b_size_x*(ix+1))-5) >= x2 {
				iy=  0
				ix++
				}
			
			var x1_inc = x1+(b_size_x*ix)
			var x2_inc = x1+(b_size_x*(ix+1))-5
			var y1_inc = y1+(b_size_y*iy)
			var y2_inc = y1+(b_size_y*(iy+1))-5
			
			if dungeons = "dungeons" {
				gui_draw_button(x1_inc, y1_inc, x2_inc, y2_inc, c_blue, c_h, ds_map_find_value(ds[| i], "id")) 
				} else { gui_draw_button(x1_inc, y1_inc, x2_inc, y2_inc, c_blue, c_h, ds[| i]) }
		
			i++
			iy++
			
			
			}
	}
}