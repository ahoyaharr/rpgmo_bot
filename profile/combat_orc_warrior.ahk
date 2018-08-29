main() {
	initialise()
	path := 
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	dorpat_to_orcs := [new Coordinate(36, 17)
					  ,new Coordinate(49, 17)
					  ,new Coordinate(62, 17)
					  ,new Coordinate(68, 16)]

	orc_loop := [new Coordinate(71, 16), new Coordinate(70, 20), new Coordinate(72, 21)
				,new Coordinate(73, 23), new Coordinate(78, 24), new Coordinate(81, 24)
				,new Coordinate(82, 19), new Coordinate(77, 19), new Coordinate(79, 16)
				,new Coordinate(75, 16), new Coordinate(75, 14)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(23, 17)
		open_chest(west)
		deposit_all()
		withdraw("dorpat_teleport")
		sleep, 2500
		withdraw("cooked_bass")
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
				print("[STATUS]: " . count . " kills in " . FormatSeconds(A_TickCount - start_time)) 
				
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