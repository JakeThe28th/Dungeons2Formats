// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

	
function gui_draw_button(x1, y1, x2, y2, color, hovercolor, text, px, py, menu) {
	var state = false
	
	
	if point_in_area(x1, y1, x2, y2, px, py) {
		if mouse_check_button_released(mb_left) state = true
		if global.current_menu = menu or menu = false {
		//draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false) 
		draw_rectangle_color(x1, y1, x2, y2, hovercolor, merge_color(hovercolor, color, .75), merge_color(hovercolor, color, .75), hovercolor, false) 
		}
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
function gui_draw_ds_list(x1, y1, x2, y2, values, ds, dungeons, menu) {
	//values = color, hovercolor, scr_barcolor, scr_thumbcolor, scroll_amount,
	var color = ds_map_find_value(values, "color")
	var hovercolor = ds_map_find_value(values, "hovercolor")
	var scr_barcolor = ds_map_find_value(values, "scr_barcolor")
	var scr_thumbcolor = ds_map_find_value(values, "scr_thumbcolor")
	var scroll_amount = ds_map_find_value(values, "scroll_amount")
	
	var orderx = order_least_greatest(x1, x2)
	var ordery = order_least_greatest(y1, y2)
		x1 = orderx[0]
		x2 = orderx[1]
		y1 = ordery[0]
		y2 = ordery[1]
		//Temp for surface
		var t_x1 = orderx[0]
		var t_x2 = orderx[1]
		var t_y1 = ordery[0]
		var t_y2 = ordery[1]
		
		var w_t_y2 = ordery[1]-20 //t_y1 minus scroll bar
		if ds_map_exists(values, "scroll") and values[? "scroll"] w_t_y2 = ordery[1]
		
	var s_bc = scr_barcolor
	var c = color
	var c_h = hovercolor
	var s_tc = scr_thumbcolor
	
	var mx = mouse_x
	var my = mouse_y
	
	if !performance_mode {
		var ds_surf = surface_create(t_x2-t_x1, (t_y2-t_y1))
		surface_set_target(ds_surf)
		
		t_x1 -= x1
		t_x2 -= x1
		t_y1 -= y1
		t_y2 -= y1
		
		w_t_y2 -=y1
		//w_t_y2 -=x1
		
		mx -= x1
		my -= y1
		}
	
		#region button size
		var divideby = 8
		var min_size = 20
		do {
			//Divide the size to fit it into the bounds
			var b_size_y = (w_t_y2-t_y1)/divideby 
			
			//If we can't divide by less to get the button size over the minimum,
			//set it to the minimum.
			if divideby = 1 and b_size_y < min_size b_size_y = min_size
		
		
			divideby-- //If the size is less than the minimum,
			//this will decrement (until statement)
		
		} until b_size_y >= min_size
		
		//Static button width
		var b_size_x = 180
		
		var divideby = 8
		var min_size = 180
		do {
			//Repeat code of above loop, but for x size.
			var b_size_x = (t_x2-t_x1)/divideby 
			
			if divideby = 1 and b_size_x < min_size b_size_x = min_size
			divideby-- 
		
		} until b_size_x >= min_size
	
		

		var ix = 0
		var iy = 0
		var i = 0
		#endregion
		
		draw_rectangle_color(t_x1, t_y1, t_x2, w_t_y2, c,c,c,c, false)
		
		//Draw scroll bar
		if !ds_map_exists(values, "scroll") or values[? "scroll"] {
			draw_rectangle_color(t_x1, t_y2, t_x2, w_t_y2, s_bc,s_bc,s_bc,s_bc,false)
			}
		
		
		var selected = ds_map_find_value(values, "selected")
		
		//if ds_map_exists(values, "scroll") and !values[? "scroll"] {
		//		var b = "a"
		//		}
		
		repeat ds_list_size(ds) {
			if (t_y1+(b_size_y*(iy+1))-5) >= w_t_y2 {
				iy=  0
				ix++
				}
				
			
			
			var t_x1_inc = t_x1+(b_size_x*ix) + scroll_amount
			var t_x2_inc = t_x1+(b_size_x*(ix+1))-5 + scroll_amount
			var t_y1_inc = t_y1+(b_size_y*iy)
			var t_y2_inc = t_y1+(b_size_y*(iy+1))-5
			
			//clamp(, t_x1, t_x2)
			
			//if t_x1_inc > t_x1 and t_x2_inc < t_x2 {
			
			if i = selected {
				var c_temp = c
				c = hovercolor
				}	
			
			if dungeons = "dungeons" {
				if gui_draw_button(t_x1_inc, t_y1_inc, t_x2_inc, t_y2_inc, c, c_h, ds_map_find_value(ds[| i], "id"), mx, my, menu) {
					ds_map_set(values, "selected", i)
					ds_map_set(values, "selected_name", ds_map_find_value(ds[| i], "id"))
					}
				} else { 
					if gui_draw_button(t_x1_inc, t_y1_inc, t_x2_inc, t_y2_inc, c, c_h, ds[| i], mx, my, menu) {
						ds_map_set(values, "selected", i)
						ds_map_set(values, "selected_name", ds[| i])
						}
					}
					
			if i = selected {
				c = c_temp
				}	
			
			//}
		
			i++
			iy++
			}
			
		if !performance_mode {
			surface_reset_target()
			draw_surface(ds_surf, x1, y1)
			surface_free(ds_surf)
			}

}

function gui_draw_dropdown(x1, y1, x2, y2, ds, values, text, menu) {
	//values = color, hovercolor, scr_barcolor, scr_thumbcolor, scroll_amount,
	var color = ds_map_find_value(values, "color")
	var hovercolor = ds_map_find_value(values, "hovercolor")
	var scr_barcolor = ds_map_find_value(values, "scr_barcolor")
	var scr_thumbcolor = ds_map_find_value(values, "scr_thumbcolor")
	var scroll_amount = ds_map_find_value(values, "scroll_amount")
	
	if !ds_map_exists(values, "open") ds_map_add(values, "open", 0)
	var open = ds_map_find_value(values, "open")
	

	//Toggle open/closed
	if gui_draw_button(x1, y1, x2, y2, color, hovercolor, text, mouse_x, mouse_y, 0) {
		switch(open) {
			case true: open = false; global.current_menu = "tiles";break;
			case false: open = true; global.current_menu = menu; break;
			}
		}
		
	//Temporary dimensions
	var open_y2 = vh-100
	var open_x2 = x1+(180*2)
	
	//Get widest entry from DS list
	var maxstringwidth = 0
	var i = 0
	repeat(ds_list_size(ds)) { if string_width(ds[| i]) > maxstringwidth maxstringwidth = string_width(ds[| i]); i++ }
	
	//Set the dimensions to fit the text.
	open_y2 = y2 + ((string_height(ds[| 0])+10)*ds_list_size(ds))
	if open_y2 < y2+300 open_x2 = x1+ maxstringwidth +30
	
	
	//Transition
	//var transition = false
	if !performance_mode {
		var percent = ds_map_find_value(values, "percent_transition")
		if !ds_map_exists(values, "percent_transition") ds_map_add(values, "percent_transition", 1) else {
			if open {
				if percent < 100 { 
					percent = 100 - ((100-percent)/2)
					if ceil(percent) = 100 then percent = 100
				
					ds_map_set(values, "percent_transition", percent)
					}
			
		
				var order = order_least_greatest(y2, open_y2)
				open_y2 = ceil(lerp(order[0], order[1], percent/100) + 1)
				if percent < 5 open_y2 = y2+1
				}
				
			if !open and percent > 10 {
				
				if percent > 0 { 
					percent -= (percent/2)
					if floor(percent) = 0 then percent = 0
				
					ds_map_set(values, "percent_transition", percent)
					}
			
		
				var order = order_least_greatest(y2, open_y2)
				open_y2 = floor(lerp(order[0], order[1], percent/100) + 1)
				if percent < 5 open_y2 = y2+1
				
				
				//draw the DS
				gui_draw_ds_list(x1, y2, x1+(180*2), open_y2, values, ds, false, menu)
				}
			}
			
		}
	
	
	
	//Draw the ds
	if open = true {
		gui_draw_ds_list(x1, y2, open_x2, open_y2, values, ds, false, menu)
		
		}
		
	if mouse_check_button_released(mb_left) and !point_in_area(x1, y1, open_x2, open_y2, mouse_x, mouse_y) { 
		open = false; 
		if global.current_menu = menu then global.current_menu = "tiles";
		
		//if global.current_menu != menu open = false
		//TEMP while i figure out how to use dynamic lengths with out of bounds clicking
		
		}
		
	
	ds_map_set(values, "open", open)
	return values
	}
	
function gui_draw_checklist(x1, y1, x2, y2, ds, values, menu) {
	var color = ds_map_find_value(values, "color")
	var hovercolor = ds_map_find_value(values, "hovercolor")
	var text_col = ds_map_find_value(values, "text_color")
	var selected = ds_map_find_value(values, "selected")
	
	draw_rectangle_color(x1, y1, x2, y2,color,color,color,color,false)
	
	var y_change = 0
	var i = 0
	repeat ds_list_size(ds) {
		var check_string = "[ ] " + ds[| i]
		if ds_list_find_index(selected, i) >=0 {
			check_string = "[x] " + ds[| i]
			}
			
		if point_in_area(x1, y1+y_change, x2, y1+y_change+25, mouse_x, mouse_y) {
			draw_rectangle_color(x1, y1+y_change, x2, y1+y_change+25,hovercolor,hovercolor,hovercolor,hovercolor,false)
			
			if mouse_check_button_released(mb_left) {
			var entry = ds_list_find_index(selected, i)
			if entry >=0 {
				ds_list_delete(selected, entry) 
				
			} else ds_list_add(selected, i)
			}
		}
		
		
		draw_set_valign(fa_top)
		draw_text(x1, y1+y_change, check_string)
		
		i++
		y_change += 25
		}
		
		return values
}