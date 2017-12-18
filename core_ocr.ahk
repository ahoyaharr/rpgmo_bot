get_ingame_text(x1, y1, x2, y2) {
	WinGetPos win_x, win_y, , , RPG MO - Early Access

	;coordinate := RegExReplace(clipboard, "[()]", "")
	;StringReplace , coordinate, coordinate, %A_Space%,,All
	;clipboard := "" ; reset the clipboard
	;return % coordinate

	x1 := win_x + x1
	x2 := win_x + x2
	y1 := win_y + y1
	y2 := win_y + y2

	arg := x1 . " " . y1 . " " . x2 . " " . y2
	print(arg)
	Run, %A_WorkingDir%\ocr\cli.exe --screen-rect "%arg%" --whitelist "0123456789,()"
}