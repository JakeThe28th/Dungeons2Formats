if instance_exists(obj_parse_filter) {
	if obj_parse_filter.done = "done" {
	
		ds = obj_parse_filter.ds
		instance_destroy(obj_parse_filter)
		
		obj_gui.grayed_out_buttons = false
		instance_destroy()
		//Destroy the filter object
		} else {
			done_percent = obj_parse_filter.done_lines / obj_parse_filter.total_lines
			obj_gui.loading_bar_done = done_percent
			}
}
