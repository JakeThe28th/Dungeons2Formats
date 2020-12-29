///convert_blocks(i)
///@param increment
function parse_obj() {

		dungeons_id = 0


		//Get block
		var block = (x_lines_done + (xsize*z_lines_done) + ((zsize*xsize)*y_lines_done)) -1
		buffer_seek(blockdata, buffer_seek_start, block)
	
		//Get blockstate
		var block_floor = floor(block/2)
		buffer_seek(blockstatedata, buffer_seek_start, block_floor)
	
		//Read bytes
		var block_byte = buffer_read(blockdata, buffer_u8)
		var block_state_byte = buffer_read(blockstatedata, buffer_u8)
		
		#region Culling map.
		if block_byte != 0 {
			//If the current block's ID isn't 0 (Air)
			if ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 0) >= 0 {
			//If full block culling is off force it to make the block
			#region Modify the ds map of the surrounding 6 blocks (To know whether or not to cull a face)
			
			var sides = 6 //Visible sides of block
			var leaf_sides = 6
			//debug_log("MC2OBJ", "up")
			var result = mc2obj_check_transparent(0, 1, 0)
				ds_map_set(bds, "up", result)		
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ", "down")
			var result = mc2obj_check_transparent(0, -1, 0)
				ds_map_set(bds, "down", result)
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ", "north")
			var result = mc2obj_check_transparent(0, 0, -1)
				ds_map_set(bds, "north", result)
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ", "south")
			var result = mc2obj_check_transparent(0, 0, 1)
				ds_map_set(bds, "south", result)
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ", "east")
			var result = mc2obj_check_transparent(1, 0, 0)
				ds_map_set(bds, "east", result)
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ", "west")
			var result = mc2obj_check_transparent(-1, 0, 0)
				ds_map_set(bds, "west", result)
				if result = 0 sides--
				if result = 2 leaf_sides--
				
			//debug_log("MC2OBJ",string(sides))
				
			#endregion
			} else sides = 1
		}
		#endregion
		
		if block_byte != 0 and sides > 0 {
	
			#region Get blockstate ID
			if block_floor < ceil(block/2) {
			//This is the second state.
		
			var blockstate = string_copy(string(int_to_binary(block_state_byte, 8)), 3, 4)
			var blockstate = binary_to_int(blockstate)
			} else { 
			//This is the first state.	
			
				var blockstate = string_copy(string(int_to_binary(block_state_byte, 8)), 0, 4)
				var blockstate = binary_to_int(blockstate)
				} 
			
		#endregion
		
			//Get the block name, and state from its ID.
			var block_name = ds_map_find_value(global.filter, string(block_byte))
			var block_entry = global.pack_blocks[? block_name]
			
			var blockshape = block_entry[? "blockshape"]
			if blockshape = undefined blockshape = "basic"
			
			var all_sides, up, down, side, north, east, west, south;
			var all_sides = false
			var textures = block_entry[? "textures"]
			if !is_string(textures) {
						
				if textures[? "up"] != undefined up = textures[? "up"]
				if textures[? "down"] != undefined down = textures[? "down"]
				
				//Column
				if textures[? "side"] != undefined {
					side = textures[? "side"]
					
					north = false
					east = false
					west = false
					south = false
					}
					
				//Directional
				if textures[? "north"] != undefined {
					north = textures[? "north"]
					east = textures[? "east"]
					west = textures[? "west"]
					south = textures[? "south"]
					
					side = false
					}
				
			
				} else {
					var all_sides = textures
			
					var up = all_sides
					var down = all_sides
					var side = all_sides
			
					var north = all_sides
					var east = all_sides
					var south = all_sides
					var west = all_sides
					}
					
			
			if all_sides = false {
				//HANDLE THE TEXTURES LIST AND OBJECT
				var i = 0
				var temp_tex_face = up
				repeat 7 {
					switch (i) {
						case 0: temp_tex_face = up; break;
						case 1: temp_tex_face = down; break;
						case 2: temp_tex_face = side; break;
						case 3: temp_tex_face = north; break;
						case 4: temp_tex_face = east; break;
						case 5: temp_tex_face = west; break;
						case 6: temp_tex_face = south; break;
						} 
						
						if temp_tex_face !=false {
				
						var textures_states = json_get(global.pack_terrain_texture, "texture_data", temp_tex_face)
							if is_string(textures_states) temp_tex_face = textures_states else {
								temp_tex_face = json_get(textures_states, blockstate)
								}
						
						temp_tex_face = json_get(global.pack_resources, "resources", "textures", temp_tex_face)
						
						switch (i) {
						case 0: up = temp_tex_face; break;
						case 1: down = temp_tex_face; break;
						case 2: side = temp_tex_face; break;
						case 3: north = temp_tex_face; break;
						case 4: east = temp_tex_face; break;
						case 5: west = temp_tex_face; break;
						case 6: south = temp_tex_face; break;
						} 
						}
					i++
					}
				}
			
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%up%", up, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%down%", down, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%west%", west, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%east%", east, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%north%", north, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			var block_json = textfile_copy_replace(ma_templates_directory + "blockshapes\\" + blockshape + ".json", "%south%", south, ma_templates_directory + "generated\\" + block_name + "_" + string(blockstate))
			
			
			mc2obj_model(x_lines_done,y_lines_done,z_lines_done,block_json,text_file_buffer,vertice_count, vertice_texture_count,bds,mtloutput,mat_map)
			
			
			var leaf_sides = -1
			if string_pos("leaves", current_block_name) > 0 and leaf_sides > 0 and ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 2) > -1 {
				var leaf_id = string_replace(current_block_name, "dungeonmaster:LEVELNAME/", "") + "_outer"
				if !ds_map_exists(mat_map, leaf_id) {
				ds_map_add(mat_map, leaf_id, leaf_id)
				mc2obj_mtl(mtloutput, mat_map, leaf_id, global.current_resource_pack + "\\images\\blocks\\" + leaf_id + ".png")
					}
					
				buffer_write(text_file_buffer, buffer_text, "usemtl " + ds_map_find_value(mat_map, leaf_id))
				buffer_write(text_file_buffer, buffer_text, chr($000D) + chr($000A))
				
				buffer_write(text_file_buffer, buffer_text, "o leaves_outer")
				buffer_write(text_file_buffer, buffer_text, chr($000D) + chr($000A))
				
				mc2obj_build_obj_at("leaves.obj",text_file_buffer,x_lines_done, y_lines_done, z_lines_done)
				}

		} else {
			blocks_skipped++
			if block_byte = 0 air_blocks_skipped++
			current_block = "air"
			current_block_name = "air"
			}
	
	//if ds_map_find_first(bds) != undefined {
	//	ds_map_destroy(bds)
	//	ds_list_delete(global.ds_map_list, ds_list_find_index(global.ds_map_list, bds))
	//}

	//Increment the current block. If the last block is done, return done.
	if mc2obj_increment_block() = "done" return "done"

}
