// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mc2obj_mtl(mtl, mat_map, texture_name, texture_path) {
	//Creates an entry in an mtl file
	
	//Check if i've already made an entry for this texture.
	if !ds_map_exists(mat_map, texture_name) {

			ds_map_add(mat_map, texture_name, texture_name)
		
			#region mtl nonsense
				file_text_write_string(mtl, "newmtl " + texture_name)
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ns 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# Ka 0.2 0.2 0.2")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Kd 1 1 1")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "Ks 0 0 0")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# map_Ka " + texture_path)
				file_text_writeln(mtl)
				file_text_write_string(mtl, "# for G3D, to make textures look blocky:")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				file_text_writeln(mtl)
				file_text_write_string(mtl, "map_Kd " + texture_path)
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

function mc2obj_block(block_id, models_dir, blockstates_dir, mtl, mtl_index, obj) {
	//Starts building a block based on an ID, model and blockstates
	//Handles multipart, random selection, etc.
	
	//If block namespace is dungeons:
	//mc2obj_build_block_json
	
	//Also, dont forget to add the missing block blocks
	
	if multipart = true {
		var i = 0
		repeat ds_list_size(model) {
				mc2obj_model(model[| i], models_dir, mtl, mtl_index, obj)
				i++
			}
		} else {
			mc2obj_model(model, models_dir, mtl, mtl_index, obj)
			}
}

function mc2obj_model(json, models_dir, mtl, mtl_index, obj) {
	//Reads a block model, then builds vertices for a .obj file.
	//Handles parented models
}

function mc2obj_vertice(obj, vx, vy, vz) {

}

function mc2obj_vertice_texture (obj, vx, vy) {

}

function mc2obj_generate_block_model (obj, vx, vy) {

}
