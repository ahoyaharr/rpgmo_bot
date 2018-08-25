main() {
	initialise()
	count := 0
	start_time := A_TickCount 
	currentWorld := 1

	food := "cooked_hammer_shark"
	teleport := "reval_teleport"

	reval_to_pernau := [new Coordinate(16, 19), new Coordinate(28, 22), new Coordinate(34, 31)
						, new Coordinate(39, 40), new Coordinate(45, 49), new Coordinate(52, 57)
						, new Coordinate(58, 66), new Coordinate(68, 70), new Coordinate(78, 75)
						, new Coordinate(81, 80), new Coordinate(83, 86)
						, new Portal(83, 87, 85, 81)]

	pyramid_to_desert := [new CombatCoordinate(88, 92), new Coordinate(90, 81), new CombatCoordinate(88, 69)
						 ,new CombatCoordinate(91, 64), new CombatCoordinate(91, 60), new CombatCoordinate(91, 56)
						 ,new CombatCoordinate(91, 55), new Coordinate(82, 54), new Coordinate(71, 54)
						 ,new Coordinate(60, 54), new Coordinate(51, 54), new CombatCoordinate(46, 54)
						 ,new CombatCoordinate(44, 56), new CombatCoordinate(41, 56)
						 ,new Portal(40, 57, 35, 41)]

	desert_to_mummies := [new CombatCoordinate(35, 39), new CombatCoordinate(35, 36), new CombatCoordinate(35, 33)
						, new CombatCoordinate(34, 30), new CombatCoordinate(38, 31), new Coordinate(37, 36)
						, new CombatCoordinate(42, 37), new CombatCoordinate(47, 33), new CombatCoordinate(51, 33)
						, new CombatCoordinate(55, 33), new CombatCoordinate(56, 36), new CombatCoordinate(60, 32)
						, new CombatCoordinate(58, 30), new CombatCoordinate(60, 24), new CombatCoordinate(57, 22)
						, new CombatCoordinate(57, 17), new Coordinate(56, 9)]	

	mummy_loop := [new Coordinate(59, 8), new Coordinate(60, 10), new Coordinate(63, 12), new Coordinate(65, 13)
				 , new Coordinate(64, 16), new Coordinate(67, 15), new Coordinate(70, 15), new Coordinate(70, 18)
				 , new Coordinate(73, 18), new Coordinate(76, 18), new Coordinate(76, 19), new Coordinate(79, 20)
				 , new Coordinate(82, 22), new Coordinate(82, 20), new Coordinate(84, 19), new Coordinate(85, 15)
				 , new Coordinate(83, 15), new Coordinate(81, 15), new Coordinate(80, 14), new Coordinate(78, 13)
				 , new Coordinate(75, 13), new Coordinate(73, 13), new Coordinate(71, 12), new Coordinate(69, 10)
				 , new Coordinate(66, 9), new Coordinate(63, 8)]

	print("[ALERT]: Routine loaded. Fighting " . monsters)
	Loop {
		; Move to Reval chest 
		move(14, 31)
		open_chest(north)
		deposit_all()
		withdraw(teleport)
		sleep, 2500
		withdraw(food)
		sleep, 2500

		; Move to Pernau
		print("[ALERT] Walking to Pernau.")
		walk_path(reval_to_pernau)
		print("[ALERT] Walking to the desert.")
		walk_path(pyramid_to_desert)
		print("[ALERT] Walking to mummies.")
		walk_path(desert_to_mummies)

		print("[ALERT]: Beginning to fight " . monsters)
		Loop {
			for each, mummy in mummy_loop {
				if (!mummy.fight()) {
					break 
				}
				count := count + 1
				print("[STATUS]: " . count . " kills in " . formatted_time(start_time, A_TickCount)) 
				
				if (mod(count, 100) == 0) {
					destroy_all()
				}
			}
		} until (!eat(3)) ; Loop until the player is hurt and fails to eat.

		print("[ALERT]: Out of food. Returning to Reval.")
		Loop { ; Use dorpat teleport until within area of starting location
			use_item(teleport)
			sleep, 1000
			curr_pos := StrSplit(get_coordinate(), ",")
		} Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
	}
}