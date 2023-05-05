

///@func print(message)
function print(str) {
	static _n = 0
	var _log = ""
	for (var i = 0; i < argument_count; i++) {
		_log += " | " + string(argument[i])		
	}
	show_debug_message("Log " + string(_n++) + _log);
}

///@func draw_hitbox([color], [alpha])
function draw_hitbox(_col = c_red, _alpha = 0.4) {
	draw_primitive_begin(pr_trianglelist)
	draw_vertex_color(bbox_left, bbox_top,		_col, _alpha)
	draw_vertex_color(bbox_right, bbox_top,		_col, _alpha)
	draw_vertex_color(bbox_left, bbox_bottom,	_col, _alpha)
	
	draw_vertex_color(bbox_right, bbox_top,		_col, _alpha)
	draw_vertex_color(bbox_right, bbox_bottom,	_col, _alpha)
	draw_vertex_color(bbox_left, bbox_bottom,	_col, _alpha)
	draw_primitive_end()
}

/*
function draw_hitbox(_color = c_red, _alpha = 0.4) {
    draw_set_alpha(_alpha)
    draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, _color , _color , _color, _color, 0)
    draw_set_alpha(1)
}
*/

///@func window_debug_caption()
function window_debug_caption() {
	static current_fps	= fps_real;
	static timestamp	= get_timer();
	static mean_fps		= current_fps
	
	var _refresh_rate = 1000000; // One second
	var time = get_timer();
	if (time - timestamp > _refresh_rate) {
		mean_fps = floor(mean(current_fps, fps_real));
		current_fps = fps_real;
		timestamp = time;
	}
    
	var text = "FPS: " + string(fps);
	text += " | True FPS: " + string(mean_fps);
	text += " | Instances: " + string(instance_number(all));
	window_set_caption(text);
}
	
function invoke(callback, args, time, repetitions=1) {
	var _ts = time_source_create(time_source_game, time, time_source_units_frames, callback, args, repetitions);
	time_source_start(_ts);
	return _ts;
}

function string_to_hex(str) {
	return int64(ptr(str));
}



///@func sleep([ms])
function sleep(milliseconds = 1000) {
    var _time = current_time + milliseconds;
    while(current_time < _time) {
        // idle
    }
}


/*

exception_unhandled_handler(function(ex) {
    show_debug_message( "--------------------------------------------------------------");
    show_debug_message( "Unhandled exception\n" + string(ex.longMessage) );
    show_debug_message( "--------------------------------------------------------------");
    
    var _log_directory = "logs"
    var _user_msg = string(
@"####################################################

Oops, the game crashed!
    
Cause: {0}
    
At {1}, line {2}.
    
A detailed crashlog file was generated at {3}", ex.message, ex.script, ex.line, "AppData/Local/"+game_project_name+"/"+_log_directory)
 
var _log_msg = string(
@"
***Game crash report file***
    
{0}
    
Callstack: 
", ex.longMessage)
    
    var _stack = debug_get_callstack();
    for (var i = 0; i < array_length(_stack); i++) {
        _log_msg += string(_stack[i]) + "\n"
    }
    
    if !(directory_exists(_log_directory)) {
        directory_create(_log_directory)
    }
    
    var _day    = string_replace_all(string_format(current_day, 2, 0), " ", "0")
    var _month    = string_replace_all(string_format(current_month, 2, 0), " ", "0")
    var _hh        = string_replace_all(string_format(current_hour, 2, 0), " ", "0")
    var _mm        = string_replace_all(string_format(current_minute, 2, 0), " ", "0")
    var _ss        = string_replace_all(string_format(current_second, 2, 0), " ", "0")
    
    var file;
    file = file_text_open_write(string(working_directory + "/"+_log_directory+"/crashlog_{0}-{1}-{2}_{3}{4}{5}.txt", current_year, _day, _month, _hh, _mm, _ss));
    file_text_write_string(file, _log_msg);
    file_text_close(file);
    show_message(_user_msg);
    return 0;
});*/