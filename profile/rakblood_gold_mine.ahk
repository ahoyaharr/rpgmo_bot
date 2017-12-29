main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Mining white gold at Rakblood.")
	bronze_golem = %A_WorkingDir%\img\bronze_golem.png
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))
		move(37, 65)
		open_chest(east)
		deposit_all()
		withdraw("rakblood_teleport")
		;close_chest()
		move(30, 71)
		move(25, 62)
		move(18, 55)
		move(15, 50)
		move_west(1)
		Loop {
		PixelSearch, FoundX, FoundY, 383, 194, 418, 243, bronze_golem, 0, Fast RGB
		If (ErrorLevel = 0) {
				print("[ALERT]: bronze_golem detected.")
				;move_west(1)
				;attack_nearest(bronze_golem)
				move_west(1)
				Sleep, 1000
				complete_combat(30)
			}
		} Until (ErrorLevel)
		move(13, 38)
		move(10, 30)
		move(16, 22)
		harvest(north)
		Loop {
			use_item("rakblood_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 34) <= 4 and abs(curr_pos[2] - 68) <= 5)
	}
}