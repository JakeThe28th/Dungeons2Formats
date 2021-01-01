// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mc2obj_increment_block(){
	x_lines_done++
	if x_lines_done = xsize {
		x_lines_done = 0
		z_lines_done++
		}
	
	if z_lines_done = zsize {
		z_lines_done = 0
		y_lines_done++
		}
	
	if y_lines_done = ysize {
		blocks_done ++
		return "done"
		}
	
	if blocks_done = blocks_total return "done"
	blocks_done ++
	
}