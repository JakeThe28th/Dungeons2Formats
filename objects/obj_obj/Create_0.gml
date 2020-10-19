/// @description Insert description here
// You can write your code in this editor
file = get_open_filename("MCJS files|*.json", "")
//file = "C:\Users\\nickl\\Desktop\\OBJTest\\models\\block\\campfire.json"


var text = util_file_to_string(file)
	

//Create output file.
var outputfilename = get_save_filename("obj files|*.obj", "")
//var outputfilename = "C:\\Users\\nickl\\Desktop\\OBJTest\\campfire.obj"
var mtlfilename = string_delete(outputfilename, string_length(outputfilename)-2, 3) + "mtl"
var mtloutput = file_text_open_write(mtlfilename)

//For building faces later, we need to keep track of the vertices in the file.
var vertice_count = 0
var vertice_texture_count = 0

//The DS map of the minecraft model.
var ds = json_decode(text)

//A ds map of the surrounding 6 blocks (To know whether or not to cull a face)
var bds = ds_map_create()
	ds_map_add(bds, "up", 1)
	ds_map_add(bds, "down", 1)
	ds_map_add(bds, "north", 1)
	ds_map_add(bds, "south", 1)
	ds_map_add(bds, "east", 1)
	ds_map_add(bds, "west", 1)
	//could probably use booleans, solid and transparent (0 and 1) for my efficiency

//A ds map of texture material names
var mat_map = ds_map_create()

//The ID of the block if it's a minecraft dungeons block. Used to look up textures.
var dungeons_id = 0

var buffer = 1 //buffer 
obj_create_block(ds, buffer, vertice_count, vertice_texture_count, bds, mtloutput, mat_map, dungeons_id)
file_text_close(mtloutput)