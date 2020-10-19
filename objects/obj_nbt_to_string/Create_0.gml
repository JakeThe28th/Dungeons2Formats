file = get_open_filename("Structure block NBT files|*.nbt", "")

i = 0

lib_gz()

if file_exists(program_directory + "//unzip.nbt") file_delete(program_directory + "//unzip.nbt")
gzunzip(file, program_directory + "//unzip.nbt")
//Unzip nbt

nbt = nbt_start(program_directory + "//unzip.nbt")

inc = 0

mainlist = ds_map_find_value(nbt, "payload")
palette = ds_list_find_value(mainlist, 3)
palette = ds_map_find_value(palette, "payload")
blocks = ds_list_find_value(mainlist, 2)
size = ds_list_find_value(mainlist, 0)
size = ds_map_find_value(size, "payload")

blockslist = ds_map_find_value(blocks, "payload")

buffer_blocks = buffer_create(1, buffer_grow, 1)
buffer_states = buffer_create(1, buffer_grow, 1)

x_size = ds_list_find_value(size, 0)
y_size = ds_list_find_value(size, 1)
z_size = ds_list_find_value(size, 2)