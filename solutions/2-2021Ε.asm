.include "m16def.inc"
.DEF temp = r16
.DEF counter = r17
.DEF input = r18
.DEF output = r19
.DEF a1 = r20
.DEF a0 = r21
.DEF reset = r22

start: 
    clr temp
    out DDRA,temp 
    ser temp
    out DDRC,temp

    ldi counter,0x1E
    ldi output,0x91
    out PORTC,output

loop:
    in input,PINA
    andi input,0x07
    mov reset,input
    andi reset,0x01
    cpi reset,0x01
    breq resetcounter

    mov a0,input
    mov a1,input
    andi a0,0x02
    andi a1,0x04

    cpi a0,0x02
    brneq carinput

    cpi a1,0x04
    brneq caroutput
    rjmp loop

carinput:
    dec counter
    cpi counter,0x0A
    brlt lessthanten
    ldi output,0x91
    out PORTC,output
    rjmp loop

caroutput:
    inc counter
    cpi counter,0x0A
    brlt lessthanten
    ldi output,0x91
    out PORTC,output
    rjmp loop

lessthanten:
    mov output,counter
    lsl 
    lsl
    lsl
    lsl
    andi output,0xF0
    out PORTC,output
    rjmp loop

resetcounter:
    ldi counter,0x1E
    ldi output,0x91
    out PORTC,output
    rjmp loop

end:
    .exit