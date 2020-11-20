///sc_draw_button(px1, py1, x1, y1, x2, y2)
///@param x1
///@param y1
///@param x2
///@param y2
///@param px1
///@param py1
function point_in_area(argument0, argument1, argument2, argument3, argument4, argument5) {
	var x1 = argument0
	var y1 = argument1
	var x2 = argument2
	var y2 = argument3
	var px1 = argument4
	var py1 = argument5

	in_x = false
	in_y = false

	if y1 < y2 {
		if py1 > y1 and py1 < y2 var in_y = true
		} //if y1 is above y2
	
	if y2 < y1 {
		if py1 > y2 and py1 < y1 var in_y = true
		} //if y2 is above y1
	
	if x1 < x2 {
		if px1 > x1 and px1 < x2 var in_x = true
		} //if x1 is to the left of x2
	
	if x2 < x1 {
		if px1 > x2 and px1 < x1 var in_x = true
		} //if x2 is above x1
	
	if in_x = true and in_y = true return true else return false


}
