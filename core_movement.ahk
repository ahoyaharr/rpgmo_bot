#Include, lib\console.ahk

#Include, core_captcha.ahk
#Include, core_ocr.ahk

get_coordinate() {
	WinActivate, RPG MO - Early Access
	newline := "`n"
	;Click, 569, 32, 0
	;Click, 522, 45, 0
	Click, 530, 46, 0
	Send, {LControl Down}
	Send, {q}
	Send, {LControl Up}
	Click, 577, 31, Left, 1
	;Click, 569, 31 Left, 1
	sleep, 250
	coordinate := RegExReplace(clipboard, "[()]", "")
	StringReplace , coordinate, coordinate, %A_Space%,,All
	clipboard := "" ; reset the clipboard
	return % coordinate
}

move(x, y) {
	; Moves the player character to the coordinate (x, y).
	print("[TASK]: Move to position (" . x . ", " . y . ")")
	prev_pos := StrSplit("0,0")
	curr_pos := StrSplit("-1,0")
	failure_count := 0
	Loop {
		pos_str := get_coordinate()

		if (pos_str != "") {
			prev_pos := curr_pos.Clone()
			curr_pos := StrSplit(pos_str, ",")

			print("Current Position: (" . curr_pos[1] . ", " . curr_pos[2] ")", 1)

			if (curr_pos[1] = x and curr_pos[2] = y) {
				break
			}

			if (prev_pos[1] = curr_pos[1] and prev_pos[2] = curr_pos[2]) {
				print("[WARNING]: No movement detected. Count: " . failure_count, 1)
				failure_count := failure_count - 1
			}

			if (failure_count <= 0 and (curr_pos[1] != x or curr_pos[2] != y)) {
				x_offset := x - curr_pos[1] ; the number of x and y tiles 
				y_offset := y - curr_pos[2] ; to traverse

				north_x := y_offset * 26.9  ; pixel offset for y axis 
				north_y := y_offset * -14.3 ; movement 

				east_x := x_offset * 27.2  ; pixel offset for x axis
				east_y := x_offset * 13    ; movement

				cx := player_x + north_x + east_x ; absolute mouse 
				cy := player_y + north_y + east_y ; position
				print("Clicking @ "  . cx . ", " . cy, 1)
				Sleep, 500
				Click, %cx%, %cy%, Left, 1
				failure_count := 1
			}
		} else {
			print("[WARNING]: Could not detect position, restarting OCR", 1)
			Process, Exist, capture.exe
			if (ErrorLevel = 1) {
				Process,Close,capture.exe
			}
			Run %A_WorkingDir%\ocr\capture.exe --portable
		}
		Sleep, 1250
		hazard_check()
	}
	print("[SUCCESS]: Moved to (" . x . ", " . y . ")")
}

relative_move(x, y) {
	north_x := y * 26.9  ; pixel offset for y axis 
	north_y := y * -14.3 ; movement 

	east_x := x * 27.2  ; pixel offset for x axis
	east_y := x * 13    ; movement

	cx := player_x + north_x + east_x ; absolute mouse 
	cy := player_y + north_y + east_y ; position

	Click, %cx%, %cy%, Left, 1
	Sleep % (abs(x) + abs(y)) * 250
}

move_north(k) {
	relative_move(0, k)
}

move_south(k) {
	relative_move(0, -k)
}

move_east(k) {
	relative_move(k, 0)
}

move_west(k) {
	relative_move(-k, 0)
}

global west = func("move_west")
global east = func("move_east")
global north = func("move_north")
global south = func("move_south")
global mv = func("relative_move")