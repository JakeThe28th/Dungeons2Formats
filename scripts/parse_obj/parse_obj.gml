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
		
		
		
		if block_byte != 0 {
			//If the current block's ID isn't 0 (Air)
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
			}
		
		//If full block culling is off force it to make the block
		if ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 0) < 0 sides = 1
		
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
			var cblock = ds_map_find_value(global.filter, string(block_byte))
			
			//Missing block error handling.
			if cblock = undefined { 
				var cstate = undefined
				debug_log("MC2OBJ", "Missing block. X: " + string(x_lines_done) + " Y: " + string(y_lines_done) + " Z: " + string(z_lines_done) + " ID: " + string(block_byte) + " State:" + string(blockstate))
				} else var cstate = ds_map_find_value(cblock, string(blockstate))
		
			if cstate = undefined {
				debug_log("MC2OBJ", "Missing blockstate. X: " + string(x_lines_done) + " Y: " + string(y_lines_done) + " Z: " + string(z_lines_done) + " ID: " + string(block_byte) + " State:" + string(blockstate))
				
				//Increment the current block. If the last block is done, return done. 
				//Otherwise, return -1, since there wasn't a block here.
				if mc2obj_increment_block() = "done" return "done"
				return -1
				}
				
				
			//NOTE TO SELF: IN FUTURE, REWRITE FILTER TO USE MULTIDIMENSIONAL ARRAYS INSTEAD OF DS MAPS.
		
		
		
			current_block = cstate[? "name_raw"] //Name and [Blockstate]
			current_block_name = cstate[? "Name"] //Name
					
			if string_pos("dungeonmaster", current_block_name) !=0 {
				#region full blocks
					var template_model = ma_templates_directory + "block\\j_template_full_block.json"
					var template_model_out = ma_templates_directory + "output\\temp.json"
					
						var texture_all = "minecraft:debug"
						var up = texture_all
						var down = texture_all
						var north = texture_all
						var east = texture_all
						var west = texture_all
						var south = texture_all
					
						textfile_copy_replace(template_model, "%top%",  up, template_model_out)
						textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
					
						textfile_copy_replace(template_model_out, "%north%", north, template_model_out)
						textfile_copy_replace(template_model_out, "%east%", east, template_model_out)
						textfile_copy_replace(template_model_out, "%west%", west, template_model_out)
						textfile_copy_replace(template_model_out, "%south%", south, template_model_out)
					#endregion
					
						if mc2obj_increment_block() = "done" return "done"
					mc2obj_model(x_lines_done,y_lines_done,z_lines_done,template_model_out,text_file_buffer,vertice_count, vertice_texture_count,bds,mtloutput,mat_map)
					return -1
				} else {
		
			#region If the block isn't from dungeons:
			#region Get the block's json file
			
			//Get the blockstates json and decode it.
			var blockstates_js = ma_blockstates_directory + string_replace(current_block_name, "minecraft:", "")
			var blockstates_js = util_file_to_string(blockstates_js + ".json")
			var blockstates_js = json_decode(blockstates_js)
			
			
			//If there arent any variants, this model is probably multipart
			if ds_map_find_value(blockstates_js, "variants") = undefined {
			
				var block_json = util_ds_path(blockstates_js, ";", "multipart;0;apply;model", "both")
				var model = "mutipart"
				} else {
				
			//If there are variants..
			
			//Get the block's state data
			var block_state_values = split_string(current_block, "[")
			var block_state_values = string_replace(block_state_values[array_length(block_state_values)-1], "]", "")
			
			//If there arent any states (all states have '=' in them), set the state data to nothing. (Models without states use "")
			if string_pos("=", block_state_values) = 0 block_state_values = ""
			
			
			var block_json = util_ds_path(blockstates_js,";","variants;" + string(block_state_values) + ";model", "both")
			if block_json = undefined block_json = util_ds_path(blockstates_js,";","variants;" + string(block_state_values) + ";0;model", "both")
			
			if block_json = undefined block_json = util_ds_path(blockstates_js,";","variants;?;model", "both")
			
			if block_json = undefined show_error("Missing block states for current block. Using the first state in blockstates list, '" + current_block_name + "'", false)
			
				}
				
			#endregion
			
		
			var block_json = ma_models_directory + string_replace(block_json, "minecraft:", "") + ".json"
			ds_map_destroy(blockstates_js)
		
			
			#endregion
			
			}

			model = ""
			if model = "multipart" { 
				if string_pos("fence", current_block_name) >0 {
					//chekc for surrounding fences
				
					}
			
				//Repeat (multipart list size)
				//get the model for "apply".
				//if "when" doesn't exist, build that model.
				//if "when" does exist, get it's value
				//Check for "when's value's name + "=" + "when"'s value in the block states.
				//if it exists, build that model.
			
			
				} else {
			blocks_created++
			mc2obj_model(x_lines_done,y_lines_done,z_lines_done,block_json,text_file_buffer,vertice_count, vertice_texture_count,bds,mtloutput,mat_map)
			
			if string_pos("leaves", current_block_name) > 0 and leaf_sides > 0 and ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 2) > -1 {
				var leaf_id = string_replace(current_block_name, "dungeonmaster:LEVELNAME/", "") + "_outer"
				if !ds_map_exists(mat_map, leaf_id) {
				ds_map_add(mat_map, leaf_id, leaf_id)
				#region mtl nonsense
				file_text_write_string(mtloutput, "newmtl " + leaf_id)
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# Ns 0")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# Ka 0.2 0.2 0.2")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "Kd 1 1 1")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "Ks 0 0 0")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# map_Ka " + "resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + leaf_id + ".png")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# for G3D, to make textures look blocky:")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "map_Kd " + "resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + leaf_id + ".png")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# illum 2")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# d 1")
				file_text_writeln(mtloutput)
				file_text_write_string(mtloutput, "# Tr 0")
				file_text_writeln(mtloutput)
				file_text_writeln(mtloutput)
				file_text_writeln(mtloutput)
				#endregion
					}
					
				buffer_write(text_file_buffer, buffer_text, "usemtl " + ds_map_find_value(mat_map, leaf_id))
				buffer_write(text_file_buffer, buffer_text, chr($000D) + chr($000A))
				
				buffer_write(text_file_buffer, buffer_text, "g leaves_outer")
				buffer_write(text_file_buffer, buffer_text, chr($000D) + chr($000A))
				
				mc2obj_build_obj_at("leaves.obj",text_file_buffer,x_lines_done, y_lines_done, z_lines_done)
				}
			}
			
			
		
		} else {
			blocks_skipped++
			if block_byte = 0 air_blocks_skipped++
			current_block = "minecraft:air"
			current_block_name = "minecraft:air"
			}
	
	//if ds_map_find_first(bds) != undefined {
	//	ds_map_destroy(bds)
	//	ds_list_delete(global.ds_map_list, ds_list_find_index(global.ds_map_list, bds))
	//}

	//Increment the current block. If the last block is done, return done.
	if mc2obj_increment_block() = "done" return "done"

}
