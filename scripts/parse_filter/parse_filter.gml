///parse_filter(json, current_loop, ds)
///@param(json)
///@param(inc)
///@param(ds)
function parse_filter(argument0, argument1, argument2) {
	var file = argument0
	var json_ds_list = ds_map_find_value(file, "default")
	var i = argument1
	var ds = argument2

	//var midata = false
	//var mizip = false


	if i < ds_list_size(json_ds_list) {
	//Repeat the DS list size of the json filter:
		var parse = json_get(file, i)
		//Get current entry.
	
		var parse_split = split_string(parse, ";") //Split binary and java.
		var binary_split = split_string(parse_split[0], ",") //Split the binary ID and State.
	
		if !ds_map_find_value(ds, binary_split[0]) { //If there isn't a map for the current block ID
			var parsed_entry_ds = ds_map_create()
			ds_map_add_map(ds, binary_split[0], parsed_entry_ds) 
			//Create a DS map for the current ID.
		
			} else parsed_entry_ds = ds_map_find_value(ds, binary_split[0]) //Otherwise, use the existing map.
		
		
		var current_state_map = ds_map_create()
		var current_state_nbt = ds_map_create()
		ds_map_add_map(parsed_entry_ds, binary_split[1], current_state_map)
		ds_map_add_map(current_state_map, "nbt", current_state_nbt)
		//Add a map for the current binary blockstate ID in the current ID's map.
		//Then add a map for the NBT properties.
	
	
		if string_pos("[", parse_split[1]) >0 {
	#region If there are blockstates in this entry:
			var properties = copy_string_between("[", "]", parse)
		
			var properties_split = split_string(properties, ",")
			//Split properties string into individual states
		
			var i_prop = 0
			repeat array_length(properties_split) {
		#region Repeat for each state:
				if properties_split[i_prop] != "" {
					var properties_split_temp = split_string(properties_split[i_prop], "=")
					//Split individual states into name and value. If the state is blank, skip.
			
					ds_map_add(current_state_nbt, "name", string(properties_split_temp[0]))
					ds_map_add(current_state_nbt, "name_length", string_length(string(properties_split_temp[0])))
					ds_map_add(current_state_nbt, "type", 8)
					ds_map_add(current_state_nbt, "payload", string(properties_split_temp[1]))
					//Add to current state map as NBT
			
					i_prop++
					}	
				
			#endregion
				}
			
			ds_map_add(current_state_map, "Name", string_copy(parse_split[1], 1, string_pos("[", parse_split[1])-1))
			//Add block ID to map.
		
		#endregion
			} else ds_map_add(current_state_map, "Name", parse_split[1]) //Add block ID to map.
			ds_map_add(current_state_map, "name_raw", parse_split[1])
		
		}
	
	total_lines = ds_list_size(json_ds_list)
	done_lines = i
	
	if i > ds_list_size(json_ds_list) return "done" else return false


}
