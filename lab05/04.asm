INCLUDE macros.asm

DATA SEGMENT
CHARS DB 20 DUP(?) 
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA

MAIN PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV CL,0            ; digits counter
    START:
        MOV DI,0            ; array pointer
    NEXTCHAR: 
        READ
        CMP AL,61           ; check for "=" 
        JE FINISH           ; if input is "=" then terminate the programm
        CMP AL,13           ; if input is ENTER
        JE OUTPUT           ; stop reading and go to the output
        CMP AL,48           ; check if input<0
        JB NEXTCHAR
        CMP AL,122          ; check if input>z
        JA NEXTCHAR
        CMP AL,57           ; check if input<=9 
        JBE SAVECHAR        ; then in addition with the previous checks our character is acceptable
        CMP AL,97           ; check if input<a
        JB NEXTCHAR
    SAVECHAR:
        PRINT AL            ; print the accepted input
        MOV CHARS[DI],AL    ; save it on the array chars
        INC DI
        INC CL
        CMP CL,20 
        JB NEXTCHAR
    OUTPUT:
        PRINTLN             ; print new line
        CMP CL,0 
        JE NEXTCHAR         ; check for empty area
        MOV CX,20           ; array size
        MOV DI,0            ; index to start of the array
    LETTERS:
        MOV AL,CHARS[DI]
        CMP AL,97           ; check if it is lower case letter
        JB SKIP
        CMP AL,122          ; check if it is lower case letter
        JA SKIP             
        SUB AL,32           ; lower case to upper case
        PRINT AL            ; print the upper case letter
    SKIP:
        INC DI              ; procceed to the next element of the array
        LOOP LETTERS        ; loop through the whole array printing only letters
        PRINT "-"           ; print "-"
        MOV CX,20           ; counter of array size
        MOV DI,0            ; index to start of the array
    NUMBERS:
        MOV AL,CHARS[DI]
        CMP AL,48           ; check if it is a number
        JB SKIP2
        CMP AL,57           ; check if it is a number
        JA SKIP2
        PRINT AL            ; if its is number print it
    SKIP2:
        INC DI              ; go the next element
        LOOP NUMBERS        ; loop through the whole array printing only numbers
        PRINTLN             ; print new line
        JMP START           ; jump to start
    FINISH:
        EXIT

MAIN ENDP

CODE ENDS

END MAIN