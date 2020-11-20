vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])

//Draw background.
draw_rectangle_color(0, 0, vw, vh, color_bg, color_bg, color_bg, color_bg, false) 


//Draw Loading bar.
draw_rectangle_color(5, vh/24, vw-5, vh/16, color_box, color_box, color_box, color_box, false) 
var loadbar_x = (loading_bar_done*(5 - vw-5))-(loading_bar_done*(5 - vw-5))-(loading_bar_done*(5 - vw-5))
draw_rectangle_color(5, vh/24, loadbar_x, vh/16, color_loading_done, color_loading_done, color_loading_done, color_loading_done, false) 

draw_set_font(font0)
if loading_bar_text_type = "small" draw_set_font(font1)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_set_color(c_black)
draw_text(5, vh/24-5, loading_bar_text)
loading_bar_text_type = "normal"
draw_set_font(font0)

//Draw Object array.
draw_rectangle_color(5, (vh/16)+34, vw/3, vh-46, color_box, color_box, color_box, color_box, false)
	
		if selected_group !=0 {
			var i = 0
			var iy = 0
			var max_string_length = 0
			var surf = surface_create((vw/3-5), (vh-46)-((vh/16)+34))
			surface_set_target(surf)
			var surf_w = surface_get_width(surf)
			//List the objects in the selected objectgroup
			repeat ds_list_size(ds_map_find_value(selected_group, "objects")) {
				
				var xsize = json_get(selected_group, "objects", i, "size", 0)
				var ysize = json_get(selected_group, "objects", i, "size", 1)
				var zsize = json_get(selected_group, "objects", i, "size", 2)
				
				var size = xsize*ysize*zsize
				
				
				if gui_button(0,  20*iy-scroll_percent, surf_w, (20*iy-scroll_percent)+20, color_darkbox, color_box, json_get(selected_group, "objects", i, "id") + string(" Size: " + string(size)), (vh/16+34), 5) = 2 selected_object = i
				
				if i = selected_object if gui_button(0,  20*iy-scroll_percent, surf_w, (20*iy-scroll_percent)+20, color_box, color_bg, json_get(selected_group, "objects", i, "id"), (vh/16+34), 5) = 2 selected_object = i
				//If this is the current selected object, draw the background brighter
			
				if string_length(json_get(selected_group, "objects", i, "id") + string(" Size: " + string(size))) > max_string_length max_string_length = string_width(json_get(selected_group, "objects", i, "id"))
	
				iy++
				i++
				} 
				
			surface_reset_target()
			draw_surface(surf, 5, vh/16+34)
			surface_free(surf)
			
			
			if keyboard_check(vk_down) scroll_percent++
			if keyboard_check(vk_up) scroll_percent--
			scroll_percent = clamp(scroll_percent, 0, (20*iy))
			
			
			}
		
	#region Convert to string button
	
	draw_rectangle_color(5, vh-16, vw/3, vh-36, color_box, color_box, color_box, color_box, false)
	if point_in_area(5, vh-16, vw/3, vh-36, mouse_x, mouse_y) and grayed_out_buttons = false {
		draw_rectangle_color(5, vh-16, vw/3, vh-36, color_darkbox, color_darkbox, color_darkbox, color_darkbox, false)
		if mouse_check_button_released(mb_left) {
			grayed_out_buttons = true		
			loading_bar_text = "Import NBT"
			
			instance_create_depth(0, 0, 1, obj_nbt_to_string)
			}
		}
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
	draw_set_color(color_text)
	draw_text(5, vh-16, "Convert a structure to a blockstring")
	
	#endregion
	
	var i = 0
	#region List each object group in the selected level
	repeat ds_list_size(json_get(level_json, "object-groups")) {
		//Repeat for each object group in this level
		
		draw_rectangle_color(vw/2+16, (vh/16+30)+(20*i), vw-5, ((vh/16+30)+(20*i))-20, color_darkbox, color_darkbox, color_darkbox, color_darkbox, false)
		//Draw a background
		
		#region Objectgroup selection
		if point_in_area(vw/2+16, (vh/16+30)+(20*i), vw-5, ((vh/16+30)+(20*i))-20, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)) and grayed_out_buttons = false {
			draw_rectangle_color(vw/2+16, (vh/16+30)+(20*i), vw-5, ((vh/16+30)+(20*i))-20, color_box, color_box, color_box, color_box, false)
			//If it's hovered, draw the background lighter
			
			if mouse_check_button_released(mb_left) {
				selected_group = json_get(level_json, "object-groups", i)
				
				selected_group = json_load(global.dataDirectory + "lovika\\objectgroups\\" + string_replace(selected_group, "/objectgroup", "") + "\\objectgroup.json")
				
				scroll_percent = 0
				//If it's clicked, set the selected group to corresponding json
				}
			
			}
			
			#endregion
			
		if selected_group = json_get(level_json, "object-groups", i) draw_rectangle_color(vw/2+16, (vh/16+30)+(20*i), vw-5, ((vh/16+30)+(20*i))-20, color_box, color_box, color_box, color_box, false)
		//If the current selected group is being drawn, draw the background lighter.
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_set_color(c_black)
		draw_text(vw/2+16, (vh/16+30)+20*i, json_get(level_json, "object-groups", i))
		//Draw its name.
		
		i++
		}
		#endregion

