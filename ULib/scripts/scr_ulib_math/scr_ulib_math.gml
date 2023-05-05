


function sin_wave(spd, height, time = current_time/10) {
    return dsin((time)*spd)*height;
}



///@func chance(percentage)
function chance(percentage) {
	return irandom(100) < percentage;
}

///@func in_even(number)
function is_even(n) {
	return n&1 == 0;
}

///@func map_value(value, curr_min, curr_max, dest_min, dest_max)
function map_value(_value, _curr_min, _curr_max, _dest_min, _dest_max) {
    return (((_value - _curr_min) / (_curr_max - _curr_min)) * (_dest_max - _dest_min)) + _dest_min;
}

///@func approach_value(a, b, amt)
function approach_value(_start, _end, _shift) {
    if (_start < _end) {
        return min(_start + _shift, _end); 
    } else {
        return max(_start - _shift, _end);
    }
}

///@func lerp_direction(a, b, amt)
function lerp_direction(a, b, amount) {
	var _a = a + angle_difference(b, a);
	return lerp(a, _a, amount);
	//return a - (angle_difference(a, b) * _amount);
}


/// @arg t Tempo - um número entre 0 e 1
/// @arg ... Resto dos argumentos - todas as cores em que ele deverá interpolar
function lerp_colors() {
    if (argument_count < 2)
        throw "Not enough arguments for *lerp_colors*\n" + debug_get_callstack();
    
    var t = argument[0];
    var c = argument_count-1;
    if (c == 1)
        return argument[1];
    
    t = t*(c-1);
    c = 1;
    while (t > 1) {
        t -= 1;
        ++c;
    }
    
    var result = merge_color(argument[c], argument[c+1], t);
    return result;
}



///@func choose_weighted(item1, weight1, item2, weight2, ...)
function choose_weighted(_item1, _weight1, _item2, _weight2) {
    if (argument_count mod 2 != 0 || argument_count == 0) {
        show_error("Expected an even number of arguments greater than 0, got " + string(argument_count) + ".", true);
    }
    
    var _item_index        = 0
    var _item_count        = argument_count >> 1
    var _item_array        = array_create(_item_count)
    var _cumul_weights    = array_create(_item_count)
    var _total_weight    = 0    
    
    var i = 0;
    repeat (_item_count) {
        _item_array[_item_index] = argument[i++];
        _total_weight += argument[i++];
        _cumul_weights[_item_index] = _total_weight;
        _item_index++;
    }    

    var _rand = random(_total_weight);
    for (var j = 0; j < _item_count; j++) {
        if (_rand < _cumul_weights[j]) {
            return _item_array[j];
        }
    }
    
    return _item_array[_item_count-1];
}