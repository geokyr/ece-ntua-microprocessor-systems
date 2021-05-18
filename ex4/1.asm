;
; AssemblerApplication1.asm
;
; Created: 18-May-21 22:35:13
; Author : george
;

.include "m16def.inc"

stack:	ldi r24, low(RAMEND)	; initialize stack pointer
		out SPL, r24
		ldi r24, high(RAMEND)
		out SPH, r24

IO_set:	ser r24			; initialize PORTA
		out DDRA, r24	; for output
		clr r24			; initialize PORTB
		out DDRB, r24	; for input

main:	ldi r26, 01		; initialize r26
		ldi r22, 07		; counter 
		out PORTA,r26

left:	in r24, PINB	; check input
		subi r24, 01	; repeat till it's not 1
		breq left
		lsl r26
		out PORTA, r26
		dec r22
		cpi r22, 00
		brne left

right:	in r24, PINB	; check input
		subi r24, 01	; repeat till it's not 1
		breq right
		lsr r26
		out PORTA, r26
		inc r22
		cpi r22, 07
		brne right
		rjmp left