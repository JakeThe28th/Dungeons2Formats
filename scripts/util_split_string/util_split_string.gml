///split_string(string, char)
///@param string
///@param character to split at
function split_string(argument0, argument1) {
	var stringsplit = argument0
	var charsplit = argument1
	var array = array_create(1, "")

	var i=1
	var o=0
	var accumulate = ""
	repeat string_length(stringsplit) { 
		var str_char_at = string_char_at(stringsplit, i)
	
		if str_char_at = charsplit  { 
			accumulate = string_replace(accumulate, chr(9), "")
			array[o] = accumulate 
			o++
			accumulate = ""
			} else if str_char_at !=chr(9) accumulate = accumulate + str_char_at
		i++
		}
	
	accumulate = string_replace(accumulate, chr(9), "")
	accumulate = string_replace(accumulate, "\n", "")
	accumulate = string_replace(accumulate, "\r", "")
	array[o] = accumulate 
	return array


}
