main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. 1-20 rod fishing at Cesis.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(61, 62) 
		open_chest(south)
		deposit_all()

		; Move to fishing hole 
		move(52, 64)
		harvest(west)

		count := count + 1
	}
}