INCLUDE macros.asm 
 
DATA SEGMENT
    MSG1 DB "Z=$"
    MSG2 DB "W=$"
    MSG3 DB "Z+W=$"
    MSG4 DB "Z-W=$"
    MSG5 DB "Z-W=-$"
    Z DB 0
    W DB 0
    SPACE DB " $" 
    TEN DB DUP(10)
DATA ENDS 
 
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MAIN PROC FAR
        MOV AX,DATA
        MOV DS,AX   
        
    START: 
        PRINT_STR MSG1 ;print Z=
        CALL READ_DEC_DIGIT    ; read the first digit(tens) of Z
        MUL TEN                ; multiply it so its on ten base
        LEA DI,Z 
        MOV [DI],AL            ; store AL(decadal digit of Z) for  in [DI] = Z 
        CALL READ_DEC_DIGIT    ; read the second digit(ones) of Z  
        ADD [DI],AL            ; store it in [DI] = Z 
        PRINT ' '
        PRINT_STR MSG2         ; same procedure with Z for W
        CALL READ_DEC_DIGIT 
        MUL TEN
        LEA DI,W 
        MOV [DI],AL
        CALL READ_DEC_DIGIT 
        ADD [DI],AL 
        PRINTLN                ; print new line

        MOV AL,[DI]            ; AL = W
        LEA DI,Z               ; DI points to Z
        ADD AL,[DI]            ; ADD Z + W
        PRINT_STR MSG3         ; print 'Z+W='
        CALL PRINT_HEX8        ; print the sum in hex
        PRINT ' '

        MOV AL,[DI]            ; AL = Z
        LEA DI,W 
        MOV BL,[DI]            ; BL = W
        CMP AL,BL              ; compare Z with W
        JB MINUS               ; jump if Z < W
        SUB AL,BL              ; else Z - W
        PRINT_STR MSG4         ; print "Z-W=" because the sub is positive
        JMP SHOWSUB            ; jump to address for printing the sub
    MINUS:
        SUB BL,AL              ; W - Z because Z<W 
        MOV AL,BL              ; keep the positive value of the sum in AL
        PRINT_STR MSG5         ; print "Z-W=-" because Z<W and the sub and AL has the absolute value of it
SHOWSUB:
        CALL PRINT_HEX8        ; print sub in hex
        PRINTLN
        PRINTLN
        JMP START              ; jump to start for continuous running
MAIN ENDP

INPUT_TO_HEX PROC NEAR 
     PUSHF
     SUB DH,30H                 
     SUB DL,30H                 
     MOV BL,10                  
     MOV AL,DH                  
     MUL BL                    
     ADD AL,DL                 
     MOV DL,AL                 
     POPF
     RET
ENDP INPUT_TO_HEX
READ_DEC_DIGIT PROC NEAR
    READ1:
        READ
        CMP AL,48 
        JB READ1
        CMP AL,57 
        JA READ1
        PRINT AL
        SUB AL,48 
        RET
READ_DEC_DIGIT ENDP 
        
 
PRINT_HEX8 PROC NEAR
    MOV DL,AL
    AND DL,0F0H
    MOV CL,4
    RCR DL,CL
    CALL PRINT_HEX;
    MOV DL,AL
    AND DL,0FH
    CALL PRINT_HEX
    RET
PRINT_HEX8 ENDP

PRINT_HEX PROC NEAR
    CMP DL,9
    JG ADDR1
    ADD DL,30H
    JMP ADDR2
ADDR1:
    ADD DL,37H
ADDR2:
    PRINT DL
    RET
PRINT_HEX ENDP    

CODE ENDS

END MAIN