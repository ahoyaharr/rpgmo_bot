main() {
	initialise()
	path := 
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	dorpat_to_orcs := [new Coordinate(36, 17)
					  ,new Coordinate(49, 17)
					  ,new Coordinate(60, 21)
					  ,new Portal(66, 29, 67, 29)]

	orc_loop := [new Coordinate(70, 31), new Coordinate(72, 34), new Coordinate(69, 35)
				,new Coordinate(65, 36), new Coordinate(64, 36), new Coordinate(61, 36)
				,new Coordinate(56, 32), new Coordinate(55, 28), new Coordinate(54, 25)
				,new Coordinate(56, 22), new Coordinate(60, 21), new Coordinate(64, 20)
				,new Coordinate(67, 20), new Coordinate(71, 20), new Coordinate(72, 21)
				,new Coordinate(75, 22), new Coordinate(76, 26), new Coordinate(79, 26)
				,new Coordinate(77, 29), new Coordinate(75, 29), new Coordinate(72, 27)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(23, 17)
		open_chest(west)
		deposit_all()
		withdraw("dorpat_teleport")
		sleep, 2500
		withdraw("cooked_dolphin")
		sleep, 2500

		; Move to Dungeon 1
		walk_path(dorpat_to_orcs)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, monster in orc_loop {
				if (!monster.fight()) {
					break 
				}
				count := count + 1
				print("[STATUS]: " . count . " kills in " . formatted_time(start_time, A_TickCount)) 
				
				if (mod(count, 100) == 0) {
					destroy_all()
				}
			}
		} until (!eat(3)) ; Loop until the player is hurt and fails to eat.

		print("[ALERT]: Out of food. Returning to Dorpat.")
		Loop { ; Use dorpat teleport until within area of starting location
			use_item("dorpat_teleport")
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}