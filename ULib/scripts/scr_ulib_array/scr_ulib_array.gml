


///@func array_contains(array, value, ...)
function array_contains(_array, _value) {
    var _search_arr;
    for (var i = 0; i < argument_count-1; i++) {
        _search_arr[i] = argument[1+i]
    }

    var _len = array_length(_array);
    var _vals = array_length(_search_arr);
    var _qtt = 0;
    
    for (var i = 0; i<_len; i++) {
        for (var j = 0; j<_vals; j++) {    
            if _array[i] == _search_arr[j] {     
                _qtt++;    
            }
        }
    }
    return _qtt;
}

///@func array_sort_custom(array)
function array_sort_custom(_arr) {
    var _n = array_length(_arr)
    var _temp
    for (var i = 0; i < _n; i++) {
        for (var j = 0; j < _n; j++) {
            if (_arr[i] < _arr[j]) {
                _temp = _arr[i]
                _arr[i] = _arr[j]
                _arr[j] = _temp
            }
        }
    }
    return _arr
}

/*
E estilo da funcao pro array_sort padrao que vem no gamemaker e que eu sempre esqueco
var _f = function(_a, _b) {
    return _a - _b;
}
*/