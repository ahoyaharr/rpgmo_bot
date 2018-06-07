main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Mining sand at Reval.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(14, 31) 
		open_chest(north)
		deposit_all()

		; Move to tree 
		move(8, 30)
		move(8, 33)
		harvest(north)

		; Return to chest
		move(10, 22)

		count := count + 1
	}
}