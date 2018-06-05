main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Cutting firs at Dorpat.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(22, 18) 
		open_chest(south)
		deposit_all()

		; Move to tree 
		move(23, 27)
		harvest(east)

		count := count + 1
	}
}