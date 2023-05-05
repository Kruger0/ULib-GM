

///@func draw_set_align(horizontal, vertical)
function draw_set_align(horizontal, vertical) {
    draw_set_halign(horizontal);
    draw_set_valign(vertical);
}

///@func draw_reset_align()
function draw_reset_align() {
    draw_set_halign(0);
    draw_set_valign(0);    
}
	
///@func draw_reset_font()
function draw_reset_font() {
	draw_set_font(-1)	
}

function draw_reset(color = true, alpha = true, font = true, halign = true, valign = true, shader = true, surface = true) {
    if (argument0) draw_set_color(c_white);
    if (argument1) draw_set_alpha(1.0);
    if (argument2) draw_set_font(-1);
    if (argument3) draw_set_halign(0);
    if (argument4) draw_set_valign(0);
    if (argument5) shader_reset();
    if (argument6) surface_reset_target();
}

///@func surface_validate(surface_id, width, height, [creation_callback])
function surface_validate(_surf, _w, _h, _format = surface_rgba8unorm, _creation_callback = undefined) {
	if (!surface_exists(_surf)) {
		var _new_surf = surface_create(_w, _h, _format);		
		if (is_callable(_creation_callback)) {
			_creation_callback(_new_surf)
		}
		return _new_surf;
	}
	if (surface_get_width(_surf) != _w || surface_get_height(_surf) != _h) {
		surface_free(_surf);
		var _new_surf = surface_create(_w, _h, _format);		
		if (is_callable(_creation_callback)) {
			_creation_callback(_new_surf)
		}
		return _new_surf;
	}
	return _surf;
}


///@func draw_tiles_depthshorted(source_layer, [depth_start], [depth_adjust])
function draw_tiles_depthshorted(source_layer, depth_start = 0, depth_adjust = 0) {    
    var _lay_id        = layer_get_id(source_layer);
    var _tile_id    = layer_tilemap_get_id(_lay_id);
    var _tileset    = tilemap_get_tileset(_tile_id)
    var _tm_width    = tilemap_get_width(_tile_id);
    var _tm_height    = tilemap_get_height(_tile_id);
    var _cell_size    = tilemap_get_tile_height(_tile_id);
    var tm_lay        = [];
    var tm_arr        = [];
    var _y            = depth_adjust;
    var _source        = 0;
    
    for (var i = 0; i < _tm_height; i++) {
        
        tm_lay[i] = layer_create(depth_start + (room_height - (_y)));
        tm_arr[i] = layer_tilemap_create(tm_lay[i], 0, 0, _tileset, _tm_width, _tm_width);
        
        for (var j = 0; j < _tm_width; j++) {
            _source = tilemap_get(_tile_id, j, i);
            tilemap_set(tm_arr[i], _source, j, i);
        }
        _y += _cell_size;
    }
    layer_set_visible(source_layer, false);
}