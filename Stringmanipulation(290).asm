;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
		
string	DCB		"aB10"
stringe	DCB		"0"
nstring	DCB		"AAAA"
tot		FILL	4

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC

		LDR		r1,=string	;r1 ist die Adresse des String
		LDR		r5,=stringe	;r5 ist die Adresse des Ende des Strings
		LDR		r0,=nstring	;r0 ist die Adresse des Neuen String
		SUB		r6,r5,r1	;Die Länge des Strings wird ermittelt und in r6 geladen, als Zähler
loop	LDRB	r2,[r1]		;Das aktuelle Zeichen des Strings wird in r2 geladen
		SUBS	r2,r2,#58	;Der Wert des aktuellen Zeichen wird mit 58 subtrahiert, alle Zahlen sind nun negativ, alle Schriftzeichen positiv
		BMI		dann		;Wenn das Zeichen negativ ist springe zu "dann"
		B		sonst		;Ansonsten zu "sonst"
dann	MOV		r4,#"1"		;Lade in r4 den Wert "1"
		B		skip		;Springe zu skip um zu verhindern, dass "0" in r4 geladen wird
sonst	MOV		r4,#"0"		;In r4 wird der Wert "0" geladen
skip	STRB	r4,[r0]		;Lade r4 zur aktuellen Stelle von r0
		ADD		r1,r1,#1	;Gehe zur nächsten Stelle des Strings
		ADD		r0,r0,#1	;Gehe zur nächsten Stelle des Endstrings
		SUB		r6,r6,#1	;Subtrahiere vom Zähler 1
		CMP		r6,#0		;Vergleiche ob der Zähler bei 0 angekommen ist
		BNE		loop		;Sollte dies nicht der Fall sein wird der Vorgang wiederholt
		LDR		r3,=tot		;In r3 wird der reservierte Speicher geladen
		SUB		r0,#4		;r0 wird zum Anfang des Neuen Strings gesetzt
		MOV		r3,r0		;In r3 wird der Endstring gespeichert