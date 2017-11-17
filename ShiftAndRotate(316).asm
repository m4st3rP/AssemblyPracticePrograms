main	PROC
			MOV		r0,#0xAFFE		;Schiebe unseren Wert nach r0
			B		RotateL5		;Springe zu Unterprogramm
Bitcompare	MOV		r4,#0xFFFE		;Schiebe FFFE in r4 als 2. Operand für das spätere löschen
			MOV		r1,#0xFFFF		;Schiebe unsere Zahl in r1
			MOV		r3,r1,LSR #7	;Verschiebe unsere Zahl so, dass das 7 Element LSB steht und speichere in r3
			BIC		r1,r4			;Lösche alle außer das LSB unserer Zahl
			BIC		r3,r4			;Lösche alle außer das LSB unserer nach rechts geshifteten Zahl
			CMP		r1,r3			;Vergleiche das LSB
			BEQ		gleich			;Springe zu gleich wenn sie gleich sind
			B		ungleich		;Springe ansonsten zu ungleich
gleich		MOV		r2,#0x0000		;Schiebe 0 in r2
			B		ende			;Springe zum Ende
ungleich	MOV		r2,#0x0001		;Schiebe 1 in r2
			B		ende			;Springe zum Ende
RotateL5	MOV		r5,r0,LSL #1	;Verschiebe r0 nach links und speichere in r5
			MOV		r6,r0,LSR #4	;Verschiebe r0 nach rechts und speichere in r6
			MOV		r7,#0xFFE1		;Speicher Löschwert in r7
			BIC		r5,r7			;Lösche irrelevante Bits in r5
			MOV		r8,#0xFFFE		;Speicher Löschwert in r8
			BIC		r6,r8			;Lösche irrelevante Bits in r6
			BIC		r0,#0x001F		;Lösche irrelevante Bits in r0
			ORR		r5,r6			;Kombiniere r5 mit r6
			ORR		r0,r5			;Kombiniere Kombination mit r0
			MOV		r9,r0,LSR #1	;Schiebe Kombination nach rechts (um 32. Stelle die beim linksshift entstanden ist zu löschen)
			MOV		r10,#0x8000		;Speicher Löschwert in r10
			BIC		r9,r10			;Lösche irrelevante Bits in r9
			MOV		r9,r9,LSL #1	;Schiebe r9 nach links
			ORR		r9,r6			;kombiniere r9 mit r6
			MOV		r0,r9			;Speichere r9 in r0
ende