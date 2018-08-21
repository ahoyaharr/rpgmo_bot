main(profile) {
	initialise()
	print("[ALERT]: Bottle making at Dorpat.")
	count := 1
	start_time := A_TickCount 

	fish = sand

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to chest 
		move(22, 18) 
		open_chest(south)
		deposit_all()

		cookables := StrSplit(fish, ",")
		cookable := ""
		Loop % cookables.MaxIndex() {
		    cookable := cookables[a_index]
			if (withdraw(cookable)) {
				break
			}
			cookable := ""
		}

		if (cookable == "") {
			print("[ALERT] Finished making bottles!")
			Pause, On
		}
		close_chest()
		
		; Move to fire 
		move(22, 23)
		process(north, cookable)

		count := count + 1
	}
}