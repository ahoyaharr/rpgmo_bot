Class Console {
        Alloc() {
            DllCall("AllocConsole")
        }
        
        Free() {
            DllCall("FreeConsole")
        }
        
        Print(Str) {
            try
                FileAppend, % Str, CONOUT$
        }
    }

print(s, indentation_level=0) {
    if (indentation_level <= 0) {
        Console.Print(t . s . "`n")
    } else {
        print("`t" . s, indentation_level - 1)
    }
}