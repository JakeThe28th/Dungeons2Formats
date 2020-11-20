///nbt_to_string(inc)
///@param inc
function nbt_to_string(argument0) {
	inc = argument0

	var oddeven;
	if floor(inc/2) != inc/2 or inc = 0 oddeven = 0 else oddeven = 1

	var blockcurrent = ds_list_find_value(blockslist, inc)
	var pos = ds_list_find_value(blockcurrent, 0)
		pos = ds_map_find_value(pos, "payload")
		var xpos = ds_list_find_value(pos, 0)
		var ypos = ds_list_find_value(pos, 1)
		var zpos = ds_list_find_value(pos, 2)

	var state = ds_list_find_value(blockcurrent, 1)
	var block_pallet_number = ds_map_find_value(state, "payload")
	//Get the block compound and the state and pos tags.

	var palette_current = ds_list_find_value(palette, block_pallet_number)
	if ds_list_size(palette_current) > 1 { 
		var temp = ds_list_find_value(palette_current, 0)
		if ds_map_find_value(temp, "name") = "Name" var name = temp else var name = ds_list_find_value(palette_current, 1)
		} else var name = ds_list_find_value(palette_current, 0)
	
	var block_id = ds_map_find_value(name, "payload")
	var block_id = ds_map_find_value(block_id, "payload")
		//Get block java ID

	var txtfile = file_text_open_read(global.realfilter)
	var temp = "no"
	do {
		var strtemp = file_text_read_string(txtfile)
		file_text_readln(txtfile)
	
		if string_pos(block_id, strtemp) > 0 {
			strtemp = string_replace(strtemp, "\"", "")
			strtemp = util_split_string(strtemp, ";")
			strtemp = util_split_string(strtemp[0], ",")
		
			var block_id_dungeons = strtemp[0]
			var blockstate = strtemp[1]
		
			string_replace(block_id_dungeons, "  ", "")
		
			temp = "yes"
			}

		} until file_text_eof(txtfile) or temp = "yes"
	file_text_close(txtfile)
	
		if temp = "no" {
			block_id_dungeons = 7
			blockstate = 0
			//If the block isn't in the map, set it to SQCO bedrock.
			}
	



	buffer_seek(buffer_blocks, buffer_seek_start, get_block_pos_dungeons(xpos, ypos, zpos, x_size, y_size, z_size))
	buffer_write(buffer_blocks, buffer_u8, real(block_id_dungeons))

	blockstate = int_to_binary(blockstate, 4)

	if oddeven = 1 {
		var statebyte = string(blockstate) + string(blockstatedata[0])
		var statebytenum = binary_to_int(statebyte)
	
		buffer_seek(buffer_states, buffer_seek_start, floor(get_block_pos_dungeons(xpos, ypos, zpos, x_size, y_size, z_size)/2))
		buffer_write(buffer_states, buffer_u8, statebytenum)
	
		} else blockstatedata[0] = blockstate



	inc++


}
