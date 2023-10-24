INCLUDE	    MACROS

DATA_SEG    SEGMENT
    MSG1    DB 0AH,0DH, ‘DOSE 1o ARITHMO = $'
    MSG2    DB 0AH,0DH, ‘DOSE 2o ARITHMO = $'
    MSG3    DB 0AH,0DH, ‘DOSE 3o ARITHMO = $'
    MSG4    DB 0AH,0DH, ‘APOTELESMA = $'
    MSG5    DB 0AH,0DH, ‘OVERF$'
DATA_SEG    ENDS

CODE_SEG    SEGMENT
    ASSUME  CS:CODE_SEG, DS:DATA_SEG

MAIN PROC FAR
    MOV	AX, DATA_SEG
    MOV	DS, AX

START:
    PRINT_STR MSG1
    CALL HEX_KEYB
    CMP AL,'Q'
    JE QUIT

    MOV BL, AL

    PRINT_STR MSG2
    CALL HEX_KEYB
    CMP AL,'Q'
    JE QUIT

    MOV CL, AL

    PRINT_STR MSG3
    CALL HEX_KEYB
    CMP AL,'Q'
    JE QUIT

    AND AL,0FH
    ROL AL, 4

    MOV DL, AL

    PRINT_STR MSG3
    CALL HEX_KEYB
    CMP AL,'Q'
    JE QUIT

    ADD AL, DL
    MOV AH, 0
    MUL CL

    MOV BH, 0
    ADD AX, BX

    MOV DX, AX

    WAIT:
        READ
        CMP AL, 'H'
        JNE WAIT

    CMP DX, 999
    JG OVERFLOW
    CALL PRINT_HEX

    OVERFLOW:
        PRINT_STR MSG5

    QUIT:
        EXIT
MAIN ENDP