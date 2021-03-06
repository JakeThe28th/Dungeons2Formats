
		if is_undefined(global.selected_object) {
			show_error("You need to select a tile first", false)
			instance_destroy()
			}
	
		//Get the block buffers
		var blockstring = json_get(global.group_json, "objects", global.selected_object, "blocks") //Open
		var block_buffer_compressed = buffer_base64_decode(blockstring) //Base64 decode
		blockdata = buffer_decompress(block_buffer_compressed) //Decompress
		
		//Get the size of the structure
		xsize = json_get(global.group_json, "objects", global.selected_object, "size", 0)
		ysize = json_get(global.group_json, "objects", global.selected_object, "size", 1)
		zsize = json_get(global.group_json, "objects", global.selected_object, "size", 2)
		

		//Delete the temporary buffers.
		buffer_delete(block_buffer_compressed)
		
		i = 0
		blocks_total = xsize*ysize*zsize
		blocks_done = 1
		
		//As of flames of the nether, the block format is either 1 byte per block or 2 bytes per block.
		current_id_scale = 1 //! byte
		if blocks_total*2 < buffer_get_size(blockdata) current_id_scale = 2 //If blocks*2 is less than the buffer size, new format, otherwise, old.
		
		x_lines_done = 1
		y_lines_done = 0
		z_lines_done = 0
		
		//x_lines_done = 100
		//y_lines_done = 35
		//z_lines_done = 400
		
		culling = 1
		//culling = 0
		
	

//Create output file.
outputfilename = get_save_filename("obj files|*.obj", "")
if outputfilename = "" {
	
	buffer_delete(blockdata)
	obj_gui.grayed_out_buttons = false
	
	instance_destroy()
	}
//var outputfilename = "C:\\Users\\nickl\\Desktop\\OBJTest\\campfire.obj"
//txtoutput = file_text_open_write(outputfilename)
mtlfilename = string_delete(outputfilename, string_length(outputfilename)-2, 3) + "mtl"
mtloutput = file_text_open_write(mtlfilename)

//For building faces later, we need to keep track of the vertices in the file.
vertice_count = 0
vertice_texture_count = 0

//A ds map of texture material names
mat_map = ds_map_create()


blocks_skipped = 0
blocks_created = 0

bds = ds_map_create() //Used to store whether or not a side of a face is transparent or not.

start_seconds = current_time / 1000 //Used to count the time which the model took to create

text_file_buffer = buffer_create(1, buffer_grow, 1)

air_blocks_skipped = 0