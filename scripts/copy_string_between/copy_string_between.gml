///copy_string_between(start, end, string)
///@param start
///@param end
///@param string
function copy_string_between(argument0, argument1, argument2) {
	var start_c = argument0
	var end_c = argument1
	var string_c = argument2

	var out = ""
	var i = 0

	var started = false

	repeat string_length(string_c) {
		var str_char_at = string_char_at(string_c, i)
	
		if str_char_at = end_c break
	
		if started = true {
			out = out + string(str_char_at)
			}
	
		if str_char_at = start_c started = true
	
		i++
		}
	
	return out


}
