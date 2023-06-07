
///@func bitmask_write(mask, index, bool)
function bitmask_write(_mask, _index, _bool) {
    var _value = 1<<_index
    if (_bool) {
        _mask |= _value
    } else {
        _mask &= ~_value
    }
    return _mask
}

///@func bitmask_read(mask, index)
function bitmask_read(_mask, _index) {
    var _bitpos = 1<<_index
    return (_mask & _bitpos)>>_index
}

///@func bitmask_array(mask, [min_size])
function bitmask_array(_mask, _minimum_size = 8) {
    var _len
    if (_mask == 0) {
        _len = _minimum_size
    } else {
        _len = floor(log2(_mask))+1    
    }    
    var _arr = []
    for (var i = 0; i< _len; i++) {
        _arr[i] = bitmask_read(_mask, i)
    }
    return _arr;
}

///@func bin_to_dec(string)
function bin_to_dec(_string) {
	var _len = string_length(_string)
	var _dec = 0;
	for (var i = _len-1; i>= 0; i--) {
		var _bit = string_copy(_string, i+1, 1)
		if (real(_bit)) {
			_dec += power(2, _len-i-1)
		}
	}
	return _dec;
}

///@func dec_to_bin(value, [gap_str])
function dec_to_bin(_value, _gap_str = " ") {
	var _val = _value
	var _str = "";
	var _n = 0
    while (_val > 0) {
        _str = ((floor(_val % 2)) == 0 ? "0" : "1") + _str;
		_n = (_n+1) mod 4
		if (!_n) _str = _gap_str + _str
        _val = _val / 2;
    }
    return _str;
}
