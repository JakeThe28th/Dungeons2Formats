global.gui_values = ds_map_create()
vh = display_get_gui_height()
vw = display_get_gui_width()

color_bg = make_color_hsv(0*0.70833333333, 0*2.55, 80*2.55)
color_box = make_color_hsv(0*0.70833333333, 0*2.55, 55*2.55)
color_darkbox = make_color_hsv(0*0.70833333333, 0*2.55, 40*2.55)
color_text = c_black
color_loading_done = make_color_hsv(134*0.70833333333, 54*2.55, 80*2.55)

grayed_out_buttons = false

selected_level = "SquidCoast"
global.current_level = selected_level
selected_group = 0
selected_object = 0

loading_bar_text_type = "normal"

				
		instance_create_depth(0, 0, 1, obj_load_level)
		grayed_out_buttons = true
		loading_bar_text = "Loading " + string(global.current_level) + " Filter"
		
		//PAUSE ALL STUFF UNTIL LEVEL IS LOADED!
		//GET RETURNED VALUES
				
		level_json = json_decode(obj_load_level.json_string)
		

var dir = global.dataDirectory + "lovika\\levels\\" + selected_level + ".json"
var json_txt = file_text_open_read(dir)
var json_string = ""

repeat 6 file_text_readln(json_txt) //Get past mojang's comment

do json_string = json_string + string(file_text_readln(json_txt)) until file_text_eof(json_txt)
//Read the json into a string

level_json = json_decode(json_string)


level_array = array_create(1, 0)
level_array[0] = "SquidCoast"
level_array[1] = "lobby"

loading_bar_text = "hello"
loading_bar_done = 0

scroll_percent = 0

//export_whole_group = false
