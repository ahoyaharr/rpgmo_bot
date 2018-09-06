main() {
	initialise()
	print("[ALERT]: Routine loaded. Mining gold at Reval.")

	count := 1
	start_time := A_TickCount 

	teleport = reval_teleport
	bank_spot := new Coordinate(14, 31)

	to_trip := [new Coordinate(16, 19), new Coordinate(29, 20), new Coordinate(41, 23)
			   ,new Coordinate(55, 24), new Coordinate(69, 25), new Coordinate(70, 35)
			   ,new Coordinate(68, 38), new Coordinate(67, 38)]

	from_trip := [new Coordinate(69, 26), new Coordinate(61, 20)
				 ,new Coordinate(53, 15), new Coordinate(42, 15), new Coordinate(31, 15)
				 ,new Coordinate(20, 15), new Coordinate(16, 23), bank_spot]

	bank_spot.travel()
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		
		open_chest(north)
		deposit_all()
		use_teleport := withdraw(teleport)

		walk_path(to_trip)

		harvest(west, count, formatted_time(start_time, A_TickCount))

		if (use_teleport and use_item(teleport)) { 
			loop {
			curr_pos := StrSplit(get_coordinate(), ",")
				curr_pos := StrSplit(get_coordinate(), ",")
				if (!(abs(curr_pos[1] - 16) <= 4 and abs(curr_pos[2] - 24) <= 5)) {
					use_item(teleport)
				}
			} until (abs(curr_pos[1] - 16) <= 4 and abs(curr_pos[2] - 24) <= 5)
			bank_spot.travel()
		} else {
			if (monster_exists(1, 0, "fire_viper")) {
				print("[STATUS] Detected monster blocking exit path. Fighting.")
				attempt_combat(3, east)
				destroy_loot_crate()
			}
			walk_path(from_trip) ; walk return trip 
		}

		count := count + 1
	}
}