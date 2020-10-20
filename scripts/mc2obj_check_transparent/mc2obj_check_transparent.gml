///mc2obj_check_transparent(xoffset, offset, offset)
///@param xoffset
///@param yoffset
///@param zoffset

function mc2obj_check_transparent(xoffset, yoffset, zoffset) {
	var tmp_x = x_lines_done + xoffset
	var tmp_y = y_lines_done + yoffset
	var tmp_z = z_lines_done + zoffset
	

	#region Read the block's ID
		var block_sur = (tmp_x + (xsize*tmp_z) + ((zsize*xsize)*tmp_y)) -1
		if tmp_x > xsize return 1
		if tmp_y > ysize return 1
		if tmp_z > zsize return 1
		if tmp_x < 0 return 1
		if tmp_y < 0 return 1
		if tmp_z < 0 return 1
		if block_sur < 0 return 1
		buffer_seek(blockdata, buffer_seek_start, block_sur)
	
	
		if floor(block_sur/2) >= buffer_get_size(blockstatedata) return 1
		buffer_seek(blockstatedata, buffer_seek_start, floor(block_sur/2))

		//Read bytes
		var block_sur_byte = buffer_read(blockdata, buffer_u8)
		if block_sur_byte = 0 return 1
	
		var block_sur_byte_s = buffer_read(blockstatedata, buffer_u8)
	
			//Get the block name, and state from its ID.
			var block_sur_c = ds_map_find_value(global.filter, string(block_sur_byte))
			if block_sur_c = undefined { 
				return 1 //Return transparent
				}
			
	#region Get blockstate number
		if floor(block_sur/2) < ceil(block_sur/2) {
			//This is the second state.
		
			var blockstate = string_copy(string(int_to_binary(block_sur_byte_s, 8)), 3, 4)
			var blockstate = binary_to_int(blockstate)
			} else { 
			//This is the first state.	
			
				var blockstate = string_copy(string(int_to_binary(block_sur_byte_s, 8)), 0, 4)
				var blockstate = binary_to_int(blockstate)
				} 
			
		#endregion
		

	#endregion
			block_sur_c = ds_map_find_value(block_sur_c, string(blockstate))
		
			if is_undefined(block_sur_c) return 1
		
			block_sur_c = block_sur_c[? "Name"]
		
			returne = 0
			
			if string_pos("slab", block_sur_c) > 0 return 1
			if string_pos("flower", block_sur_c) > 0 return 1
			if string_pos("path", block_sur_c) > 0 return 1
			if string_pos("leaves", block_sur_c) > 0 return 1
			if string_pos("fern", block_sur_c) > 0 return 1
			if string_pos("tulip", block_sur_c) > 0 return 1
		
			switch(block_sur_c) {
				case "minecraft:air": var returne = 1; break;
				case "minecraft:water": var returne = 1; break;
				case "minecraft:lava": var returne = 1; break;
				case "minecraft:glass": var returne = 1; break;
				case "minecraft:oak_fence": var returne = 1; break;
				case "minecraft:dark_oak_fence": var returne = 1; break;
				case "minecraft:birch_fence": var returne = 1; break;
				case "minecraft:spruce_fence": var returne = 1; break;
				case "minecraft:jungle_fence": var returne = 1; break;
				case "minecraft:acacia_fence": var returne = 1; break;
				case "minecraft:chorus_flower": var returne = 1; break;
				
				case "dungeonmaster:LEVELNAME/flower_rose": var returne = 1; break;
				case "dungeonmaster:LEVELNAME/flower_oxeye_daisy": var returne = 1; break;
				case "dungeonmaster:LEVELNAME/tallgrass": var returne = 1; break;
				case "dungeonmaster:LEVELNAME/fern": var returne = 1; break;
			
				}
		//debug_log("MC2OBJ", "Deleted block '" + block_sur_c + "'")
			
		return returne


}
