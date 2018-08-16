main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting Blue Palms in the Woodcutting Guild.")

	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest.
		move(53, 61)

		; Store items and heal up.
		open_chest(south)
		deposit_all()

		; Walk to guild
		move(48, 53)
		move(52, 42)
		move(60, 41)
		move(67, 40)
		move(79, 36)
		portal_move(85, 32, 85, 34)
		move(85, 29)

		harvest(south)

		; Return trip
		portal_move(85, 35, 84, 32)
		move(74, 36)
		move(65, 40)
		move(56, 44)
		move(47, 48)
		move(51, 54)

		count := count + 1
	}
}