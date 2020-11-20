///textfile_copy_replace(file, phrase, newphrase, output)
///@param file
///@param phrase
///@param newphrase
///@param output
function textfile_copy_replace(argument0, argument1, argument2, argument3) {
	var file = argument0
	var phrase = argument1
	var newphrase = argument2
	var output = argument3

	var file = file_text_open_read(file)
	var output = file_text_open_write(output)

	do { 
		var current_line = file_text_read_string(file)
		file_text_readln(file)
	
		current_line = string_replace_all(current_line, phrase, newphrase)
	
		file_text_write_string(output, current_line)
		file_text_writeln(output)
		} until file_text_eof(file)
	
	file_text_close(file)
	file_text_close(output)


}
