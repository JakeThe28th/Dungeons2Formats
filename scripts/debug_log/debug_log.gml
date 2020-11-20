///debug_log(string)
///@param type
///@param string
function debug_log(argument0, argument1) {
	var str = argument1
	var type = argument0
	show_debug_message(str)

	var textfile = file_text_open_append(working_directory + "log.txt")
	file_text_write_string(textfile,"[" + string(type) + "] " + string(current_time) + ": " +  str)
	file_text_writeln(textfile)
	file_text_write_string(textfile, "")
	file_text_close(textfile)


}
