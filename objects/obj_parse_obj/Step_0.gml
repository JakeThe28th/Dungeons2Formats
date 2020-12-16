frame_time = current_time + 250
repeat 1000000 {

var p = parse_obj()
//Execute a parsing step.

//current_block = "stone"

var loading_bar_text_type = "small"
var loading_bar_text = "Converting blocks to obj. Block count: " + string(blocks_total) + " Blocks done: " + string(blocks_done) + ", Current block: " + current_block

//gui_update_loadingbar("small", loading_bar_text, blocks_done / blocks_total, color_loading_done, color_box, "MainLoader")
obj_gui.loading_bar_done = (blocks_done/blocks_total)

//if blocks_done = max_blocks_per_file*block_file_cycles {
//	block_file_cycles++
//	
//	file_text_close(txtoutput)
//	txtoutput = file_text_open_write(string_replace_all(outputfilename, ".obj", "")+"_"+string(block_file_cycles)+".obj")
//	debug_log("MC2OBJ", "Split obj file")
//	//WIIIIP CHANGE MESSAGE AND
//	}

if p = "done" {
	done = p
	
	//file_text_close(txtoutput)
	buffer_save(text_file_buffer, outputfilename)
	file_text_close(mtloutput)
	
	debug_log("MC2OBJ", "Finished building model.")
	debug_log("MC2OBJ", "Total blocks: " + string(blocks_total))
	debug_log("MC2OBJ", "Blocks created: " + string(blocks_created))
	debug_log("MC2OBJ", "Blocks skipped: " + string(blocks_skipped))
	
	var end_time = current_time / 1000
	debug_log("MC2OBJ", "Time: " + string((end_time - start_seconds)) + " seconds.")
	debug_log("MC2OBJ", "Started at: " + string(start_seconds))
	debug_log("MC2OBJ", "Ended at: " + string(end_time))
	
	debug_log("MC2OBJ", "Average Non-Air block time: " + string(end_time / blocks_created+(blocks_skipped-air_blocks_skipped)))

	buffer_delete(blockdata)
	buffer_delete(blockstatedata)
	obj_gui.grayed_out_buttons = false
	
	instance_destroy()
	break;
	}
//If loop is done

if frame_time <= current_time break;
} 