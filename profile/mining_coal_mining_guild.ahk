main() {
	initialise()
	print("[ALERT]: Routine loaded. Mining coal at the Mining Guild.")

	count := 1
	start_time := A_TickCount 

	teleport = dorpat_teleport

	to_trip := [new Coordinate(31, 18), new Coordinate(43, 17), new Coordinate(51, 18)
			   ,new Portal(56, 14, 32, 15), new Coordinate(32, 22)]

	from_trip := [new Portal(31, 15, 57, 14), new Coordinate(50, 17), new Coordinate(39, 17)
				 ,new Coordinate(29, 18), new Coordinate(22, 18)]

	move(22, 18)
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		
		open_chest(south)
		deposit_all()
		; withdraw(teleport)

		walk_path(to_trip)

		harvest(north, count, formatted_time(start_time, A_TickCount))

		walk_path(from_trip)

		; Loop {
		; 	if (!use_item(teleport)) {
		; 		print("[WARNING]: could not find " . teleport . ", walking back instead")
		; 		walk_path(from_trip)
		; 	} 
		; 	sleep, 5000
		; 	curr_pos := StrSplit(get_coordinate(), ",")
		; 	if (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5) {
		; 		move(22, 18)
		; 	}

		; } Until (abs(curr_pos[1] - 20) <= 4 and abs(curr_pos[2] - 20) <= 5)
		count := count + 1
	}
}