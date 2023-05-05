


///@func json_save(data, filename, [encoded])
function json_save(_struct, _filename, encoded = false) {
	var _buffer;
    var _string = json_stringify(_struct); 
    if (encoded) {
        var _b64 = base64_encode(_string);
        _buffer = buffer_create(string_byte_length(_b64)+1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, _b64);
    } else {
        _buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, _string);
    }    
    buffer_save(_buffer, _filename);
    buffer_delete(_buffer);
}

///@func json_load(filename)
function json_load(_filename) {
    var _buffer = buffer_load(_filename); 
	var _struct;
	if !(buffer_exists(_buffer)) {
		show_error(string("JSON Load - File named \"{0}\" not found.\n", _filename), true)
	}
    var _string = buffer_read(_buffer, buffer_string);
	
	try {
		_struct = json_parse(_string);
	} catch(error) {
		try {
			_struct = json_parse(base64_decode(_string));
		} catch(error) {
			show_error(string("JSON Load - File named \"{0}\" could not be read.\n", _filename), true);
		}
	}
    
    buffer_delete(_buffer);
    return _struct;
}
