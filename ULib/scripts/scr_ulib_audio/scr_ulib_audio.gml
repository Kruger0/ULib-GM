

///@func audio_play_at(sound, x, y, [loop], [gain], [offset], [pitch])
function audio_play_at(_sound, _x, _y, _loop = false, _gain = 1.0, _offset = 0.0, _pitch = 1.0) {
	return audio_play_sound_at(_sound, _x, _y, 0, 32, 256, 1, _loop, 1, _gain, _offset, _pitch)
}


//TODO: add some cool audio bus function