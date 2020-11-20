///order_least_greatest
///@param number1
///@param number2
function order_least_greatest(argument0, argument1) {
	var num1 = argument0
	var num2 = argument1

	if num1 < num2 { //Make X1 on the left, and X2 on the right.
			var outnum1 = num1;
			var outnum2 = num2;
			} else {
				var outnum2 = num1;
				var outnum1 = num2;
				}
			
			
		var array = array_create(2, "")
	
		array[0] = num1
		array[1] = num2
	
		return array


}
