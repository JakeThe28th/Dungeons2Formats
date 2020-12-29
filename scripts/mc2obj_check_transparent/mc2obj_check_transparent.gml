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

		//Read bytes
		var block_sur_byte = buffer_read(blockdata, buffer_u8)
		if block_sur_byte = 0 return 1
	
			//Get the block name from its ID.
			var block_sur_c = ds_map_find_value(global.filter, string(block_sur_byte))
			if block_sur_c = undefined { 
				return 1 //Return transparent
				}
		
	#endregion
			returne = 0
			
			if string_pos("slab", block_sur_c) > 0 return 1
			if string_pos("flower", block_sur_c) > 0 return 1
			if string_pos("path", block_sur_c) > 0 return 1
			if string_pos("leaves", block_sur_c) > 0 return 2
			if string_pos("fern", block_sur_c) > 0 return 1
			if string_pos("tulip", block_sur_c) > 0 return 1
		
			switch(block_sur_c) {
				case "air": var returne = 1; break;
				case "water": var returne = 1; break;
				case "lava": var returne = 1; break;
				case "glass": var returne = 1; break;
				case "oak_fence": var returne = 1; break;
				case "dark_oak_fence": var returne = 1; break;
				case "birch_fence": var returne = 1; break;
				case "spruce_fence": var returne = 1; break;
				case "jungle_fence": var returne = 1; break;
				case "acacia_fence": var returne = 1; break;
				case "chorus_flower": var returne = 1; break;
				
				case "flower_rose": var returne = 1; break;
				case "flower_oxeye_daisy": var returne = 1; break;
				case "tallgrass": var returne = 1; break;
				case "fern": var returne = 1; break;
			
				}
		//debug_log("MC2OBJ", "Deleted block '" + block_sur_c + "'")
			
		return returne


}
