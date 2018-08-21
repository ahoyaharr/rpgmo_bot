#Include, lib\console.ahk
#Include, lib\find_click.ahk

#Include, core_captcha.ahk
#Include, core_ocr.ahk
#Include, core_combat.ahk

global hk_ocr := "x"

class Coordinate {
	__New(x, y) {
		this.x := x
		this.y := y
	}
	
	travel() {
		move(this.x, this.y)
	}

	fight() {
		return move_and_fight(this.x, this.y, 0)
	}
}

class CombatCoordinate extends Coordinate {
	; This class is for when the player needs to fight a monster to continue traveling.
	travel() {
		move_and_fight(this.x, this.y)
		Sleep, 500
		CoordMode, Pixel, Window
		ImageSearch, x, y, 345, 172, 475, 293, %A_WorkingDir%\img\interface\loot_crate.png
		If (!ErrorLevel) {
			print("[ALERT] Detected loot crate. Destroying.")
			Click, %x%, %y%, Right, 1
			Sleep, 500
			Click, Rel 10, 50 Left, 1
		}
	}
}

class Portal {
	; This class is for when the player needs to traverse a portal to continue traveling.
	__New(x_entrance, y_entrance, x_destination, y_destination) {
		this.x_entrance := x_entrance
		this.y_entrance := y_entrance
		this.x_destination := x_destination
		this.y_destination := y_destination
	}

	travel(tolerance:=0) {
		portal_move(this.x_destination, this.y_destination, this.x_entrance, this.y_entrance, tolerance)
	}
}

walk_path(path, tolerance:=0, reversed:=False) {
	if (!reversed) {
		for each, c in path {
			c.travel(tolerance)
		}
	} else {
		index := path.length()
		while (index--) {
			path[index].travel(tolerance)
		}
	}
}

get_coordinate() {
	WinActivate, RPG MO - Early Access
	CoordMode, Pixel, Window
	clipboard := ""
	ImageSearch, x_l, y_l, 461, 25, 590, 54, %A_WorkingDir%\img\interface\coordinate_left.png
	e1 := ErrorLevel
	ImageSearch, x_r, y_r, 480, 32, 620, 49, *5 %A_WorkingDir%\img\interface\coordinate_right.png
	e2 := ErrorLevel

	if (e1 or e2) { ; If either search failed, terminate 
		print("Unable to find coordinate")
		print(e1)
		print(e2)
		return False
	}

	x_l := x_l - 3 ; Left x bound 
	x_r := x_r + 7 ; Right x bound 
	y_l := y_l + 9 ; Bottom y bound
	y_r := y_r - 8 ; Top y bound 

	While (Clipboard = "" and A_Index < 5) {
		Click, %x_l%, %y_l%, 0
		Send, {LAlt Down}
		send, %hk_ocr%
		Send, {LAlt Up}
		Sleep, 100
		Click, %x_r%, %y_r%, Left, 1
		Sleep, 100
	}

	coordinate := RegExReplace(clipboard, "[()]", "")
	StringReplace , coordinate, coordinate, %A_Space%,,All
	clipboard := "" ; reset the clipboard
	return % coordinate	
}

portal_move(x_destination, y_destination, x_portal, y_portal, tolerance:=0) {
	; Moves the player character using direction until the
	; player character reaches (x, y). 
	print("[TASK]: Moving to position (" . x_portal . ", " . y_portal . ")")
	prev_pos := StrSplit("0,0")
	curr_pos := StrSplit("-1,0")
	failure_count := 0
	Loop {
		pos_str := get_coordinate()

		if (pos_str != "") {
			prev_pos := curr_pos.Clone()
			curr_pos := StrSplit(pos_str, ",")

			print("Current Position: (" . curr_pos[1] . ", " . curr_pos[2] ")", 1)

			; Player character is in the correct location. Exit loop.
			if (abs(curr_pos[1] - x_destination) <= tolerance and abs(curr_pos[2] - y_destination) <= tolerance) {
				break
			}

			; Player character did not move.
			if (prev_pos[1] = curr_pos[1] and prev_pos[2] = curr_pos[2]) {
				print("[WARNING]: No movement detected. Count: " . failure_count, 1)
				failure_count := failure_count - 1
			}

			if (failure_count <= 0 and (abs(curr_pos[1] - x_destination) > tolerance or abs(curr_pos[2] - y_destination) > tolerance)) {
				x_offset := x_portal - curr_pos[1] ; the number of x and y tiles 
				y_offset := y_portal - curr_pos[2] ; to traverse

				north_x := y_offset * 26.9  ; pixel offset for y axis 
				north_y := y_offset * -14.3 ; movement 

				east_x := x_offset * 27.2  ; pixel offset for x axis
				east_y := x_offset * 13    ; movement

				cx := player_x + north_x + east_x ; absolute mouse 
				cy := player_y + north_y + east_y ; position

				window_position := activate_window() ; Returns [width, height]
				if (cx >= 0 and cx <= window_position[1] and cy >= 0 and cy <= window_position[2]) {
					print("Clicking @ "  . cx . ", " . cy, 1)
					Click, %cx%, %cy%, Left, 1
				} else {
					print("[WARNING]: Click destination " . cx . ", " . cy . " out of bounds")
				}
				failure_count := 1
			}
		} else {
			print("[WARNING]: Could not detect position", 1)
		}
		hazard_check()
	}

	if (x_destination != x_portal and y_destination != y_portal) {
		print("[SUCCESS]: Moved through portal to (" . x_destination . ", " . y_destination . ")")
	} else {
		print("[SUCCESS]: Moved to location (" . x_destination . ", " . y_destination . ")")
	}
}

move(x, y, tolerance:=0) {
	portal_move(x, y, x, y, tolerance)
}

relative_click(x, y) {
	north_x := y * 26.9  ; pixel offset for y axis 
	north_y := y * -14.3 ; movement 

	east_x := x * 27.2  ; pixel offset for x axis
	east_y := x * 13    ; movement

	cx := player_x + north_x + east_x ; absolute mouse 
	cy := player_y + north_y + east_y ; position

	Click, %cx%, %cy%, Left, 1
}

relative_move(x, y) {
	relative_click(x, y)
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