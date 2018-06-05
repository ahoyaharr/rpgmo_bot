main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting spirits at Walco.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(24, 30) 
		open_chest(south)
		deposit_all()

		; Move to tree 
		move(32, 33)
		move(33, 36)
		move(37, 32)
		move(43, 32)
		move(43, 34)
		move(44, 34)
		move(44, 36)
		move(49, 36)
		move(49, 33)
		move(55, 33)
		move(58, 34)
		harvest(south)

		; Return to chest
		move(55, 33)
		move(49, 33)
		move(49, 36)
		move(44, 36)
		move(44, 34)
		move(43, 34)
		move(43, 32)
		move(37, 32)
		move(33, 36)
		move(32, 33)

		count := count + 1
	}
}