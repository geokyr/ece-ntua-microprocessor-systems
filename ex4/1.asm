.include "m16def.inc"

stack:	ldi r24, low(RAMEND)
		out SPL, r24
		ldi r24, high(RAMEND)
		out SPH, r24

IO_set:	ser r24			; initialize PORTA
		out DDRA, r24	; for output
		clr r24			; initialize PORTB
		out DDRB, r24	; for input

main:	ldi r26, 01		; initialize output
		ldi r22, 07		; initialize counter 
		out PORTA,r26

left:	in r24, PINB	; check input
		andi r24, 01	; repeat till it's not 1
		cpi r24, 01
		breq left
		lsl r26			; shift output 1 left
		out PORTA, r26	; send it to output
		dec r22			; decrease the counter
		cpi r22, 00		; check if it is 0
		brne left		; if it is then don't loop

right:	in r24, PINB	; check input
		andi r24, 01	; repeat till it's not 1
		cpi r24, 01
		breq right
		lsr r26			; shift output 1 right
		out PORTA, r26	; send it to output
		inc r22			; increase the counter
		cpi r22, 07		; check if it is 7
		brne right		; if it is then don't loop
		rjmp left