main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting wilows at Dorpat.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(83, 37) 
		open_chest(north)
		deposit_all()

		; Move to tree 
		move(82, 46)
		move(82, 55)
		move(81, 66)
		move(79, 76)
		move(76, 83)
		move(76, 89)
		harvest(north)

		; Return to chest
		move(76, 76)
		move(83, 66)
		move(82, 55)
		move(82, 46)
		
		count := count + 1
	}
}