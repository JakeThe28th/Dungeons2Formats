function obj_create_block(ds_map, buffer, v_count, vt_count, surrounding, mtl, mat_map, dungeons_id) {
	
	if !ds_map_exists(ds_map, "textures") {
		if dungeons_id = 0 {
			debug_log("MC2OBJ", "Model is missing textures!")
			show_error("Model has no textures!", false)
			return -1
			} else {
				//Minecraft dungeons texture handling.
				}
		}
	
	//Get texture shorthands (eg #top)
	var textures = ds_map_find_value(ds_map, "textures")
	var model_texture_ds = ds_map_create()
		var temp = ds_map_find_first(textures)
		repeat ds_map_size(textures) {
		
			ds_map_add(model_texture_ds, "#" + temp, ds_map_find_value(textures, temp))
		
			if !ds_map_exists(mat_map, ds_map_find_value(textures, temp)) {
				ds_map_add(mat_map, ds_map_find_value(textures, temp), ds_map_find_value(textures, temp))
			
			if dungeons_id != "dungeons" {
			#region mtl nonsense
				file_text_write_string(mtl, "newmtl " + ds_map_find_value(textures, temp))
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ns 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ka 0.2 0.2 0.2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Kd 1 1 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Ks 0 0 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# map_Ka " + "textures/" + string_replace(ds_map_find_value(textures, temp), "minecraft:", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# for G3D, to make textures look blocky:")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "map_Kd " + "textures/" + string_replace(ds_map_find_value(textures, temp), "minecraft:", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# illum 2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# d 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Tr 0")
				file_text_writeln(mtl)
				file_text_writeln(mtl)
				file_text_writeln(mtl)
			#endregion
				} else {
					#region mtl nonsense
				file_text_write_string(mtl, "newmtl " + ds_map_find_value(textures, temp))
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ns 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ka 0.2 0.2 0.2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Kd 1 1 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Ks 0 0 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# map_Ka " + "resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" +string_replace(ds_map_find_value(textures, temp), "minecraft:block/", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# for G3D, to make textures look blocky:")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "map_Kd " + "resourcepacks\\" + global.current_resource_pack + "\\images\\blocks\\" +string_replace(ds_map_find_value(textures, temp), "minecraft:block/", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# illum 2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# d 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Tr 0")
				file_text_writeln(mtl)
				file_text_writeln(mtl)
				file_text_writeln(mtl)
			#endregion
					}
					
				}			
		
			temp = ds_map_find_next(textures, temp)
			}


	if !ds_map_exists(ds_map, "elements") {
		do { 
		if !ds_map_exists(ds_map, "parent") {
			//If there's no parent, throw an error and exit script.
			debug_log("MC2OBJ", "Model is missing elements! '" + current_block + "'")
			//show_error("Model has no elements!", false)
			return -1
			}
		
		//Otherwise, find this model's parent and use the elements there.
		var parent = ds_map_find_value(ds_map, "parent")
		var text = util_file_to_string("C:\\Users\\nickl\\Desktop\\OBJTest\\models\\" + string_replace(string_replace(parent, "minecraft:", ""), "/", "\\") + ".json")
			ds_map_destroy(ds_map)
			ds_map = json_decode(text)
	


		//Get texture shorthands (eg #top)
		if ds_map_exists(ds_map, "textures") {
		var textures = ds_map_find_value(ds_map, "textures")
	
		var temp = ds_map_find_first(textures)
	
			repeat ds_map_size(textures) {
				if ds_map_exists(model_texture_ds, ds_map_find_value(textures, temp)) {
					var tex_temp = ds_map_find_value(model_texture_ds, ds_map_find_value(textures, temp))
					} else {
						var tex_temp = ds_map_find_value(textures, temp)
					
						if !ds_map_exists(mat_map, ds_map_find_value(textures, temp)) {
						ds_map_add(mat_map, ds_map_find_value(textures, temp), ds_map_find_value(textures, temp))
			
					#region mtl nonsense
				file_text_write_string(mtl, "newmtl " + ds_map_find_value(textures, temp))
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ns 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ka 0.2 0.2 0.2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Kd 1 1 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Ks 0 0 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# map_Ka " + "textures/" + string_replace(ds_map_find_value(textures, temp), "minecraft:", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# for G3D, to make textures look blocky:")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "map_Kd " + "textures/" + string_replace(ds_map_find_value(textures, temp), "minecraft:", "") + ".png")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# illum 2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# d 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Tr 0")
				file_text_writeln(mtl)
				file_text_writeln(mtl)
				file_text_writeln(mtl)
			#endregion
							}
						}
			
				ds_map_add(model_texture_ds, "#" + temp, tex_temp)
			
				temp = ds_map_find_next(textures, temp)
				}
			} 
		
		} until ds_map_exists(ds_map, "elements")
	}
	
	var elements = ds_map_find_value(ds_map, "elements")
	var i = 0
	repeat ds_list_size(elements) {
		var current_element = ds_list_find_value(elements, i)
		var faces = ds_map_find_value(current_element, "faces")
	
	#region From / to coordinates
		var from = ds_map_find_value(current_element, "from")
		var to = ds_map_find_value(current_element, "to")
	
		var from_x = ds_list_find_value(from, 0)
		var from_y = ds_list_find_value(from, 1)
		var from_z = ds_list_find_value(from, 2)
	
		var to_x = ds_list_find_value(to, 0)
		var to_y = ds_list_find_value(to, 1)
		var to_z = ds_list_find_value(to, 2)
	
		//var order = order_least_greatest(from_x, to_x)
		//from_x = order[0]
		//to_x = order[1]
	
		//var order = order_least_greatest(from_y, to_y)
		//from_y = order[0]
		//to_y = order[1]
	
		//var order = order_least_greatest(from_z, to_z)
		//from_z = order[0]
		//to_z = order[1]
	
		//IDK if ordering is required so i commented it out
	
		//Divide by 16 (to correct blender scale)
		from_x/=16
		from_y/=16
		from_z/=16
		to_x/=16
		to_y/=16
		to_z/=16
	
		from_x+=x_lines_done
		from_y+=y_lines_done
		from_z+=z_lines_done
		to_x+=x_lines_done
		to_y+=y_lines_done
		to_z+=z_lines_done
	
	#endregion
	
		//Faces
		var current_face = ds_map_find_first(faces)
		repeat ds_map_size(faces) {
		
			var temp = ds_map_find_value(faces, current_face) //Get the current face's DS
			var uv = ds_map_find_value(temp, "uv")
			#region UV
			
				if ds_map_exists(temp, "uv") {
				var uv_x1 = ds_list_find_value(uv, 0)
				var uv_y1 = ds_list_find_value(uv, 1)
				var uv_x2 = ds_list_find_value(uv, 2)
				var uv_y2 = ds_list_find_value(uv, 3)
			
				if current_face = "north" or current_face = "east" or current_face = "south"or current_face = "west" {
					uv_y2-= uv_y1
					uv_y1-= uv_y1
					}
			
				uv_x1/=16
				uv_y1/=16
				uv_x2/=16
				uv_y2/=16
			
				var order = order_least_greatest(uv_x1, uv_x2)
				uv_x1 = order[0]
				uv_x2 = order[1]
			
				var order = order_least_greatest(uv_y1, uv_y2)
				uv_y1 = order[0]
				uv_y2 = order[1]
					} else {
						var uv_x1 = 0
						var uv_y1 = 0
						var uv_x2 = 16
						var uv_y2 = 16
					
						if current_face = "north" or current_face = "east" or current_face = "south"or current_face = "west" {
							uv_y2-= uv_y1
							uv_y1-= uv_y1
						}
					
						uv_x1/=16
						uv_y1/=16
						uv_x2/=16
						uv_y2/=16
						}
			#endregion
			
				//Set the material for this face.
		
			if ds_map_find_value(surrounding, current_face) = 0 and ds_map_exists(temp, "cullface") and culling = 1 {
					//debug_log("MC2OBJ", "Culled face " + current_face + " " + string(ds_map_find_value(surrounding, current_face)))
				} else {
			
			//if global.gui_values != undefined {
			
				//Use material
				var texture = ds_map_find_value(temp, "texture")
				var mat = ds_map_find_value(model_texture_ds, texture)
			
				buffer_write(buffer, buffer_text, "usemtl " + ds_map_find_value(mat_map, mat))
				buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
				
				buffer_write(buffer, buffer_text, "g " + current_block_name)
				buffer_write(text_file_buffer, buffer_text, chr($000D) + chr($000A))
			
				//Create vertices
				switch (current_face) {
					case "south": 	
					#region North vertices
						buffer_write(buffer, buffer_text, "#South face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
					#endregion
					
						break;
					case "north": 
					#region South vertices
						buffer_write(buffer, buffer_text, "#North face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						

					#endregion

						break;
					case "west": 
					#region West vertices
						buffer_write(buffer, buffer_text, "#West face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						
					
					#endregion

						break;
					case "east": 
					#region East vertices
						buffer_write(buffer, buffer_text, "#East face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
					
					#endregion
					
						break;
					case "up": 		
					#region Up vertices
						buffer_write(buffer, buffer_text, "#Up face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						

					#endregion
					
						break;
					case "down": 		
					#region Down vertices
						buffer_write(buffer, buffer_text, "#Down face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						
						

					#endregion
			
						break;
					}
		
					#region Add UV coordinates.
						buffer_write(buffer, buffer_text, "#Texture coordinates")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x1, 1, 3) + " " + string_format(uv_y2, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x2, 1, 3) + " " + string_format(uv_y2, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x2, 1, 3) + " " + string_format(uv_y1, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x1, 1, 3) + " " + string_format(uv_y1, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++


						
					#endregion
					
					#region Create face.
					
						var verts1 = string(v_count-3) + "/" + string(vt_count-3)
						var verts2 = string(v_count-2) + "/" + string(vt_count-2)
						var verts3 = string(v_count-1) + "/" + string(vt_count-1)
						var verts4 = string(v_count) + "/" + string(vt_count)
					
						buffer_write(buffer, buffer_text, "f " + verts1 + " "+ verts2 + " " + verts3 + " "+ verts4)
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
					#endregion
		
			}
		
		
			current_face = ds_map_find_next(faces, current_face)
			}
	
		i++
		}

	vertice_count = v_count
	vertice_texture_count = vt_count
	ds_map_destroy(model_texture_ds)

	ds_list_delete(global.ds_map_list, ds_list_find_index(global.ds_map_list, ds_map))
	ds_map_destroy(ds_map)
	
}
