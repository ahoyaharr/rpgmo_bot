main(profile) {
	initialise()
	path := 
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	dorpat_to_dungeon1 := [new Coordinate(20, 27)
						  ,new Coordinate(19, 36)
						  ,new Coordinate(19, 46)
						  ,new Coordinate(20, 57)
						  ,new Coordinate(18, 66)
						  ,new Coordinate(18, 77)
						  ,new Coordinate(21, 85)
						  ,new Coordinate(25, 90)
						  ,new Portal(25, 88, 23, 88)]

	dragon_path := [new Coordinate(23, 90), new Coordinate(24, 89), new Coordinate(26, 90)
					,new Coordinate(27, 89), new Coordinate(28, 87), new Coordinate(27, 87)
					,new Coordinate(24, 86), new Coordinate(25, 85), new Coordinate(28, 84)
					,new Coordinate(28,81), new Coordinate(27, 80), new Coordinate(25, 75)
					,new Coordinate(21, 75), new Coordinate(18, 75), new Coordinate(18, 82)
					,new Coordinate(18, 84),new Coordinate(15, 87), new Coordinate(16, 89)
					,new Coordinate(17, 92), new Coordinate(19, 93), new Coordinate(20, 90)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(22, 18)
		open_chest(south)
		deposit_all()
		withdraw("dorpat_teleport")
		sleep, 2500
		withdraw("cooked_eel")
		sleep, 2500

		; Move to Dungeon 1
		walk_path(dorpat_to_dungeon1)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, dragon_coordinate in dragon_path {
				if (!eat(2)) {
					break
				}
				dragon_coordinate.travel()
				if (wait_begin_combat(2)) {
					if (complete_combat()) {
						count := count + 1
						print("[STATUS]: " . count . " kills in " . FormatSeconds(A_TickCount - start_time)) 
					}
				}
			}
		} until (!eat(10)) ; Loop until the player is hurt and fails to eat.

		print("[ALERT]: Out of food. Returning to Dorpat.")
		Loop { ; Use dorpat teleport until within area of starting location
			use_item("dorpat_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}