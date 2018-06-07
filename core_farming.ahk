reset_queue() {
	Click, 187, 290 Left, 1
	Sleep, 250
	ImageSearch, FoundX, FoundY, 86, 299, 111, 325, %A_WorkingDir%\img\interface\queue.png
	if (ErrorLevel) {
		print("[TASK] Enabling queue mode.")
		Send, {LControl Down}
		Sleep, 100
		Send, {LControl Up}
	}
}

execute_queue() {
	ImageSearch, FoundX, FoundY, 86, 299, 111, 325, %A_WorkingDir%\img\interface\active.png
	if (ErrorLevel) {
		print("[TASK] Executing queue.")
		Send, {Space}
	}
	working := True
	while (working) {
		PixelSearch, FoundX, FoundY, 55, 174, 81, 181, 0xFFFFFF, 3, Fast RGB
		working := !ErrorLevel
		Sleep, 1000
	}
	print("[SUCCESS] Finished executing queue.")
}