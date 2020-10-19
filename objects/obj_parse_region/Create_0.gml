//Get level file.
var winusername = environment_get_variable("USERNAME")
level_dat = get_open_filename("World level.dat|.dat", "C:\\Users\\" + winusername + "\\AppData\\Roaming\\.minecraft\\saves")

	
	//Get object size.
	xsize = json_get(obj_gui.selected_group, "objects", obj_gui.selected_object, "size", 0)
	ysize = json_get(obj_gui.selected_group, "objects", obj_gui.selected_object, "size", 1)
	zsize = json_get(obj_gui.selected_group, "objects", obj_gui.selected_object, "size", 2)
		
	i = 0
	blocks_total = xsize*ysize*zsize
	blocks_done = 1
		
	x_lines_done = 1
	y_lines_done = 0
	z_lines_done = 0