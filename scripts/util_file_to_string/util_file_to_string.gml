///@param file
function util_file_to_string(argument0) {
	var file = argument0

	var txtfile = file_text_open_read(file)
	var text = ""
	do {
		text = text + file_text_read_string(txtfile)
		file_text_readln(txtfile)
	
		} until file_text_eof(txtfile)

	file_text_close(txtfile)
	
	return text


}
