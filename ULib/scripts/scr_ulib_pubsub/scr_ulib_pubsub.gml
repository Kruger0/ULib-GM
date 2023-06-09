
// Created by SamSpadeGamedev
//https://www.youtube.com/shorts/MX0yhlJ52hI

enum ps_event {
	inst_id,
	inst_func,
}

global.pubsub_manager = {
	
	event_struct : {},
	
	subscribe : function(_id, _event, _func) {
	    if (is_undefined(event_struct[$ _event])) {
			event_struct[$ _event] = [];
	    } else if (is_subscribed(_id, _event) != -1) {
			return;
	    } 
		array_push(event_struct[$ _event], [_id, _func]);
	},

	publish : function(_event, _data) {
		var _subscriber_array = event_struct[$ _event];
	
	    if (is_undefined(_subscriber_array)) {
			return;
	    }
	
		for (var i = (array_length(_subscriber_array) - 1); i >= 0; i -= 1) {
			if (instance_exists(_subscriber_array[i][ps_event.inst_id])) {
				_subscriber_array[i][ps_event.inst_func](_data);
			} else {
				array_delete(_subscriber_array, i, 1);
			}
		}	
	},

	is_subscribed : function(_id, _event) {
	    for (var i = 0; i < array_length(event_struct[$ _event]); i += 1) {
	        if (event_struct[$ _event][i][ps_event.inst_id] == _id) {
	            return i;
	        }
	    }  
	    return -1;
	},
	
	unsubscribe : function(_id, _event) {
	    if (is_undefined(event_struct[$ _event])) return;
	  
	    var _pos = is_subscribed(_id, _event);
	    if (_pos != -1) {
			array_delete(event_struct[$ _event], _pos, 1);
	    }    
	},

	unsubscribe_all : function(_id) {
		var _keys_array = variable_struct_get_names(event_struct);
		for (var i = (array_length(_keys_array) - 1); i >= 0; i -= 1) {
			unsubscribe(_id, _keys_array[i]);
		}
	},

	remove_event : function(_event) {
	    if (variable_struct_exists(event_struct, _event)) {
			variable_struct_remove(event_struct, _event);
	    }
	},

	remove_all_events : function() {
		delete event_struct;
		event_struct = {};
	},

	remove_dead_instances : function() {
		var _keys_array = variable_struct_get_names(event_struct);
		for (var i = 0; i < array_length(_keys_array); i += 1) {
			var _keys_array_subs = event_struct[$ _keys_array[i]];
			for (var j = (array_length(_keys_array_subs) - 1); j >= 0; j -= 1) {
				if (!instance_exists(_keys_array_subs[j][0])) {
					array_delete(event_struct[$ _keys_array[i]], j, 1);
				}
			}
		}
	},	
}


function pubsub_subscribe(_event, _func) {
    with (global.pubsub_manager) {
        subscribe(other.id, _event, _func);
        return true;
    }
    return false;
}

function pubsub_unsubscribe(_event) {
    with (global.pubsub_manager) {
        unsubscribe(other.id, _event);
        return true;
    }
    return false;
}

function pubsub_unsubscribe_all() {
	with (global.pubsub_manager) {
        unsubscribe_all(other.id);
        return true;
    }
    return false;
}

function pubsub_publish(_event, _data = 0) {
    with (global.pubsub_manager) {
        publish(_event, _data);
        return true;
    }
    return false;
}

