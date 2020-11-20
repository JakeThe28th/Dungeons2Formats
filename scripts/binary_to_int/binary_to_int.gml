function binary_to_int(argument0) {
	//--- init args
	  var BitStr = string(argument0); // "1111" = 15

	//--- read each digit and add total
	  var Digits = string_length(BitStr);
	  var Int = 0;
	  for(var i=0;i<Digits;i++)
	  {
	    if string_char_at(BitStr,i) == "1"
	      Int += power(2,i);
	  }
	  //show_debug_message("Int: "+string(Int));
  
	//https://www.reddit.com/r/gamemaker/comments/46cjvv/created_two_scripts_binary_conversion_and_integer/
	return Int


}
