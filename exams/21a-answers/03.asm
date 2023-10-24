INCLUDE     MACROS

DATA_SEG    SEGMENT
    MSG1    DB 0AH,0DH, ‘DOSE 1o ARITHMO = $'
    MSG2    DB 0AH,0DH, ‘DOSE 2o ARITHMO = $'
    MSG3    DB 0AH,0DH, ‘DOSE 3o ARITHMO = $'
    MSG4    DB 0AH,0DH, ‘APOTELESMA = $'
    MSG5    DB 0AH,0DH, 'APOTELESMA = yperx'
DATA_SEG    ENDS

CODE_SEG    SEGMENT
    ASSUME  CS:CODE_SEG, DS:DATA_SEG

MAIN PROC FAR
    MOV     AX, DATA_SEG
    MOV     DS, AX

ADDR1:
    PRINT_STR MSG1
    CALL DEC_KEYB
    CMP AL, 'Q'
    JE QUITMAIN
    MOV BL, 10
    MUL BL          ; AL = D3*10
    MOV BL, AL      ; BL = D3*10

    CALL DEC_KEYB
    CMP AL, 'Q'
    JE QUITMAIN
    ADD AL, BL      ; AL = D3*10 + D2
    MOV BL, AL      ; BL = D3*10 + D2

    PRINT_STR MSG2
    CALL DEC_KEYB
    CMP AL, 'Q'
    JE QUITMAIN
    MOV CL, AL      ; CL = D1

    CALL DEC_KEYB
    CMP AL, 'Q'
    JE QUITMAIN
    ADD AL, CL      ; AL = D1 + D0

    MUL BL          ; AL = (D3*10 + D2) * (D1 + D0)
    
    CPM 0400H, AX
    JGE YPERX

CHECK:
    CALL WAIT_HCMP AL, ‘H’
    JE ADDR2
    JMP CHECK       ; Wait for H

ADDR2:
    ROL AX, 1       ; 4 left rotate for msbs to become lsbs
    ROL AX, 1
    ROL AX, 1
    ROL AX, 1
    MOV DL, AL      ; keep 4 lsbs of dl that are the msbs of exit
    AND DL, 0FH
    PUSH AX
    PRINT_STR MSG4
    CALL PRINT_HEX
    POP AX
    LOOP ADDR2
    JMP ADDR1

YPERX:
    PRINT_STR MSG5
    JMP ADDR1

QUITMAIN:
    EXIT

    MAIN ENDP
    CODE_SEG ENDS
    END MAIN

WAIT_H PROC NEAR
    IGNORE:
        READ
        CMP AL, 'Q'
        JE QUIT
        CMP AL, 'H'
        JNE IGNORE
    QUIT:
        RET
WAIT_H ENDP

CODE_SEG    ENDS