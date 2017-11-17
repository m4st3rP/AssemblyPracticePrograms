		
main
		LDR		r2,=Size
		LDR		r2,[R2]
		MOV		r0,#0
		LDR		r3,=Vec
LOOP		LDR		r5,[r3]
		SUB		r2,r2,#1
		ADD		r0,r0,r5
		ADD		r3,r3,#4
		CMP		r2,#0
		BNE		LOOP
		LDR		r6,=Tot
		STR		r0,[r6]
		
ALIGN
Size		DCD		3 ; 1 Wort, enthaelt Anzahl der Woerter
Vec		DCD		3,-1,2 ; 3 Woerter
Tot		FILL		4 ; Reserviert 4 Bytes fuer Ergebnis
		END
