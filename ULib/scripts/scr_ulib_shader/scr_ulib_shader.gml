// WIP!!!


function __shader_cache() {
	static shader_stack = ds_stack_create()
	return shader_stack
}

function shader_set_stack(_shader) {
	var _stack = __shader_cache()
	var _curr_shader = shader_current()
	ds_stack_push(_stack, _curr_shader)
	shader_set(_shader)
}


function shader_reset_stack() {
	var _stack = __shader_cache()
	if (ds_stack_size(_stack) == 0) {
		shader_reset()
		return;
	}
	var _prev_shader = ds_stack_pop(_stack)
	shader_set(_prev_shader)
}

