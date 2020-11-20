// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dng_levels_list() {
	var arrr = array_create(1, 0)
	var file = file_text_open_read(global.dataDirectory + "\missionsToKeepInPackage.txt")
	var i = 0
	do {
		arrr[i] = file_text_read_string(file)
		file_text_readln(file)
		i++
		} until file_text_eof(file)
	file_text_close(file)
	return arrr
}