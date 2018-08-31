#Include, lib\console.ahk
#Include, core_interface.ahk

activate_window() {
	window_name = RPG MO - Early Access
	WinActivate, %window_name%
	WinGetActiveStats, title, width, height, x, y
	return [width, height]
}

hazard_check() {
	activate_window()
	CoordMode, Pixel, Window
	captcha_check()
	daily_login_check()
	logged_out_check()
	close_chat()
}

logged_out_check() {
	while (main_menu_is_open()) {
		Click, 270, 214 Left, 1
		Sleep, 500
		Random, y_val, 237, 255
		Click, 265, %y_val% Left, 1
		Sleep, 500
		Click, 266, 323 Left, 1
		Sleep 250
		Send, {Enter}
		Sleep, 2500
	}
}

daily_login_check() {
	; Currently searching for a green box because the text wasn't working
	; But we should try to fix that later 
	ImageSearch, FoundX, FoundY, 348, 250, 383, 282, %A_WorkingDir%\img\interface\daily_login.png
	If (ErrorLevel = 0) {
		print("[ALERT] Daily login screen detected!", 1)
	    Click, 565, 192 Left, 1
	}
}

captcha_check(id := -1) {
	ImageSearch, FoundX, FoundY, 98, 63, 734, 415, %A_WorkingDir%\img\interface\captcha_exist.png
	If (ErrorLevel = 0) { 
		if (id != -1 and id != "") { ; If captcha window still exists after recursing, then the solution must have been bad 
			report_error(id)
		}
		print("[ALERT] Captcha detected!", 1)
		Sleep, 250
		screenshot_captcha()
		Sleep, 2500 ; Should wait until file exists instead of hardcoding a sleep 
		refresh_captcha()
		submit_captcha()
		select_input_box()

		s := StrSplit(load_captcha_solution(), ",") ; A comma delimited string of the form solution,id
		solution := s[1]
		id := s[2]

		Loop, 15 {	 ; Remove input from box 
			send, {BackSpace}
		}
		Send, %solution% ; input solution 
		Sleep, 2500
		CoordMode, Pixel, Window
		ImageSearch, FoundX, FoundY, 396, 231, 721, 466, %A_WorkingDir%\img\interface\captcha_submit.png
		If ErrorLevel = 0
		{
			Click, %FoundX%, %FoundY%
		}
		Sleep, 1000
		Click, 435, 272 Left, 1
		Sleep, 1500
		Click, 557, 224 Left, 1
		Sleep, 1000 ; Wait for captcha to submit before checking 
		return captcha_check(id) ; If we failed the captcha, then recursively calling will find it 
	}
	return False
}

select_input_box() {
	ImageSearch, FoundX, FoundY, 269, 160, 604, 420, %A_WorkingDir%\img\interface\captcha.png ; C:\Users\a\AppData\Roaming\MacroCreator\Screenshots\Screen_20171206190701.png
	If (ErrorLevel = 0) {
		Click, %FoundX%, %FoundY%
	}
}

refresh_captcha() {
	ImageSearch, FoundX, FoundY, 153, 106, 708, 451, %A_WorkingDir%\img\interface\captcha_refresh.png
	if (ErrorLevel = 0) {
		click %FoundX%, %FoundY%
	}
}

screenshot_captcha() {
	print("Taking captcha screenshot", 2)
	WinGetPos, win_x, win_y, , ,  RPG MO - Early Access
	x1 := win_x + 323
	y1 := win_y + 232
	x2 := win_x + 520 ; 474
	y2 := win_y + 303
	arg := x1 . "," . y1 . "," . x2 . "," . y2
	Run %A_WorkingDir%\boxcutter\boxcutter.exe -c %arg% %A_WorkingDir%\captcha\captcha.png
	print("Captcha screenshot saved", 2)
}

report_error(id) {
	print("Reporting failed captcha; id =" . id)
	credentials := load_credentials()
	RunWait, % A_WorkingDir . "\captcha\deathbycaptcha.exe -l " . credentials[1] . " -p " credentials[2] . " -n " . id
	print("Reported")
}

submit_captcha() {
	print("Solving captcha", 2)
	CoordMode, Pixel, Window
	ImageSearch, FoundX, FoundY, 197, 142, 674, 435, C:\Users\a\AppData\Roaming\MacroCreator\Screenshots\Screen_20171227223827.png
	If (ErrorLevel = 0) {
		print("found mystery image, clicking...!")
		MsgBox, % "look at me"
		Click, %FoundX%, %FoundY%
	}
	credentials := load_credentials()
	RunWait, % A_WorkingDir . "\captcha\deathbycaptcha.exe -l " . credentials[1] . " -p " . credentials[2] . " -c " . A_WorkingDir . "\captcha\captcha.png -t 30"
	print(A_WorkingDir . "\captcha\deathbycaptcha.exe -l " . credentials[1] . " -p " . credentials[2] . " -c " . A_WorkingDir . "\captcha\captcha.png -t 30")
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
	return % answer . "," . key
}

load_credentials() {
	credentials := []
	Loop, read, %A_WorkingDir%\captcha\credentials.txt
	{
	    credentials.push(A_LoopReadLine)
	}
	return credentials
}