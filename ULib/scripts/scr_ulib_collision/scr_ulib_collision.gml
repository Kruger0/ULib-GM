


///@func tile_create_wall(tile_layer, wall_object, [wall_depth])
function tile_create_wall(tile_layer, wall_obj, wall_depth = 0) {
	if !(layer_exists(tile_layer)) {
		return;
	}
	
    var _tile_layer = tile_layer
    var _wall_obj    = wall_obj
    var _wall_depth = wall_depth
    var lay_id = layer_get_id(_tile_layer);
    var map_id = layer_tilemap_get_id(lay_id);
    var grid_unit = tilemap_get_tile_width(map_id)
    var has_adjacent = false;
    var strip_count = 0;
    var curr_tile, next_tile, strip_start_xx;
    var xx = 0;
    var yy = 0;

    while (yy < room_height) {
        while (xx < room_width) {
            curr_tile = tilemap_get_at_pixel(map_id, xx, yy);
            next_tile = tilemap_get_at_pixel(map_id, xx + grid_unit, yy);
        
            if (curr_tile != 0 && !next_tile) {
                instance_create_depth(xx, yy, _wall_depth, _wall_obj);
            } else if (curr_tile != 0 && next_tile != 0) {
                has_adjacent = true;
                strip_start_xx = xx;
                strip_count++;
            }
        
            while (has_adjacent) {
                xx += grid_unit;
                strip_count++;
            
                if (xx + grid_unit < room_width) {
                    next_tile = tilemap_get_at_pixel(map_id, xx + grid_unit, yy);
                } else {
                    next_tile = 0
                }
            
                if (!next_tile) {
                    has_adjacent = false;
                    var inst = instance_create_depth(strip_start_xx, yy, _wall_depth, _wall_obj);
                    inst.image_xscale = strip_count;
                    strip_count = 0;
                }
            }
            xx += grid_unit;   
        }
        xx = 0;
        yy += grid_unit;
    }    
}


    ////Horizontal
    //var _sprite_bbox_left    = sprite_get_bbox_left(mask_index)     - sprite_get_xoffset(mask_index)
    //var _sprite_bbox_right    = sprite_get_bbox_right(mask_index)  - sprite_get_xoffset(mask_index)
    
    //x += hor_spd
    //if (place_meeting(x+sign(hor_spd), y, ground_obj)) {
    //    var _wall = instance_place(x+sign(hor_spd), y, ground_obj)
    //    if (hor_spd > 0) {
    //        x = (_wall.bbox_left-1) - _sprite_bbox_right
    //    } else if (hor_spd < 0) {
    //        x = (_wall.bbox_right+1) - _sprite_bbox_left
    //    }
    //    hor_spd = 0
    //}
    
    ////Vertical
    //var _sprite_bbox_top    = sprite_get_bbox_top(mask_index)     - sprite_get_yoffset(mask_index)
    //var _sprite_bbox_bottom = sprite_get_bbox_bottom(mask_index) - sprite_get_yoffset(mask_index)
    
    //y += ver_spd
    //if (place_meeting(x, y+ver_spd, ground_obj)) {
    //    var _wall = instance_place(x, y+ver_spd, ground_obj)
    //    if (ver_spd > 0) {
    //        y = (_wall.bbox_top-1) - _sprite_bbox_bottom
    //    } else if (ver_spd < 0) {
    //        y = (_wall.bbox_bottom+1) - _sprite_bbox_top
    //    }
    //    ver_spd = 0
    //}