///get_block_dungeons(x, y, z)
///@param x
///@param y
///@param z
///@param x size
///@param y size
///@param z size
function get_block_pos_dungeons(argument0, argument1, argument2, argument3, argument4, argument5) {
	var x1 = argument0
	var y1 = argument1
	var z1 = argument2
	var x_size = argument3
	//var y_size = argument4
	var z_size = argument5

	var block = x1 + (x_size*z1) + ((z_size*x_size)*y1)
	return block

	//Gets a block position from the dungeons buffer at position


}
