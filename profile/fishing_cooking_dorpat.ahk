main(profile) {
	initialise()
	print("[ALERT]: Routine loaded. Fishing/cooking at Dorpat.")
	count := 1
	start_time := A_TickCount 

	food = raw_perch,raw_frog,raw_trout,raw_sardine,raw_pike
	f := StrSplit(food, ",")

	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . FormatSeconds(A_TickCount - start_time))

		; Move to fishing location; harvest fish 
		move(16, 9)
		harvest(south)

		; Move to fire location; cook
		move(17, 17)
		Loop % f.MaxIndex() {
		    t := f[a_index]
		    use_item(t)
			while (has_item(t)) {
				hazard_check()
				move_north(1)
				sleep, 7500
			}
		}

		; Deposit items
		move(21, 17)
		open_chest(east)
		deposit_all()
	}
}