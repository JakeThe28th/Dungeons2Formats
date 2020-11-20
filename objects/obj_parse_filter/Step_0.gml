frame_time = current_time + 500
repeat 1000 {

var p = parse_filter(file, i, ds)
//Execute a parsing step.
i++
//Increment.

obj_gui.loading_bar_done = done_lines / total_lines

if p = "done" {
	global.filter = ds
	global.block_textures = json_decode(util_file_to_string(global.dataDirectory + "\\resourcepacks\\" + global.current_resource_pack + "\\blocks.json"))
	debug_log("INFO", "Finished loading block filter.")
	done = p
	json_destroy(file)
	break
	}
//If loop is done, destroy loaded file.

if frame_time <= current_time break;
} 