

/*
[]=========================================================[]
||                    	Localization System for GMS2	   ||
||                    									   ||
||                    							--Krug	   ||
[]=========================================================[]

.csv sheet format

|---------------|-------------------|-------------------|---------------------------|
|language		| English			| Portugues			| Español 					|
|---------------|-------------------|-------------------|---------------------------|
|text_intro		| This is a intro!	| Isso é uma intro!	| Esta és una introducion!	|
|---------------|-------------------|-------------------|---------------------------|
*/

//=============================================================
#region Init variables

#macro FILE_LOCALIZATION "localization.csv"
#macro LANG_KEY "language"

global.game_texts = {};
global.game_lang = 0;
global.localize_file = true;


#endregion
//=============================================================


//=============================================================
#region Load CSV file 

var _grid = load_csv(FILE_LOCALIZATION);
if (_grid == -1) {
	show_debug_message(string("Localization file \"{0}\" not found", FILE_LOCALIZATION))
	global.localize_file = false;
}

if (global.localize_file) {
	var _w = ds_grid_width(_grid);
	var _h = ds_grid_height(_grid);

	for (var i = 0; i < _h; i++) {
	    var _texts = [];

	    for (var j = 1; j < _w; j++) {
	        _texts[j-1] = string_replace_all(_grid[# j, i], "[n]", "\n");                
	    }
	    global.game_texts[$ _grid[# 0, i]] = _texts;
	}
	ds_grid_destroy(_grid);
}



#endregion
//=============================================================


//=============================================================
#region Functions

///@func localize(key, val0, val1...)
function localize(_key) {
    var _arr = [];
    for (var i = 1; i < argument_count; i++) {
        _arr[i-1] = argument[i];
    }
    var _keymap = global.game_texts[$ _key]
    if (is_array(_keymap)) {
        return string_ext(_keymap[global.game_lang], _arr)
    } else {
        return string("Translation key \"{0}\" not found in " + FILE_LOCALIZATION, _key);
    }
}

///@func localize_ext(key, arg_array)
function localize_ext(_key, _array) {
    return string_ext(global.game_texts[$ _key][global.game_lang], _array);
}

///@func localize_update()
function localize_update() {
	global.game_texts = {};
	
	var _grid = load_csv(FILE_LOCALIZATION);
	var _w = ds_grid_width(_grid);
	var _h = ds_grid_height(_grid);

	for (var i = 0; i < _h; i++) {
	    var _texts = [];

	    for (var j = 1; j < _w; j++) {
	        _texts[j-1] = string_replace_all(_grid[# j, i], "[n]", "\n");
                
	    }
	    global.game_texts[$ _grid[# 0, i]] = _texts;
	}

	ds_grid_destroy(_grid);
}

///@func localize_lang_count()
function localize_lang_count() {
	return array_length(global.game_texts[$ LANG_KEY]);
}

///@func localize_get_langs()
function localize_get_langs() {
	return global.game_texts[$ LANG_KEY];
}

///@func localize_get_lang()
function localize_get_lang() {
	return localize(LANG_KEY);
}

///@func localize_set_lang(lang)
function localize_set_lang(_lang) {
	if (is_string(_lang)) {
		for (var i = 0; i < localize_lang_count(); i++) {
			if (_lang == global.game_texts[$ LANG_KEY][i]) {
				global.game_lang = i;
				return;
			}
		}
		show_error(string("Language \"{0}\" not found in " + FILE_LOCALIZATION, _lang), true);
	} else if (is_real(_lang)) {
		if (_lang+1 > localize_lang_count()) {
			show_error("Language index bigger than language count", true);
		}
		global.game_lang = _lang;
	}
}


#endregion
//=============================================================