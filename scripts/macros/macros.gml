function macros() {
	
#macro debug = true

#macro ma_directory working_directory
#macro ma_blockstates_directory ma_directory + "data_mc\\blockstates\\"
#macro ma_models_directory ma_directory + "data_mc\\models\\"

#macro ma_data ma_directory + "data\\"
#macro ma_lovika ma_directory + "data\\lovika\\"
#macro ma_resourcepacks ma_directory + "data\\resourcepacks\\"
#macro ma_missionlist ma_directory + "missionsToKeepInPackage.txt"

#macro ma_log + "log.txt"

#macro ma_json_directory ma_directory + "generated\\"
#macro ma_filters ma_directory + "filters\\"


#macro col_bg make_color_hsv(0*0.70833333333, 0*2.55, 80*2.55)
#macro col_normal make_color_hsv(0*0.70833333333, 0*2.55, 55*2.55)
#macro col_med_light make_color_hsv(0*0.70833333333, 0*2.55, 40*2.55)
#macro col_light make_color_hsv(0*0.70833333333, 0*2.55, 40*2.55)
#macro col_txt c_white
#macro col_loading_done make_color_hsv(134*0.70833333333, 54*2.55, 80*2.55)

}
