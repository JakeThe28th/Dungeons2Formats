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
			//debug_log("MC2OBJ", "up")
			var result = mc2obj_check_transparent(0, 1, 0)
				ds_map_set(bds, "up", result)		
				if result = 0 sides--
				
			//debug_log("MC2OBJ", "down")
			var result = mc2obj_check_transparent(0, -1, 0)
				ds_map_set(bds, "down", result)
				if result = 0 sides--
				
			//debug_log("MC2OBJ", "north")
			var result = mc2obj_check_transparent(0, 0, -1)
				ds_map_set(bds, "north", result)
				if result = 0 sides--
				
			//debug_log("MC2OBJ", "south")
			var result = mc2obj_check_transparent(0, 0, 1)
				ds_map_set(bds, "south", result)
				if result = 0 sides--
				
			//debug_log("MC2OBJ", "east")
			var result = mc2obj_check_transparent(1, 0, 0)
				ds_map_set(bds, "east", result)
				if result = 0 sides--
				
			//debug_log("MC2OBJ", "west")
			var result = mc2obj_check_transparent(-1, 0, 0)
				ds_map_set(bds, "west", result)
				if result = 0 sides--
				
			//debug_log("MC2OBJ",string(sides))
				
			#endregion
			}
	
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
				dungeons_id = "dungeons"
			
				//Check if we've already made a json for this block. If not, make one.
				var template_model_out = working_directory + global.current_resource_pack + + "\\" + string_replace_all(current_block_name, "dungeonmaster:LEVELNAME/", "dungeons_") + ".json"
				
				if !file_exists(template_model_out) {
				
				var block_state_values = split_string(current_block, "[")
				var block_state_values = string_replace(block_state_values[array_length(block_state_values)-1], "]", "")
				if string_pos("=", block_state_values) < 1 block_state_values = ""
			
				var block_type = "full"
					
				debug_log("MC2OBJ", "Creating JSON for " + global.current_resource_pack + ": " + current_block_name + " FILE:" + template_model_out)
				
				#region Get textures.
				var block_texture_json = ds_map_find_value(global.block_textures, string_replace(current_block_name, "dungeonmaster:LEVELNAME/", ""))
			
				if block_texture_json != undefined {	
					
					if ds_map_find_value(block_texture_json, "blockshape") != undefined {
						if ds_map_find_value(block_texture_json, "blockshape") = "cross_texture" block_type = "cross"
						}
					
					var block_texture_json = ds_map_find_value(block_texture_json, "textures")
					
					
				
				if is_string(block_texture_json) {
				
					var up = block_texture_json
					var down = block_texture_json
					var side = block_texture_json
					
					var north = block_texture_json
					var south = block_texture_json
					var east = block_texture_json
					var west = block_texture_json
					
					var texture_all = block_texture_json
					
					} else {
						//Placeholder textures
						var up = "stone"
						var down = "stone"
						var side = "stone"
					
						var north = "stone"
						var south = "stone"
						var east = "stone"
						var west = "stone"
					
					
						//Get actual textures	
						if ds_map_exists(block_texture_json, "up") up = ds_map_find_value(block_texture_json, "up")
						if ds_map_exists(block_texture_json, "down") down = ds_map_find_value(block_texture_json, "down")
						if ds_map_exists(block_texture_json, "side") side = ds_map_find_value(block_texture_json, "side")
						//Incase  these values arent set, set them to side.
						var north = side
						var south = side
						var east = side
						var west = side
					
						if ds_map_exists(block_texture_json, "north") north = ds_map_find_value(block_texture_json, "north")
						if ds_map_exists(block_texture_json, "south") south = ds_map_find_value(block_texture_json, "south")
						if ds_map_exists(block_texture_json, "east") east = ds_map_find_value(block_texture_json, "east")
						if ds_map_exists(block_texture_json, "west") west = ds_map_find_value(block_texture_json, "west")
					
						}				
					} else {
						var texture_all = string_replace(current_block_name, "dungeonmaster:LEVELNAME/", "")
					
						//Just incase the block has a suffix that isn't in a texture
						if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + texture_all + ".png") {
							
							if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + texture_all + "_top.png") {
							
							var texture_all_temp = string_replace(texture_all, "_slab", "")
							var texture_all_temp = string_replace(texture_all_temp, "_path", "")
							
							
							texture_all = texture_all_temp
							}
							
							//If it still doesn't exist v
							//if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + texture_all_temp + ".png") then texture_all_temp = texture_all + "_top"
							
							
							}
						
					
						var up = texture_all
						var down = texture_all
						var side = texture_all
					
						var north = texture_all
						var south = texture_all
						var east = texture_all
						var west = texture_all
						
						
						if file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + up + "_top.png") up = up + "_top"
					
						
					
						}
				#endregion
			
			
				if string_pos("path", current_block_name) >0 {
					#region Path type blocks
					
						var block_type = "path"
						var template_model = global.dataDirectory + "\\models\\block\\j_template_path.json"
						
						if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + up + ".png") up = up + "_top"
						if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + side + ".png") side = side + "_side"
						if !file_exists(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" + down + ".png") down = down + "_side"
					
						textfile_copy_replace(template_model, "%top%",  up, template_model_out)
						textfile_copy_replace(template_model_out, "%side%", side, template_model_out)
						textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
					
					
					#endregion
					}
					
				if string_pos("flower", current_block_name) > 0 or block_type = "cross" {
					#region Cross type blocks
					
						var block_type = "flower"
						var template_model = global.dataDirectory + "\\models\\block\\j_template_cross.json"
						
					
						textfile_copy_replace(template_model, "%texture_all%",  texture_all, template_model_out)
					
					
					#endregion
					}
				
				if string_pos("slab", current_block_name) >0 or string_pos("top", current_block) >0 or string_pos("bottom", current_block) >0 or string_pos("double", current_block) >0 {
					#region Slabs
					
						var temp = 0
					
						var block_type = "slab"
					#region bottom slabs
						if string_pos("bottom", current_block) > 0 {
							var temp = 1
							var template_model = global.dataDirectory + "\\models\\block\\j_template_slab.json"
							
					
							textfile_copy_replace(template_model, "%top%",  up, template_model_out)
							textfile_copy_replace(template_model_out, "%side%", side, template_model_out)
							textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
							}
						#endregion
						
					#region top slabs	
						if string_pos("top", current_block) > 0 {
							var temp = 1
							var template_model = global.dataDirectory + "\\models\\block\\j_template_slab_top.json"
							
					
							textfile_copy_replace(template_model, "%top%",  up, template_model_out)
							textfile_copy_replace(template_model_out, "%side%", side, template_model_out)
							textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
							}
						#endregion
					
					#region double slabs
						if string_pos("double", current_block) > 0 {
							var temp = 1
							var template_model = global.dataDirectory + "\\models\\block\\j_template_full_slab.json"
							
					
							textfile_copy_replace(template_model, "%top%",  up, template_model_out)
							textfile_copy_replace(template_model_out, "%side%", side, template_model_out)
							textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
							}
						#endregion		
						
						if temp = 0 {
							var temp = 1
							var template_model = global.dataDirectory + "\\models\\block\\j_template_slab.json"
					
							textfile_copy_replace(template_model, "%top%",  up, template_model_out)
							textfile_copy_replace(template_model_out, "%side%", side, template_model_out)
							textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
							}
				
						#endregion
					}
				
				if block_type = "full" {
				#region full blocks
				
					var template_model = global.dataDirectory + "\\models\\block\\j_template_full_block.json"
						
					
						textfile_copy_replace(template_model, "%top%",  up, template_model_out)
						textfile_copy_replace(template_model_out, "%bottom%", down, template_model_out)
					
						textfile_copy_replace(template_model_out, "%north%", north, template_model_out)
						textfile_copy_replace(template_model_out, "%east%", east, template_model_out)
						textfile_copy_replace(template_model_out, "%west%", west, template_model_out)
						textfile_copy_replace(template_model_out, "%south%", south, template_model_out)
					#endregion
					}
					
				
				//data\resourcepacks\squidcoast\blocks.json has up, down, side etc textures.
				//use it 
				
				}
			
				var ds = json_decode(util_file_to_string(template_model_out))
				//ds_list_add(global.ds_map_list, ds)
			
				} else {
		
			#region If the block isn't from dungeons:
			#region Get the block's json file
			
			//Get the blockstates json and decode it.
			var blockstates_js = global.dataDirectory + "blockstates\\" + string_replace(current_block_name, "minecraft:", "")
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
			
		
			var block_json = util_file_to_string(global.dataDirectory + "models\\" + string_replace(block_json, "minecraft:", "") + ".json")
			ds_map_destroy(blockstates_js)
		
			//The DS map of the minecraft model.
			var ds = json_decode(block_json)
			ds_list_add(global.ds_map_list, ds)
			
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
			obj_create_block(ds, text_file_buffer, vertice_count, vertice_texture_count, bds, mtloutput, mat_map, dungeons_id)
			
			if string_pos("leaves", current_block_name) > 0 {
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
			
			ds_map_destroy(ds)
			
		
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
