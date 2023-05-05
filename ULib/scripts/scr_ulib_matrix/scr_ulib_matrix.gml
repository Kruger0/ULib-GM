

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
