// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Change GUI element data
function gui_update_loadingbar(text_size, text, percentage, done_color, color, identifier) {
	if ds_map_find_value(global.gui_ds, identifier) = undefined {
		var current_element = ds_map_create()
		} else var current_element = ds_map_find_value(global.gui_ds, identifier)
		
	ds_map_set(current_element, "type", "loadingbar")
	ds_map_set(current_element, "text_size", text_size)
	ds_map_set(current_element, "text", text)
	ds_map_set(current_element, "percentage", percentage)
	ds_map_set(current_element, "done_color", done_color)
	ds_map_set(current_element, "color", color)
	ds_map_set(global.gui_ds, identifier, current_element)
		
}

function gui_update_ds_list_multiple(ds_list, selected_entries, color, hovercolor, selected_color, identifier) {
//Selected entries is a ds list with multiple numbers for ech selected entry

	if ds_map_find_value(global.gui_ds, identifier) = undefined {
		var current_element = ds_map_create()
		} else var current_element = ds_map_find_value(global.gui_ds, identifier)
		
	ds_map_set(current_element, "type", "ds_list_multiple")
	ds_map_add_list(current_element, "ds_list", ds_list)
	ds_map_set(current_element, "selected_entries", selected_entries)
	ds_map_set(current_element, "color", color)
	ds_map_set(current_element, "hovercolor", hovercolor)
	ds_map_set(current_element, "selected_color", selected_color)
	ds_map_set(global.gui_ds, identifier, current_element)
	
	
}


//Check for input in gui element
function gui_check_ds_list_multiple(identifier) {
	
}

//Draw element
function gui_draw_element(x1, y1, x2, y2, identifier) {
	var current_element = ds_map_find_value(global.gui_ds, identifier)
	
	if (ds_map_find_value(current_element, "type")) = "loadingbar" {
			var color = current_element[? "color"]
			var color_done = current_element[? "done_color"]
			var percentage = current_element[? "percentage"]
			
			var order = order_least_greatest(x1, x2)
				x1 = order[0]
				x2 = order[1]
			var loadbar_x = (percentage)*(x2-x1)
			
			draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false) 
			draw_rectangle_color(x1, y1, x1 + loadbar_x, y2, color_done, color_done, color_done, color_done, false) 
			
		}
		
	if (ds_map_find_value(current_element, "type")) = "ds_list_multiple" {
			
			var selected_entries = current_element[? "selected_entries"]
			var selected_color = current_element[? "selected_color"]
			var hovercolor = current_element[? "hovercolor"]
			var color = current_element[? "color"]
			var ds_list = current_element[? "ds_list"]
			
			var i = 0
			draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, false) 
			repeat ds_list_size(ds_list) {
				var order = order_least_greatest(y1, y2)
				y1 = order[0]
				y2 = order[1]
				
				gui_draw_button(x1, y1+(20*1), x2, y1+(20*1)+20, color, hovercolor, ds_list_find_value(ds_list, i))
				
				i++
				}
			
			
		}
	}
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
	draw_text((orderx[1]+orderx[0])/2, (ordery[1]+ordery[0])/2, text)
		
	return state
}