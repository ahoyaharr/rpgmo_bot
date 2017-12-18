#Include, lib\console.ahk

captcha_check() {
	;print("[TASK]: Checking for captcha", 1)
	;ImageSearch, FoundX, FoundY, 291, 299, 575, 380, %bot_check%, 0, Fast RGB
	;PixelSearch, FoundX, FoundY, 135, 86, 568, 423, 0x333333, 0, Fast RGB
	; This is terrible keep experimenting
	;ImageSearch, FoundX, FoundY, 283, 243, 300, 270, C:\Users\a\AppData\Roaming\MacroCreator\Screenshots\Screen_20171206183653.png
	ImageSearch, FoundX, FoundY, 98, 63, 734, 415, %A_WorkingDir%\img\captcha_exist.png
	If (ErrorLevel = 0) {
		print("[ALERT] Captcha detected!", 1)
		Sleep, 250
		screenshot_captcha()
		Sleep, 2500
		ImageSearch, FoundX, FoundY, 153, 106, 708, 451, %A_WorkingDir%\img\captcha_refresh.png
		if (ErrorLevel = 0) {
			click %FoundX%, %FoundY%
		}
		submit_captcha()
		CoordMode, Pixel, Window
		ImageSearch, FoundX, FoundY, 269, 160, 604, 420, C:\Users\a\AppData\Roaming\MacroCreator\Screenshots\Screen_20171206190701.png
		If ErrorLevel = 0
		{
			Click, %FoundX%, %FoundY%
		}
		solution := load_captcha_solution()
		Loop, 10 {
			send, {BackSpace}
		}
		Send, %solution%
		Sleep, 2500
		;Send, {Enter}
		CoordMode, Pixel, Window
		ImageSearch, FoundX, FoundY, 396, 231, 721, 466, %A_WorkingDir%\img\captcha_submit.png
		If ErrorLevel = 0
		{
			Click, %FoundX%, %FoundY%
		}
		Sleep, 2500
		Click, 557, 224 Left, 1
		return captcha_check() ; If we failed the captcha, then recursively calling will find it 
	}
	return False
}


screenshot_captcha() {
	print("Taking captcha screenshot", 2)
	WinGetPos, win_x, win_y, , ,  RPG MO - Early Access
	x1 := win_x + 323
	y1 := win_y + 232
	x2 := win_x + 490 ; 474
	y2 := win_y + 303
	arg := x1 . "," . y1 . "," . x2 . "," . y2
	Run %A_WorkingDir%\boxcutter\boxcutter.exe -c %arg% %A_WorkingDir%\captcha\captcha.png
	print("Captcha screenshot saved", 2)
}

submit_captcha() {
	print("Solving captcha", 2)
	RunWait, %A_WorkingDir%\captcha\deathbycaptcha.exe -l Solzhenitsyn -p ragnarok88 -c %A_WorkingDir%\captcha\captcha.png -t 30
	print("Captcha solution returned", 2)
}

load_captcha_solution() {
	print("Loading solution from file", 2)
	FileRead, answer, %A_WorkingDir%\answer.txt
	FileRead, key, %A_WorkingDir%\id.txt
	s := key . "," . answer . "`n"
	FileAppend, %s%, %A_WorkingDir%\captcha\log.txt

	print("Removing temporary files", 2)
	FileDelete, %A_WorkingDir%\answer.txt
	FileDelete, %A_WorkingDir%\id.txt
	FileDelete, %A_WorkingDir%\captcha\captcha.png

	print("Solution to captcha is " . answer, 2)
	return % answer
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