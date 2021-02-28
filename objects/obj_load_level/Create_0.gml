//Create level variables based on an input name.

dir = ma_lovika + "levels\\" + global.current_level + ".json"
if !file_exists(dir) dir = ma_lovika + "levels\\" + "hm_" + global.current_level + ".json"
	json_txt = file_text_open_read(dir)
	json_string = ""
	json = -1

	repeat 6 file_text_readln(json_txt) //Bypass mojang's comment
	
	do json_string = json_string + string(file_text_readln(json_txt)) until file_text_eof(json_txt)
	//Read the json into a string
	
	file_text_close(json_txt)
	
	json = json_decode(json_string)
	
	global.current_resource_pack = json_get(json, "resource-packs", 0)
	
	global.pack_blocks = json_load(ma_resourcepacks + string_lower(global.current_resource_pack) + "\\blocks.json")
	global.pack_resources = json_load(ma_resourcepacks + global.current_resource_pack + "\\resources.json")
	global.pack_terrain_texture = json_load(ma_resourcepacks + global.current_resource_pack + "\\images\\terrain_texture.json")
	
	global.level_json = json
				
	debug_log("INFO", "Finished loading level.")
	
	instance_destroy()
