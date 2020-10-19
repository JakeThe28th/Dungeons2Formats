///convert_blocks(i)
///@param increment
function parse_schematic() {



	var block = (x_lines_done + (xsize*z_lines_done) + ((zsize*xsize)*y_lines_done)) -1
		buffer_seek(blockdata, buffer_seek_start, block)
	
		var block_floor = floor(block/2)
		buffer_seek(blockstatedata, buffer_seek_start, block_floor)

		var block_byte = buffer_read(blockdata, buffer_u8)
		var block_state_byte = buffer_read(blockstatedata, buffer_u8)
	
		if block_floor < ceil(block/2) {
			//This is the second state.
		
			var blockstate = string_copy(string(int_to_binary(block_state_byte, 8)), 3, 4)
			var blockstate = binary_to_int(blockstate)
			} else { 
			//This is the first state.	
			
				var blockstate = string_copy(string(int_to_binary(block_state_byte, 8)), 0, 4)
				var blockstate = binary_to_int(blockstate)
				} 
			
			//need to get block from table
			//pallete is int, name is block name with state appended, then theres the entry number
		
		
			//Write the block name [ state, state ] and compare to see if there exists one in fakePallete. if not, add,
		
			var cblock = ds_map_find_value(global.filter, string(block_byte))
			if cblock = undefined { 
				var cstate = undefined
				debug_log("MC2SCHEM", "Missing block. X: " + string(x_lines_done) + " Y: " + string(y_lines_done) + " Z: " + string(z_lines_done) + " ID: " + string(block_byte) + " State:" + string(blockstate))
				} else var cstate = ds_map_find_value(cblock, string(blockstate))
		
		
			if cstate = undefined debug_log("MC2SCHEM", "Missing blockstate. X: " + string(x_lines_done) + " Y: " + string(y_lines_done) + " Z: " + string(z_lines_done) + " ID: " + string(block_byte) + " State:" + string(blockstate))
		
			if cstate != undefined {
		
			pallet_check_string = cstate[? "name_raw"]
			if string_pos("dungeonmaster:", pallet_check_string) >0 pallet_check_string = string_replace(pallet_check_string, "dungeonmaster:LEVELNAME/", "minecraft:dungeons_")
		
			if ds_map_find_value(pallete_fake, pallet_check_string) = undefined {
				ds_map_add(pallete_fake, pallet_check_string, ds_map_size(pallete_fake)+1)
				var current_block_entry = ds_map_size(pallete_fake)
			
			#region Add pallete entry
					var temp = ds_map_create()
						ds_list_add(pallete_list, temp)
						ds_list_mark_as_map(pallete_list, ds_list_size(pallete_list)-1)
		
						var metadata_list = ds_list_create()
						var metadata_string = ds_map_create()
						ds_list_add(metadata_list, metadata_string)
			
						ds_map_add(temp, "name", pallet_check_string)
						ds_map_add(temp, "name_length", string_length(pallet_check_string))
						ds_map_add(temp, "type", 3)
						ds_map_add_list(temp, "payload", ds_list_size(pallete_list))
						//Add tag info
					
						pallete_max = ds_list_size(pallete_list)
		#endregion
				} else {
					var current_block_entry = ds_map_find_value(pallete_fake, pallet_check_string)
					}
			
			var block = x_lines_done + (xsize*z_lines_done) + ((ysize*xsize)*y_lines_done)
		
			//buffer_seek(miblockdata, buffer_seek_start, block)
			//buffer_write(miblockdata, buffer_s8, real(current_block_entry))
			miblockdata[block] = real(current_block_entry)
		
			}

	x_lines_done++
	if x_lines_done = xsize {
		x_lines_done = 0
		z_lines_done++
		}
	
	if z_lines_done = zsize {
		z_lines_done = 0
		y_lines_done++
		}
	
	if y_lines_done = ysize {
		return "done"
		}
	
	blocks_done ++





}
