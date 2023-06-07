
// TODO: use screen space depthsort method

global.__depthsort_reference_layer_id = -1
#macro __DS_LAYER_INTERVAL 5000
#macro __DS_REFERENCE_LAYER "Player"
#macro DEPTHSORT depthsort_object(__DS_REFERENCE_LAYER)

// Call in Room Start event of obj_game_manager
function layer_depth_update() {
    var a = layer_get_all();
    for (var i = 0; i < array_length(a); i++;) {
        layer_depth(a[i], i * __DS_LAYER_INTERVAL);
    }
    
    global.__depthsort_reference_layer_id = layer_get_id(__DS_REFERENCE_LAYER)
}

// Call in depthsorted objects
function depthsort_object(reference_layer = undefined) {
    var _layer_id;
    
    if (is_undefined(reference_layer)) {
        _layer_id = global.__depthsort_reference_layer_id;
    } else {
        _layer_id = is_string(reference_layer) ? layer_get_id(reference_layer) : reference_layer;
    }
    
    depth = layer_get_depth(_layer_id) + (__DS_LAYER_INTERVAL - y);
}
