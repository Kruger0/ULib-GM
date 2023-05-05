


function camera_get_fov(proj_mat) {
	return radtodeg(arctan(1.0/proj_mat[5]) * 2.0);
}

function camera_get_aspect(proj_mat) {
	return proj_mat[5] / proj_mat[0];
}

function camera_get_far_plane(proj_mat) {
	return -proj_mat[14] / (proj_mat[10]-1);
}

function camera_get_near_plane(proj_mat) {
	return -2 * proj_mat[14] / (proj_mat[10]+1);
}




function display_get_aspect_ratio() {
	return display_get_width() / display_get_height();
}





enum CamMode {
	Free,
	FollowPlayer,
	Menu,
}

function Camera3D(_x, _y, _z, _xto, _yto, _zto, _xup, _yup, _zup, _fov, _aspect, _znear, _zfar) constructor {
	pos = new Vector3(_x, _y, _z)
	to = new Vector3(_xto, _yto, _zto)
	up = new Vector3(_xup, _yup, _zup)
	
	fov = _fov
	aspect = _aspect
	znear = _znear 
	zfar = _zfar
	
	pitch = 0
	yaw = 0
	roll = 0
	
	id = camera_create();	
	
	mode = CamMode.Free
	switch (mode) {
		case CamMode.Free: {
			update_method = UpdateFree
		}
		break;
		case CamMode.FollowPlayer: {
			update_method = UpdateFollow
		}
		break;
	}
	
	static SetMode = function() {
		if (keyboard_check_pressed(ord("C"))) {
			mode = !mode
			switch (mode) {
				case CamMode.Free: {
					update_method = UpdateFree
				}
				break;
				case CamMode.FollowPlayer: {
					update_method = UpdateFollow
				}
				break;
			}
		}
	}
	
	static UpdateFree = function() {
		var _d = new Vector3()		
		var spd = 2;
		
		var _xmov = keyboard_check(ord("W")) - keyboard_check(ord("S"))
		var _ymov = keyboard_check(ord("D")) - keyboard_check(ord("A"))
		var _zmov = keyboard_check(vk_shift) - keyboard_check(vk_space)
		
		_d.x += dsin(yaw) * _ymov + dcos(yaw) * _xmov
		_d.y += dcos(yaw) * _ymov - dsin(yaw) * _xmov
		_d.z += _zmov
		
		if (mouse_check_button(mb_middle)) {
			var _mx = window_mouse_get_x() - window_get_width()	/ 2 
			var _my = window_mouse_get_y() - window_get_height() / 2 
			yaw -= _mx / 10
			pitch = clamp(pitch - _my / 10, -89, 89)
			window_mouse_set(window_get_width() / 2, window_get_height() / 2)
		}
		
		_d.Multiply(spd)
		pos.Add(_d)
		
		to.x = pos.x + dcos(yaw) * dcos(pitch)
		to.y = pos.y - dsin(yaw) * dcos(pitch)
		to.z = pos.z - dsin(pitch)
	}
	
	static UpdateFollow = function() {
		var _cam_dist = 50
		var _cam_hei = 30
		var _look_pitch = -7
		
		pos.x = lerp(pos.x, obj_player.x - _cam_dist * dcos(obj_player.dir), 1)
		pos.y = lerp(pos.y, obj_player.y - _cam_dist * -dsin(obj_player.dir), 1)
		pos.z = lerp(pos.z, obj_player.z - _cam_hei, 0.1)
		
		yaw = lerp(yaw, obj_player.dir, 0.1)
		pitch = _look_pitch
		
		xto = x + dcos(yaw) * dcos(pitch)
		yto = y - dsin(yaw) * dcos(pitch)
		zto = z - dsin(pitch)
	}
	
	static Update = function() {
		SetMode()
		update_method()
	}
	
	static Apply = function() {
		var _fdir = 0
		if (instance_exists(obj_player)) {
			_fdir = obj_player.direc
		}
		//roll = lerp(roll, (angle_difference(direction, _fdir)*-1)*obj_player.spd*0.1, 0.1)
		up.x = dsin(roll) * dsin(yaw) * dcos(pitch)
		up.y = dsin(roll) * dcos(yaw) * dcos(pitch)
		
		//fov = 60 + sin_wave(0.5, 40)
		
		var _view_mat = matrix_build_lookat(pos.x, pos.y, pos.z, to.x, to.y, to.z, up.x, up.y, up.z)
		var _proj_mat = matrix_build_projection_perspective_fov(fov, aspect, znear, zfar)
		
		camera_set_view_mat(id, _view_mat)
		camera_set_proj_mat(id, _proj_mat)
		camera_apply(id)
	}
	
	static GetViewMat = function() {
		return camera_get_view_mat(id)
	}
	
	static GetProjMat = function() {
		return camera_get_proj_mat(id)
	}
	
	static DrawSkybox = function() {
		
	}	
}

function Camera2D(_x, _y, _wid, _hei) constructor {
	pos = new Vector2(_x, _y)
	to = new Vector2(_x, _y)
	wid = _wid
	hei = _hei
	id = camera_create()
	
	static Update = function() {
		var _d = new Vector2(
			keyboard_check(ord("D")) - keyboard_check(ord("A")),
			keyboard_check(ord("S")) - keyboard_check(ord("W"))
		)
		var _spd = 2		
		pos.Add(_d.Multiply(_spd))
	}
	
	static Apply = function() {
		var _view_mat = matrix_build_lookat(pos.x, pos.y, -10, pos.x, pos.y, 0, 0, 1, 0)
		var _proj_mat = matrix_build_projection_ortho(wid, hei, 1, 32000)
		
		camera_set_view_mat(id, _view_mat)
		camera_set_proj_mat(id, _proj_mat)
		camera_apply(id)
	}
}