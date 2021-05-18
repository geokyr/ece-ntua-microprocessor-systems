;
; lab2'.asm
;
; Created: 19-May-21 01:49:36
; Author : george
;

.include "m16def.inc"

.DEF A = r16 
.DEF B = r17 
.DEF C = r18
.DEF D = r19
.DEF F0 = r20
.DEF F1 = r21
.DEF T = r22

stack:	ldi r24 , low(RAMEND)
		out SPL , r24
		ldi r24 , high(RAMEND)
		out SPH , r24

IO_set:	ser r24			; initialize PORTB
		out DDRB, r24	; for output
		clr r24			; initialize PORTA
		out DDRA, r24	; for input

main:	clr F			; ready F
		in T, PINB		; T <-- input
		andi T, 0x0F	; keep only 4 LSBs

		mov A, T		; LSB(A) = A
		lsr T
		mov B, T		; LSB(B) = B
		lsr T
		mov C, T		; LSB(C) = C
		lsr T
		mov D, T		; LSB(D) = D

		mov T, B		; save B in T
		or T, A			; T = A + B
		mov F, C		; F = C
		or F, D			; F = C + D
		mov F1, F		; F1 = C + D
		and F1, T		; F1 = (A + B) & (C + D)

		mov T, C		; T = C
		com T			; T = C'
		and T, B		; T = BC'
		and T, A		; T = ABC'
		mov F0, C		; F0 = C
		and F0, D		; F0 = CD
		or F0, T		; F0 = ABC' + CD
		com F0			; F0 = (ABC' + CD)'

		lsl F1			; F1 is moved to 2nd LSB
		mov T, F1		; T = 000000(F1)0
		or T, F0		; T = 000000(F1)(F0)
		out PORTA, T

		rjmp main