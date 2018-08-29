main() {
	initialise()
	path := 
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	teleport = dorpat_teleport
	food = cooked_dolphin

	dorpat_to_spiders := [new Coordinate(36, 17)
					  ,new Coordinate(44, 24)
					  ,new Coordinate(50, 33)
					  ,new Coordinate(57, 41)
					  ,new Coordinate(65, 48)
					  ,new Coordinate(70, 58)
					  ,new Coordinate(80, 63)
					  ,,new Coordinate(83, 75)]

	spider_loop := [new Coordinate(86, 76), new Coordinate(83, 77), new Coordinate(82, 79)
				,new Coordinate(79, 81), new Coordinate(80, 83), new Coordinate(85, 85)
				,new Coordinate(90, 88), new Coordinate(90, 86), new Coordinate(89, 82)
				,new Coordinate(89, 78), new Coordinate(92, 75), new Coordinate(89, 75)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(23, 17)
		open_chest(west)
		deposit_all()
		withdraw(teleport)
		sleep, 2500
		withdraw(food)
		sleep, 2500

		; Move to Dungeon 1
		walk_path(dorpat_to_spiders)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, monster in spider_loop {
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
			use_item(teleport)
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}