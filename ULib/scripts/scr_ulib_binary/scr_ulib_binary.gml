
function bitmap_write(_map, _index, _bool) {
    var _mask
    var _value = 1<<_index
    if (_bool) {
        _mask = _map | _value
    } else {
        _mask = _map & ~_value
    }
    return _mask
}

function bitmap_read(_map, _index) {
    var _bitpos = 1<<_index
    return (_map & _bitpos)>>_index
}

function bitmap_array(_map, _minimum_size = 8) {
    var _len
    if (_map == 0) {
        _len = _minimum_size
    } else {
        _len = floor(log2(_map))+1    
    }    
    var _arr = []
    for (var i = 0; i< _len; i++) {
        _arr[i] = bitmap_read(_map, i)
    }
    return _arr;
}

function bin_to_dec(_string) {
	//var _len = string_length(_string)
	//var _result = 0
	//for (var i = _len; i > 0; i--) {
	//	var _bit = string_copy(_string, i, 1)
	//	if 
	//}
}

function dec_to_bin(_value, _min_size = 1) {
	var _bin = ""
	var _val = _value

	while (_val != 0) {
		var _div= _val / 2
		var _rem = ceil(frac(_div))
		_val = floor(_div)
		_bin += _rem ? "1" : "0"
	}
	
	// revert the string
	var _str = ""
	var _len = string_length(_bin)
	for (var i = max(_min_size, _len); i > 0; i--) {
		if (i <= _len) {
			_str += string_copy(_bin, i, 1)
		} else {
			_str += "0"
		}
		
		if (i mod 4 == 1) {
			_str += " "
		}
	}
	
	return _str
}
