main(profile) {
	initialise()
	print("[ALERT]: Power mining routine loaded.")
	count := 0
	start_time := A_TickCount 
	Loop {
		harvest(north)
		destroy_all()
		count := count + 1
		print("[STATUS]: Finished mining " . count . " inventories.")
	}
}
