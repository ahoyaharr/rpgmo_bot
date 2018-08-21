main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. 50-55 wooden harpoon fishing at Ancient Dungeon.")
	count := 1
	start_time := A_TickCount 
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(44, 90) 
		open_chest(north)
		deposit_all()

		; Move to fishing hole 
		move(35, 88)
		harvest(east)

		count := count + 1
	}
}