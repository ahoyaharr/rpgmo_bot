#Include, lib\find_click.ahk
#Include, lib\console.ahk

#Include, core_captcha.ahk
#Include, core_movement.ahk

move_and_fight(x, y, tolerance:=1, eat_attempts:=3, previous_position:=False) {
	rv := move(x, y, tolerance, previous_position)
	if (wait_begin_combat(1)) {
		complete_combat()
		return eat(eat_attempts)
	}
	return False
}

attempt_combat(k, direction) {
	%direction%(1)
	if (wait_begin_combat(k)) {
		complete_combat()
	}
}

wait_begin_combat(k:=1) {
	print("ALERT: Waiting for combat to begin")
	CoordMode, Pixel, Window
	Loop
	{
		Sleep, 100
		CoordMode, Pixel, Window
	    PixelSearch, FoundX, FoundY, 88, 73, 113, 110, 0x48B629, 0, Fast RGB
	}
	Until (ErrorLevel = 0 or A_Index > (k * 10))
	If (ErrorLevel = 0) {
		print("[ALERT]: Combat has begun")
	} Else {
		print("[WARNING]: " k . " seconds have passed before combat began, continuing")
	}
	return !ErrorLevel
}

attack_nearest(monster) {
	print("[TASK]: Searching for nearest " . monster)
	CoordMode, Mouse, Window
	Click, %player_x%, %player_y%, 0
	images := FindClick(monster, "d n r""RPG MO - Early Access""")
	if (images = 0) {
		print("[WARNING]: No " . monster . " were found!")
		return images
	}
	c := StrSplit(images, ",")
	x := c[1]
	y := c[2]
	Click, %x%, %y%, 1
	CoordMode, Mouse, Window
	print("[SUCCESS]: Attacking " . monster)
	return 1 
}

complete_combat(k:=999999) {
	print("[ALERT]: Waiting for combat to end")
	CoordMode, Pixel, Window
	Loop
	{
	    Sleep, 100
	    ;PixelSearch, FoundX, FoundY, 88, 73, 113, 110, 0x48B629, 0, Fast RGB
	    PixelSearch, FoundX, FoundY, 88, 72, 98, 95, 0x4EC42A, 0, Fast RGB
	}
	Until (ErrorLevel != 0 or A_Index > (k * 10))
	If (ErrorLevel) {
		print("[ALERT]: Combat has ended")
		hazard_check()
	} Else {
		print("[WARNING]: " k . " seconds have passed before combat completed, continuing")
	}
	return ErrorLevel
}

eat(k:=999999) {
	; param k: the number of attempts
	; returns TRUE if the player ate in less attempts than k.
	CoordMode, Pixel, Window
	Loop {
		PixelSearch, FoundX, FoundY, 176, 57, 189, 72, 0x900000, 0, Fast RGB
		if (ErrorLevel = 0) {
			print("[ALERT]: Player at low health, eating food")
			send r
			sleep 1500
		}
		PixelSearch, FoundX, FoundY, 176, 57, 189, 72, 0x900000, 0, Fast RGB
		k := k - 1
	} Until (ErrorLevel != 0 or k <= 0)
	return ErrorLevel
}