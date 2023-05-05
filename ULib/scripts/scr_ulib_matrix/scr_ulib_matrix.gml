

///@func matrix_print_pretty(matrix)
function matrix_print_pretty(_m) {
	return string(
		"\n"+
		"[{0}, {1}, {2}, {3}]\n"+
		"[{4}, {5}, {6}, {7}]\n"+
		"[{8}, {9}, {10}, {11}]\n"+
		"[{12}, {13}, {14}, {15}]",
		_m[0], _m[1], _m[2], _m[3],
		_m[4], _m[5], _m[6], _m[7],
		_m[8], _m[9], _m[10], _m[11],
		_m[12], _m[13], _m[14], _m[15],
	)
}



function matrix_reset() {
	static identity = matrix_build_identity()
	matrix_set(matrix_world, identity)
}


function matrix_set_world(_x, _y, _z, _xrot = 0, _yrot = 0, _zrot = 0, _xscal = 1, _yscal = 1, _zscal = 1) {
	matrix_set(matrix_world, matrix_build(_x, _y, _z, _xrot, _yrot, _zrot, _xscal, _yscal, _zscal))
}


function matrix_reset() {
	static identity = matrix_build_identity()
	matrix_set(matrix_world, identity)
}
	
function matrix_build_srt(_x, _y, _z, _xrot, _yrot, _zrot, _xscale, _yscale, _zscale) {
	
	var _mat_t = matrix_build(_x, _y, _z,	0, 0, 0,				1, 1, 1);
	var _mat_r = matrix_build(0, 0, 0,		_xrot, _yrot, _zrot,	1, 1, 1);
	var _mat_s = matrix_build(0, 0, 0,		0, 0, 0,				_xscale, _yscale, _zscale);
	
	var _mat_rs = matrix_multiply(_mat_s, _mat_r)
	var _mat_srt = matrix_multiply(_mat_rs, _mat_t)
	return _mat_srt;
}

function matrix_transform_vertex_array(_mat, _array) {
	if (array_length(_array) < 4) {
		var _w = 1
	} else {
		var _w = _array[3]
	}
	return matrix_transform_vertex(_mat, _array[0], _array[1], _array[2], _w)
}