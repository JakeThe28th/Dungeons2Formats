global.gui_values = ds_map_create()
vh = display_get_gui_height()
vw = display_get_gui_width()



grayed_out_buttons = true

grayed_out_buttons = true

gui_update_loadingbar("normal", "Loading " + string(global.current_level) + " Filter", 0, color_loading_done, color_box, "MainLoader")
		

scroll_percent = 0



selected_level = global.selected_level
selected_group = global.selected_group
selected_object = global.selected_object



level_array = global.level_array

level_json = global.level_json

gui_update_ds_list_multiple(ds_map_find_value(selected_group, "objects"), "none", c_aqua, c_lime, c_green, "SelGroup")

//export_whole_group = false



