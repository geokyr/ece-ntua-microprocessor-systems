include “m16def.inc”

reset:
    ldi r24, low(RAMEND)
    out SPL, r24
    ldi r24, high(RAMEND)
    out SPH, r24
    ser r24
    out DDRC, r24
    clr r24
    out DDRA, r24
    ldi r24, 0b11111111
    out PORTA , r24

    in r24, PINA
    and r24, 0b00000100 ; check a0
    cpi r24, 0          ; if not on ground
    jnz mov_ground      ; go to ground

main:
    ldi r22,0b00000000
    out PORTC, r22      ; stop moving
    in r24, PINA
    mov r23,r24
    and r24, 0b00000001 ; if moving
    cpi r24, 0
    jnz moving          ; check where to
    jmp main            ; else loop

moving:
    mov r24,r23
    and r24, 0b00001000 ; move to 1st floor
    cpi r24, 0
    jnz mov_floor
    mov r24,r23
    and r24, 0b00010000 ; move to ground
    cpi r24, 0
    jnz mov_ground
    jmp main

mov_ground:
    in r24,PINA
    and r24, 0b00000100 ; if on ground loop main
    jnz main
    ldi r22,0b00000001
    out PORTC, r22      ; else move to ground and check again
    jmp mov_ground

mov_floor:
    in r24,PINA
    and r24, 0b00000010 ; if on floor loop main
    jnz main
    ldi r22,0b00000010  ; else move to floor and check again
    out PORTC, r22
    jmp mov_floor