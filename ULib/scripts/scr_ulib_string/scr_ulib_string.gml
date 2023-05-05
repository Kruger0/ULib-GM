


///@func string_from_var(variables)
function string_from_var(variable) {
	var _str = "";
	for (var i = 0; i < argument_count; i++) {
		_str += argument[i] + ": " + string(self[$ argument[i]]) + "\n";
	}
	return _str;
}

///@func zero_padding(number, fill_count_int, fill_count_dec)
function zero_padding(number, fill_count_int, fill_count_dec) {
    return string_replace_all(string_format(number, fill_count_int, fill_count_dec), " ", "0")
}

///@func get_cheat_str(cheat_str, cap_sensitive)
function get_cheat_str(_cheat, _cap_sensitive){
    
    //Sensibilidade de capslock
    var _cht, _kbs;
    
    if (_cap_sensitive) {
        _cht = string_lower(_cheat);
        _kbs = string_lower(keyboard_string);
    } else {
        _cht = _cheat;
        _kbs = keyboard_string;
    }
    
    //Compara as strings e limpa a keyboard
    if (string_last_pos(_cht, _kbs)) {
        keyboard_string = "";
        return true;
    } else {
        return false;
    }
}