//Draw Level selector
draw_rectangle_color(vw/3+16, vh/16+16, vw/2-16, vh-16, color_box, color_box, color_box, color_box, false)
	var i = 0
	var inc_y = vh/16+20
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_set_color(c_black)
		
	#region Go down the array, draw each entry.
	repeat array_length(level_array) {
		draw_rectangle_color(vw/3+20, inc_y, vw/3+40, inc_y+24, color_darkbox, color_darkbox, color_darkbox, color_darkbox, false)
		if point_in_area(vw/3+20, inc_y, vw/3+40, inc_y+24, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)) and grayed_out_buttons = false {
			#region If the mouse is hovering
			
			draw_rectangle_color(vw/3+20, inc_y, vw/3+40, inc_y+24, color_bg, color_bg, color_bg, color_bg, false)
			//Draw over in a lighter color.
			
			if mouse_check_button_released(mb_left) {
				//If clicked, set the selected level to this entry, and reload the level json
				selected_level = level_array[i] 
				global.current_level = selected_level
				selected_group = 0
				selected_object = 0
				
				instance_create_depth(0, 0, 1, obj_load_level)
				grayed_out_buttons = true
				loading_bar_text = "Loading " + string(global.current_level) + " Filter"
				
				//PAUSE ALL STUFF UNTIL LEVEL IS LOADED!
				//GET RETURNED VALUES
				
				level_json = json_decode(obj_load_level.json_string)
				}
			
			#endregion
			}
		
		draw_text(vw/3+45, inc_y+24, level_array[i])
		if level_array[i] = selected_level draw_sprite_ext(spr_check, 0, vw/3+30, inc_y+12, 2, 2, 0, c_white, 1)
		
		inc_y+=30
		i++
		}
		
		#endregion

//Draw convert button
if gui_button(vw/2+16, vh/6+16, vw-5, vh/4-5, color_darkbox, color_box, "Convert!",0,0) = 2 {
	grayed_out_buttons = true
	var option = get_string("Type 1 to convert to schematic, /n 2 to convert to a .obj/mtl file, /n 3 to convert to a json, /n 4 to convert to an NBT structure block file", "2")
		//if option = "1" instance_create_depth(0, 0, 1, obj_parse_schematic)
		if option = "2" instance_create_depth(0, 0, 1, obj_parse_obj)
	}

	


//Draw preview and console bg
draw_rectangle_color(vw/2+16, vh/4+5, vw-5, vh-16, color_box, color_box, color_box, color_box, false)