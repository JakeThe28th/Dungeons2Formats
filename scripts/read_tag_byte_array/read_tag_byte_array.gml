///read_tag_string(buff)
///@param buff
function read_tag_byte_array(argument0) {
	var buffer = argument0
	var array = array_create(1, 0)

	var length = read_tag_int(buffer)
	//Get big endian short short 'length'

	var i = 0
	repeat length {
		var temp = buffer_read(buffer, buffer_s8)
		array[i] = temp
	
		i++
		}
	//Write 'length' bytes from the file's buffer into array
	

	var return_ds = ds_map_create()
	ds_map_add(return_ds, "payload", array)
	ds_map_add(return_ds, "length", length)
	//Add payload and length to the return DS map.

	return return_ds


}
