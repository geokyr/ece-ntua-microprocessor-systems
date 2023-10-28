INCLUDE macros.asm

DATA SEGMENT
	STARTPROMPT DB "START(Y,N):$"; Starting message
	ERRORMSG DB "ERROR$"		 ; Error message
ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
	
	MAIN PROC FAR
			MOV AX,DATA
			MOV DS,AX
			
			PRINT_STR STARTPROMPT
		START:			        ; Read Y or N
			READ
			CMP AL,'N'			; = N ?
			JE FINISH			; End program
			CMP AL,'Y'			; = Y ?
			JE CONT				; Continue program
			JMP START
		CONT:
			PRINT AL			; Print starting character
			PRINTLN
			PRINTLN
		NEWTEMP:
			MOV DX,0
			MOV CX,3			; 3 HEX digits
		READTEMP:		        ; Read input
			CALL HEX_KEYB		; Read first bit
			CMP AL,'N'			; Check if it is N
			JE FINISH
						        ; Get digits to DX
			PUSH CX
			DEC CL				; For the shift
			ROL CL,2			
			MOV AH,0
			ROL AX,CL			; Shift left 8, 4, 0 digits
			OR DX,AX			; Add digit to the number
			POP CX
			LOOP READTEMP
			
			PRINTTAB
			MOV AX,DX
			CMP AX,2047			; V <= 2 ?
			JBE BRANCH1
			CMP AX,3071			; V <= 3 ?
			JBE BRANCH2
			PRINT_STR ERRORMSG	; V > 3
			PRINTLN
			JMP NEWTEMP
			
		BRANCH1:		        ; 1st branch: V <= 2, T = (800 * V) div 4095
			MOV BX,800
			MUL BX
			MOV BX,4095
			DIV BX
			JMP SHOWTEMP
		BRANCH2:		        ; 2nd branch: 2 < V <= 3, T = ((3200 * V) div 4095) - 1200
			MOV BX,3200
			MUL BX
			MOV BX,4095
			DIV BX
			SUB AX,1200
		SHOWTEMP:
			CALL PRINT_DEC16	; Print integer part stored on AX
						        ; Decimal part = (remainder * 10) div 4095
			MOV AX,DX
			MOV BX,10
			MUL BX
			MOV BX,4095
			DIV BX
			
			PRINT '.'			; Dot for decimal part
			ADD AL,48			; ASCII code
			PRINT AL			; Print decimal part
			PRINTLN
			JMP NEWTEMP
			
		FINISH:
			PRINT AL
			EXIT
	MAIN ENDP
						        ; Insert HEX bit into AL
	HEX_KEYB PROC NEAR	        ; see: mP11_80x86_programs.pdf pg. 20-21
		READ:
			READ
			CMP AL,'N'			; = N ?
			JE RETURN
			CMP AL,48			; < 0 ?
			JL READ
			CMP AL,57			; > 9 ?
			JG LETTER
			PRINT AL
			SUB AL,48			; ASCII code
			JMP RETURN
		LETTER:					; A ... F
			CMP AL,'A'			; < A ?
			JL READ
			CMP AL,'F'			; > F ?
			JG READ
			PRINT AL
			SUB AL,55			; ASCII code
		RETURN:
			
			RET
	HEX_KEYB ENDP
							    ; Print 16-bit decimal number from AX
	PRINT_DEC16 PROC NEAR	    ; see: mP11_80x86_programs.pdf pg. 26-27
			PUSH DX
			
			MOV BX,10			; Decimal -> divide by 10
			MOV CX,0			; Digits counter
		GETDEC:			        ; Get digits
			MOV DX,0			; Number mod 10 (remainder)
			DIV BX				; Divide by 10
			PUSH DX				; Store it temporarily
			INC CL
			CMP AX,0			; Number div 10 = 0 ? (quotient)
			JNE GETDEC
		PRINTDEC:		        ; Print digits
			POP DX
			ADD DL,48			; ASCII code
			PRINT DL
			LOOP PRINTDEC
			
			POP DX
			RET
	PRINT_DEC16 ENDP

CODE ENDS

END MAIN