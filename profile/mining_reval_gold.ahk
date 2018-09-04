main() {
	initialise()
	print("[ALERT]: Routine loaded. Mining coal at the Mining Guild.")

	count := 1
	start_time := A_TickCount 

	teleport = reval_teleport
	bank_spot := new Coordinate(14, 31)

	to_trip := [bank_spot, new Coordinate(16, 19), new Coordinate(29, 20), new Coordinate(41, 23)
			   ,new Coordinate(55, 24), new Coordinate(69, 25), new Coordinate(70, 35)
			   ,new CombatCoordinate(68, 38), new Coordinate(67, 38)]

	from_trip := []

	bank_spot.travel()
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		
		open_chest(north)
		deposit_all()
		use_teleport := withdraw(teleport)

		walk_path(to_trip)

		harvest(west, count, formatted_time(start_time, A_TickCount))

		if (use_teleport and use_item(teleport)) { 
			curr_pos := StrSplit(get_coordinate(), ",")
			if (abs(curr_pos[1] - 16) <= 4 and abs(curr_pos[2] - 24) <= 5) {
				bank_spot.travel() ; tp was successful
			} else {
				walk_path(to_trip, 0, true) ; tp was not successful
			}
		} else {
			walk_path(to_trip, 0, true) ; walk return trip 
		}

		count := count + 1
	}
}