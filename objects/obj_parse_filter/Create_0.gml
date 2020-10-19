debug_log("INFO", "Starting to load block filter.")
ds = ds_map_create()
global.realfilter = global.filter
file = json_load(global.filter)
i = 0
done = false
done_lines = 0
total_lines = 1
//Init values for parsing