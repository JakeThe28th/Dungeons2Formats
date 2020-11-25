function macros() {
	
#macro debug true
#macro performance_mode false

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


#macro col_bg make_color_hsv(187*0.70833333333, 29*2.55, 22*2.55)
#macro col_superdark make_color_hsv(216*0.70833333333, 68*2.55, 17*2.55)
#macro col_dark make_color_hsv(216*0.70833333333, 69*2.55, 33*2.55)
#macro col_normal make_color_hsv(216*0.70833333333, 60*2.55, 55*2.55)
#macro col_med_light make_color_hsv(216*0.70833333333, 60*2.55, 94*2.55)
#macro col_light make_color_hsv(216*0.70833333333, 19*2.55, 100*2.55)
#macro col_txt c_white
#macro col_loading_done make_color_hsv(134*0.70833333333, 54*2.55, 80*2.55)

}
