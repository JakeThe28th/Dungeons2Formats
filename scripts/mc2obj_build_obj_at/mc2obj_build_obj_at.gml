// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mc2obj_build_obj_at(input_file, output_file, xpos, ypos, zpos){
	
	var vertice_count_script = 0
	var vertice_texture_count_script = 0
	var file = file_text_open_read(input_file)
	do {
		var str = file_text_read_string(file)
		file_text_readln(file)
		
		str = split_string(str, " ")
		
		switch (str[0]) {
			case "v":
			buffer_write(output_file, buffer_text, "v ")
			buffer_write(output_file, buffer_text, string(real(str[1])+xpos) + " ")
			buffer_write(output_file, buffer_text, string(real(str[2])+ypos) + " ")
			buffer_write(output_file, buffer_text, string(real(str[3])+zpos))
			buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			vertice_count_script++
			break;
			
			case "vt":
			buffer_write(output_file, buffer_text, "vt ")
			buffer_write(output_file, buffer_text, str[1] + " ")
			buffer_write(output_file, buffer_text, str[2])
			buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			vertice_texture_count_script++
			break;
			
			case "f":
				buffer_write(output_file, buffer_text, "f ")
				var script_i = 1
				repeat array_length(str)-1 {
					
					var strtemp = split_string(str[script_i], "/")
								
					buffer_write(output_file, buffer_text, string(real(strtemp[0])+vertice_count) + "/")
					buffer_write(output_file, buffer_text, string(real(strtemp[1])+vertice_texture_count) + " ")
					
					script_i++
					}
					
					buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			//vertice count + number in 1/1/1, then add the amount built (in v keep track) to vertice count.
			break;
			
			}
		
		} until file_text_eof(file)
		
		vertice_count += vertice_count_script
		vertice_texture_count += vertice_texture_count_script
		file_text_close(file)
		
		buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
	}