main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting maples at Reval.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(14, 31) 
		open_chest(north)
		deposit_all()

		; Move to tree 
		move(16, 21)
		move(20, 16)
		move(30, 16)
		move(39, 17)
		move(49, 17)
		move(59, 17)
		move(68, 19)
		move(68, 25)
		harvest(north)

		; Return to chest
		move(68, 19)
		move(59, 17)
		move(49, 17)
		move(39, 17)
		move(30, 16)
		move(20, 16)
		move(16, 23)

		count := count + 1
	}
}