	AREA MyData, DATA, align = 2
		
string	DCB		"aaab0"	
count	DCD		0
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
		
		LDR		r0,=count	;r0 ist der Zaehler
		MOV		r0,#0		;Zaehler fängt bei 0 an
		LDR		r1,=string	;Der String wird in r1 geladen	
loop	LDRB	r2,[r1]		;Das aktuelle Zeichen des Strings wird in r2 geladen
		CMP		r2,#"a"		;Das aktuelle Zeichen wird mit "a" verglichen
		BNE		skip		;Ist das aktuelle Zeichen kein "a" wird der nächste Schrit übersprungen
		ADD		r0,r0,#1	;Auf den Zähler wird 1 addiert
skip	ADD		r1,r1,#1	;Die nächste Stelle des Strings wird in r1 ausgewählt
		CMP		r2,#"0"		;Es wird geguckt ob das aktuelle Teichen 0 ist
		BNE		loop		;Sollte dies nicht der Fall sein wird der Vorgang wiederholt
		LDR		r3,=tot		;In r3 wird der reservierte Speicher geladen
		STR		r0,[r3]		;In r3 wird der Zählerstand gespeichert