main() {
	initialise()
	path := 
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	teleport = cesis_teleport
	food = cooked_dolphin

	cesis_to_dragons := [new Coordinate(61, 48)
					  ,new CombatCoordinate(62, 41)
					  ,new CombatCoordinate(62, 34)
					  ,new CombatCoordinate(60, 32)
					  ,new CombatCoordinate(57, 29)
					  ,new CombatCoordinate(55, 27)
					  ,new CombatCoordinate(52, 25)
					  ,new CombatCoordinate(47, 24)]

	dragon_loop := [new Coordinate(46, 24), new Coordinate(48, 26), new Coordinate(50, 29)
				   ,new Coordinate(46, 33) ,new Coordinate(43, 33), new Coordinate(36, 28)
				   ,new Coordinate(32, 28), new Coordinate(30, 27), new Coordinate(31, 25)
				   ,new Coordinate(35, 25), new Coordinate(36, 22), new Coordinate(33, 21)
				   ,new Coordinate(32, 21), new Coordinate(30, 20), new Coordinate(33, 15)
				   ,new Coordinate(34, 17), new Coordinate(37, 17), new Coordinate(40, 20)
				   ,new Coordinate(41, 25), new Coordinate(43, 28)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Dorpat chest 
		move(61, 60)
		open_chest(north)
		deposit_all()
		withdraw(teleport)
		sleep, 2500
		withdraw(food)
		sleep, 2500

		; Move to Dungeon 1
		walk_path(cesis_to_dragons)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, monster in dragon_loop {
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
		} Until (abs(curr_pos[1] - 58) <= 4 and abs(curr_pos[2] - 64) <= 5)
	}
}