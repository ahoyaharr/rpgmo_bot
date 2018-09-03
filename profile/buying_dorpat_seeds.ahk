main() {
	initialise()
	print("[ALERT]: Routine loaded. Buying seeds from the Dorpat farmer.")

	count := 1
	start_time := A_TickCount 

	item = wheat_seed 
	player_inventory_size = 38
	pet_inventory_size = 16

	move(22, 18)
	Loop {
		print("[ALERT] Cycle " . count . " begins @ " . formatted_time(start_time, A_TickCount))
		
		open_chest(south)
		deposit_all()

		move(31, 21)
		open_shop(east)
		buy_item(item, pet_inventory_size)
		load_pet_inventory()
		buy_item(item, player_inventory_size)
		move(22, 18)
		count := count + 1
	}
}