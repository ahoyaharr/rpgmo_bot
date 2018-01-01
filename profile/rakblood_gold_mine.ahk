main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Mining white gold at Rakblood.")
	bronze_golem = %A_WorkingDir%\img\monster\bronze_golem.png
	count := 1
	start_time := A_TickCount 
	Loop {
		use_potion := False
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))
		move(37, 65)
		open_chest(east)
		deposit_all()
		if (is_potted("potion_of_mining_superior") != 0) {
			use_potion := True
			print("[TASK]: Repotting", 1)
			withdraw_one("potion_of_mining_superior")
		}
		withdraw("rakblood_teleport")
		move(30, 71)
		move(25, 62)
		move(18, 55)
		move(15, 50)
		move_west(1)
		Loop {
		PixelSearch, FoundX, FoundY, 383, 194, 418, 243, bronze_golem, 0, Fast RGB
		If (ErrorLevel = 0) {
				print("[ALERT]: bronze_golem detected.")
				move_west(1)
				Sleep, 1000
				complete_combat(30)
			}
		} Until (ErrorLevel)
		move(13, 38)
		move(10, 30)
		move(7, 20)
		if (use_potion) {
			use_item("potion_of_mining_superior")
		}
		harvest(west)
		Loop {
			use_item("rakblood_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 34) <= 4 and abs(curr_pos[2] - 68) <= 5)
		count := count + 1
	}
}