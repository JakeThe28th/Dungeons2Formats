//Create the NBT base DS
nbt_ds = ds_map_create()
nbt_ds_list = ds_list_create()
	ds_map_add(nbt_ds, "name", "Schematic")
	ds_map_add(nbt_ds, "name_length", 9)
	ds_map_add(nbt_ds, "type", 10)
	ds_map_add_list(nbt_ds, "payload", nbt_ds_list)
	//Add root values.
	
		
		#region Metadata Tag
			var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "Metadata")
			ds_map_add(temp, "name_length", 8)
			ds_map_add(temp, "type", 10)
			ds_map_add_list(temp, "payload", metadata_list)
			//Add tag info
		
				ds_map_add(metadata_string, "name", "FromMap")
				ds_map_add(metadata_string, "name_length", 7)
				ds_map_add(metadata_string, "type", 8)
				ds_map_add(metadata_string, "payload", "Note to self: replace with tile name")
				ds_map_add(metadata_string, "length", string_length(ds_map_find_value(metadata_string, "payload")))
				//Add the FromMap metadata tag.
		
				#endregion
		
		#region Version Tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "Version")
			ds_map_add(temp, "name_length", 7)
			ds_map_add(temp, "type", 3)
			ds_map_add_list(temp, "payload", 1)
			//Add tag info
		#endregion

		xsize = json_get(global.group_json, "objects", global.selected_object, "size", 0)
		ysize = json_get(global.group_json, "objects", global.selected_object, "size", 1)
		zsize = json_get(global.group_json, "objects", global.selected_object, "size", 2)
		#region X size Tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "Width")
			ds_map_add(temp, "name_length", 5)
			ds_map_add(temp, "type", 2)
			ds_map_add_list(temp, "payload", xsize)
			//Add tag info
		#endregion
		#region Y size Tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "Length")
			ds_map_add(temp, "name_length", 6)
			ds_map_add(temp, "type", 2)
			ds_map_add_list(temp, "payload", ysize)
			//Add tag info
		#endregion
		#region Z size Tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			
			ds_map_add(temp, "name", "Height")
			ds_map_add(temp, "name_length", 6)
			ds_map_add(temp, "type", 2)
			ds_map_add_list(temp, "payload", zsize)
			//Add tag info
		#endregion
		
		#region Tile entities Tag
		var temp = ds_map_create()
			ds_list_add(nbt_ds_list, temp)
			ds_list_mark_as_map(nbt_ds_list, ds_list_size(nbt_ds_list)-1)
		
			var metadata_list = ds_list_create()
			var metadata_string = ds_map_create()
			ds_list_add(metadata_list, metadata_string)
			var list_fake = ds_list_create()
			
			ds_map_add(temp, "name", "TileEntities")
			ds_map_add(temp, "name_length", 12)
			ds_map_add(temp, "type", 9)
			ds_map_add(temp, "list_type", 10)
			ds_map_add(temp, "list_length", 0)
			ds_map_add_list(temp, "payload", list_fake)
			//Add tag info
		#endregion
		
		pallete_list = ds_list_create()
		pallete_max = 0
		//miblockdata = buffer_create(xsize*ysize*zsize, buffer_fixed, 1)
		miblockdata = array_create(xsize*ysize*zsize, 0)
		//Init variables for later
		
		var blockstring = json_get(global.group_json, "objects", global.selected_object, "blocks") //Open
		var block_buffer_compressed = buffer_base64_decode(blockstring) //Base64 decode
		var block_buffer_decompressed = buffer_decompress(block_buffer_compressed) //Decompress
		
		blockdata = buffer_create(xsize*ysize*zsize, buffer_fixed, 1)
		blockstatedata = buffer_create(xsize*ysize*zsize/2, buffer_fixed, 1)
			buffer_copy(block_buffer_decompressed, 0, xsize*ysize*zsize, blockdata, 0)
			buffer_copy(block_buffer_decompressed, xsize*ysize*zsize, xsize*ysize*zsize*1.5, blockstatedata, 0)
			//Turn the blockstring into a buffer.

		buffer_delete(block_buffer_compressed)
		buffer_delete(block_buffer_decompressed)
		
		
		i = 0
		blocks_total = xsize*ysize*zsize
		blocks_done = 1
		
		x_lines_done = 1
		y_lines_done = 0
		z_lines_done = 0
		
		pallete_fake = ds_map_create()

//Add the metadata, size, and a blank palette

//Set up loop variables.

//To check pallet for same entry, just use the nbt from parsing and check to ds map's ID.

//Place blocks with math. (mind mi's storage difference.)

		//preview_surface = surface_create(xsize*16, (ysize*6)+(ysize*10))
		//preview_sprite = sprite_create_from_surface(preview_surface, 0, 0, xsize*16, (ysize*6)+(ysize*10), 0, 0, 0, 0)