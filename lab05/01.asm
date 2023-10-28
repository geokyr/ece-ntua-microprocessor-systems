INCLUDE macros.asm     

DATA SEGMENT
    TABLE DB 128 DUP(?) 
    TWO DB DUP(2) 
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA 
    
MAIN  PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV DI,0
        MOV CX,128 
    STORE:
        MOV TABLE[DI],CL
        INC DI
        LOOP STORE
        MOV DI,1
        MOV CX,128
        MOV AX,0
  
    SUM:
        MOV AL,[TABLE + DI]
        ADD DX,AX
        ADD DI,2
        CMP DI,129
        JL SUM
        MOV AX,DX
        MOV BH,0
        MOV BL,64
        DIV BL 
        
        MOV AH,0
        CALL PRINT_DEC
        PRINTLN
        MOV AL,TABLE[0]
        MOV BL,TABLE[127]
        MOV DI,0
        MOV CX,128
    ISMAX:
        CMP AL,TABLE[DI]
        JC NEWMAX
        JMP ISMIN
    NEWMAX:
        MOV AL,TABLE[DI]
        JMP NEXT
    ISMIN:
        CMP TABLE[DI],BL
        JC NEWMIN
        JMP NEXT
    NEWMIN:
        MOV BL,TABLE[DI]
    NEXT:
        INC DI
        LOOP ISMAX
        CALL PRINT_HEX8 
        PRINTLN
        MOV AL,BL
        CALL PRINT_HEX8   
        
        EXIT
MAIN ENDP
    
    
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

PRINT_DEC proc NEAR
    MOV BL,10 
    MOV CX,1 				;decades counter
LOOP_10: 
    DIV BL				;divide number with 10
    PUSH AX                		;save units  
    CMP AL,0 				;if quotient zero I have splitted 
    JE PRINT_DIGITS_10      		;the whole number into dec digits          
    INC CX				;increase number of decades
    MOV AH,0   
    JMP LOOP_10				;if quotient is not zero I have to divide again
PRINT_DIGITS_10:
    POP DX				;pop dec digit to be printed
    MOV DL,DH
    MOV DH,0				;DX = 00000000xxxxxxxx (ASCII of number to be printed)
    ADD DX,30H				;make ASCII code
    MOV AH,2
    INT 21H				;print
    LOOP PRINT_DIGITS_10       
    RET
ENDP PRINT_DEC

CODE ENDS

END MAIN    