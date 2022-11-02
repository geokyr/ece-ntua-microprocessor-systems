INCLUDE macros.asm

CODE SEGMENT
	ASSUME CS:CODE
	
	MAIN PROC FAR
		START:
		    CALL HEX_KEYB		; read first hex 
			CMP AL,'T'
			MOV BH, AL          ; store it in BH 
			CALL HEX_KEYB       ; read second hex number
			CMP AL,'T'		    ; check for T to terminate
			JE FINISH			
			MOV BL,AL			; store second hex in BL
			ROL BL,4			; rotate it to 4 msb of BL 
			CALL HEX_KEYB		; read third hex number
			CMP AL,'T'          ; check for T to terminate
			JE FINISH
			OR BL,AL            ; store AL in 4 lsb of BL
						
			
			PRINT '='
			CALL PRINT__DEC		
			PRINT '='
			CALL PRINT_OCT		
			PRINT '='
			CALL PRINT_BIN		
			
			PRINTLN
			JMP START
			
		FINISH:
			EXIT
	MAIN ENDP                                                                                    
	
	HEX_KEYB PROC NEAR	       
		READ1:
			READ
			CMP AL,'T'          ; check for T		
			JE RETURN
			CMP AL,48			; check if <0
			JL READ1
			CMP AL,57			; check if >9
			JG LETTER
			PRINT AL
			SUB AL,48			; turn it to binary number
			JMP RETURN
		LETTER:					
			CMP AL,'A'		    ; check if <A
			JL READ1
			CMP AL,'F'			; check if >F
			JG READ1
			PRINT AL
			SUB AL,55			; turn hex ASCII to number
		RETURN:
			RET
	HEX_KEYB ENDP
						
	PRINT__DEC PROC NEAR
			PUSH BX
			
			MOV AX,BX           ; store BX in AX
			MOV BX,10			; BX = 10 for divisions
			MOV CX,0            ; digits counter
				
		GETDEC:  
		    MOV DX,0            ; clear previous reminder
    		DIV BX				; divide by 10
			PUSH DX				; push reminder to stack
			INC CX              ; increment digit counter
			CMP AX,0			; check if we finished with div being 0
			JNE GETDEC		
		PRINTDEC:		
			POP DX              ; pop from stack
			ADD DX,48			; add 48 for the ASCII code
			PRINT DL            ; print ASCII
			LOOP PRINTDEC       ; print CX times
			
			POP BX
			RET
	PRINT__DEC ENDP
						
	PRINT_OCT PROC NEAR         ; same with dec but we divide with 8 now
			PUSH BX
			
			MOV AX,BX
			MOV BX,8			
			MOV CX,0
				
		GETOCT:  
		    MOV DX,0
    		DIV BX				
			PUSH DX				
			INC CX
			CMP AX,0			
			JNE GETOCT		
		PRINTOCT:		
			POP DX
			ADD DX,48			
			PRINT DL
			LOOP PRINTOCT
			
			POP BX
			RET
	PRINT_OCT ENDP
					
	PRINT_BIN PROC NEAR         ; same with dec but we divide with 2 now
			PUSH BX
			
			MOV AX,BX
			MOV BX,2			
			MOV CX,0
				
		GETBIN:  
		    MOV DX,0
    		DIV BX				
			PUSH DX				
			INC CX
			CMP AX,0			
			JNE GETBIN		
		PRINTBIN:		
			POP DX
			ADD DX,48			
			PRINT DL
			LOOP PRINTBIN
			
			POP BX
			RET
			
			RET
	PRINT_BIN ENDP
CODE ENDS
END MAIN
