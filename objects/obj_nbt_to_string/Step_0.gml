if inc < x_size*z_size*y_size-1 nbt_to_string(inc)
//Execute a step.

obj_gui.loading_bar_done = inc / (x_size*z_size*y_size)

obj_gui.loading_bar_text = "Converting NBT to Blockstring using " + global.current_resource_pack + " filter. Predicted time: " + string(((x_size*z_size*y_size)/fps)/60) + " minutes"
obj_gui.loading_bar_text_type = "small"

if inc = x_size*z_size*y_size - 1 {
	buffer_copy(buffer_states, 0, buffer_get_size(buffer_states), buffer_blocks, buffer_get_size(buffer_blocks))
	
	compressed = buffer_compress(buffer_blocks, 0, buffer_get_size(buffer_blocks))
	
	var output = buffer_base64_encode(compressed, 0, buffer_get_size(buffer_blocks))
	
	clipboard_set_text(output)
	show_message(output)
	get_string("Here's the output", output)
	
	buffer_delete(buffer_states)
	buffer_delete(buffer_blocks)
	buffer_delete(compressed)
			
	ds_map_destroy(obj_nbt_to_string.nbt)
	obj_gui.loading_bar_text_type = "normal"
	}