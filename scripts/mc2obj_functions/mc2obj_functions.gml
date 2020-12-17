// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mc2obj_mtl(filename, texture_path) {
	//Creates an entry in an mtl file
}

function mc2obj_block(block_id, models_dir, blockstates_dir, mtl, mtl_index, obj) {
	//Starts building a block based on an ID, model and blockstates
	//Handles multipart, random selection, etc.
}

function mc2obj_model(block_id, models_dir, mtl, mtl_index, obj) {
	//Reads a block model, then builds vertices for a .obj file.
	//Handles parented models
}

function mc2obj_vertice(obj, vx, vy, vz) {

}

function mc2obj_vertice_texture (obj, vx, vy) {

}
