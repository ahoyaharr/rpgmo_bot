#Include, lib\find_click.ahk
#Include, lib\console.ahk

#Include, core_captcha.ahk


wait_begin_combat(k) {
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
	return ErrorLevel
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

complete_combat(k) {
	print("[ALERT]: Waiting for combat to end")
	CoordMode, Pixel, Window
	Loop
	{
	    Sleep, 100
	    PixelSearch, FoundX, FoundY, 88, 73, 113, 110, 0x48B629, 0, Fast RGB
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

eat() {
	; Add in inventory check 
	CoordMode, Pixel, Window
	Loop {
		PixelSearch, FoundX, FoundY, 176, 57, 189, 72, 0x900000, 0, Fast RGB
		if (ErrorLevel = 0) {
			print("[ALERT]: Player at low health, eating food")
			send r
			sleep 750
		}
		PixelSearch, FoundX, FoundY, 176, 57, 189, 72, 0x900000, 0, Fast RGB
	} Until (ErrorLevel != 0)
}