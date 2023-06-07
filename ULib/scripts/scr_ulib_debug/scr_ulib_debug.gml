

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
function draw_hitbox(_color = c_red, _alpha = 0.4) {
	var _a = draw_get_alpha()
    draw_set_alpha(_alpha)
    draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, _color , _color , _color, _color, 0)
    draw_set_alpha(_a)
}


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

