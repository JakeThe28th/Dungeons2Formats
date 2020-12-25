function obj_create_block(bx, by, bz, json, buffer, v_count, vt_count, cullfaces, mtl, mat_map) {
		var json_ds = json_load(json)
	
		//Parent Handling
		do {
			//Load the parent's DS.
			var parent = json_load(ma_models_directory + string_replace(json_ds[? "parent"], "minecraft:",""))
			
			//Replace the json's elements with the parent's elements.
			if ds_map_exists(parent, "elements") { 
				ds_map_delete(json_ds, "elements")
				ds_map_add_map(json_ds, "elements", parent[? "elements"])
				}
				
				
			//Find textures from the parent and add them to the json.
			if ds_map_exists(parent, "textures") { 
				//Get the textures DS
				var textures = ds_map_find_value(parent, "textures")
				
				var iTex = ds_map_find_first(textures) //First parent texture
				repeat ds_map_size(parent[? "textures"]) {
					
					//Add it to the json, then get next one.
					ds_map_add(ds_map_find_value(json_ds, "textures"), iTex, textures[? iTex])
					var iTex = ds_map_find_next(textures)
					}
				}
				
			//Destroy the parent's DS.
			ds_map_destroy(parent)
			} until !ds_map_exists(json_ds, "parent") 
	
		//Get the textures DS.
		var textures = ds_map_find_value(json_ds, "textures")
		
		
		//Get texture shorthands (EG #top).
		var texture_shorthands = ds_map_create() //Make DS
		
		//Get the first shorthand, then repeat: 
		//( Add texture shorthand to DS, get next, make material )
		var texture_temp = ds_map_find_first(texture_shorthands)
		repeat ds_map_size(textures) {		
			ds_map_add(texture_shorthands, texture_temp, textures[? texture_temp])
			texture_temp = ds_map_find_next(texture_shorthands, texture_temp)
			
			//Material		
			if string_pos("dungeons", textures[? texture_temp]) > 0 { 
				var texture_path = string_replace_all(textures[? texture_temp], "dungeons", ma_resourcepacks) + ".png"
				
				mc2obj_mtl(mtl, mat_map, textures[? texture_temp], texture_path)
				}		
			if string_pos("minecraft", textures[? texture_temp]) > 0 { 
				var texture_path = string_replace_all(textures[? texture_temp], "minecraft", ma_textures_directory) + ".png"
				
				mc2obj_mtl(mtl, mat_map, textures[? texture_temp], texture_path)
				}
			if string_pos("missing", textures[? texture_temp]) > 0 { 
				mc2obj_mtl(mtl, mat_map, textures[? texture_temp], "missing.png")
				}
			}
			
			
			
		var elements = ds_map_find_value(json_ds, "elements")
		
		var iElement = 0
		repeat ds_list_size(elements) {
		
		var element = elements[| iElement]
			from_x = json_get(element)
			from_y
			from_z
			
		//At reading elements.
		//ADD: FROM, TO
		//UV
		//REPLACE TEMP WITH ELEMENT
		//BOOM
		//THEN DO PARSE OBJ
		//FOR THE STATE READIND
		//COMMENTS I N ALL CAP S
			
		
		var faces = element[? "faces"]

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
		
			if ds_map_find_value(cullfaces, current_face) = 0 and ds_map_exists(temp, "cullface") and ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 1) > -1 {
					//debug_log("MC2OBJ", "Culled face " + current_face + " " + string(ds_map_find_value(surrounding, current_face)))
				} else {
			
			//if global.gui_values != undefined {
			
				//Use material
				var texture = ds_map_find_value(temp, "texture")
				var mat = ds_map_find_value(model_texture_ds, texture)
			
				buffer_write(buffer, buffer_text, "usemtl " + ds_map_find_value(mat_map, mat))
				buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
				
				//buffer_write(buffer, buffer_text, "g " + current_block_name)
				//buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
			
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
	
		iElement++
		}

	vertice_count = v_count
	vertice_texture_count = vt_count
	
}
