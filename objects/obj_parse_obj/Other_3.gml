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
	
	debug_log("MC2OBJ", "Average Non-Air block time: " + string(end_time / blocks_created))

	buffer_delete(blockdata)
	buffer_delete(blockstatedata)
	obj_gui.grayed_out_buttons = false
	
	instance_destroy()