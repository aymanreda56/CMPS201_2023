.model small
.data
DATA1 dw 0D37EH, 0F8A8H, 5463H  ;first operand, notice how I declared them reversed
DATA2 dw 92C2H, 3408H, 87DEH    ;second operand
DATA3 db 7 dup(?)               ;reserve storage for result, why 7 bytes not 6??

.code
main proc far

MOV AX, @data ;DONT forget those 2 lines
MOV DS, AX

MOV CX, 0       ; our counter
MOV DI, offset DATA1 ; store the address of the beginning of DATA1 into DI
MOV SI, offset DATA2 ; store the address of the beginning of DATA2 into SI
MOV BX, offset DATA3 ; store the address of the beginning of DATA3 into BX
CLC                  ; Clear Carry

addition_loop:
CMP CX, 3
JE end_loop

MOV AX, [DI]
ADC AX, [SI]
MOV [BX], AX        ; Store the result of the addition

ADD DI, 2   ;increment our indices
ADD SI, 2
ADD BX, 2
INC CX
jmp addition_loop

end_loop:

; dont forget to put the last carry in an additional byte, if there is any carry
MOV AL, 0
ADC AL, 0
MOV [BX], AL        ; Store the result of the addition
main endp
end main