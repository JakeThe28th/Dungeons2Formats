frame_time = current_time + 250
repeat 20 {

var p = parse_schematic()
//Execute a parsing step.

obj_gui.loading_bar_done = blocks_done / blocks_total
obj_gui.loading_bar_text_type = "small"
obj_gui.loading_bar_text = "Converting blocks to schematic. Block count: " + string(blocks_total) + " Blocks done: " + string(blocks_done) + " Estimated time: " + string(((blocks_total/fps)/60)-((blocks_done/fps)/60)) + " minutes. Current block: " + pallet_check_string

if p = "done" {
	done = p
	
	#region Add blockdata
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "BlockData")
			ds_map_add(temp, "name_length", 9)
			ds_map_add(temp, "type", 7)
			ds_map_add(temp, "payload", miblockdata)
			ds_map_add(temp, "length", array_length_1d(miblockdata))
			//Add tag info
		#endregion
	
	#region Palette Tag
			var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
			
			ds_map_add(temp, "name", "Palette")
			ds_map_add(temp, "name_length", 7)
			ds_map_add(temp, "type", 10)
			ds_map_add_list(temp, "payload", pallete_list)
			//Add tag info
			
			#endregion
	
	#region Palette max tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "PaletteMax")
			ds_map_add(temp, "name_length", 10)
			ds_map_add(temp, "type", 3)
			ds_map_add_list(temp, "payload", pallete_max)
			//Add tag info
		#endregion
	
	outbuffer = buffer_create(1, buffer_grow, 1)
	var d = ds_list_create()
	ds_list_add(d, nbt_ds)
	ds_list_mark_as_map(d, 0)
	
	write_tag_compound(d, outbuffer)
	
	buffer_save(outbuffer, get_save_filename("Schematics|*.schematic", "struct.schematic"))
	
	obj_gui.grayed_out_buttons = false
	instance_destroy()
	}
//If loop is done

if frame_time <= current_time break;
} 
