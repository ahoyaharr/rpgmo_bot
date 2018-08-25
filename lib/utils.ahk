distance_from_base(coordinate_pair) {
	; coordinate_pair is a comma delimited string
	v := StrSplit(coordinate_pair, ",") ; v[1] = x2, v[2] = y2
	r := Sqrt((v[1] - player_x)**2 + (v[2] - player_y) **2)
	return r
}

distance_sort(v1, v2) {
	return distance_from_base(v1) - distance_from_base(v2)
}

formatted_time(start, current)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    ms := (current - start) // 1000
    time = 19990101  ; *Midnight* of an arbitrary date.
    time += %ms%, seconds
    FormatTime, mmss, %time%, mm:ss
    return ms//3600 ":" mmss
    /*
    ; Unlike the method used above, this would not support more than 24 hours worth of seconds:
    FormatTime, hmmss, %time%, h:mm:ss
    return hmmss
    */
}