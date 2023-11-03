.model small
.data
DATA1 DW 0D37EH, 0F8A8H, 5463H  ;first operand, notice how I declared them reversed
DATA2 DW 92C2H, 3408H, 87DEH    ;second operand
DATA3 DB 6 dup(?)               ;reserve storage for result, why 6 bytes not 7??

.code
main proc far
MOV AX, @data ;DONT forget those 2 lines
MOV DS, AX

MOV CX, 0       ; our counter
MOV DI, offset DATA1 ; store the address of the beginning of DATA1 into DI
MOV SI, offset DATA2 ; store the address of the beginning of DATA2 into SI
MOV BX, offset DATA3 ; store the address of the beginning of DATA3 into BX
CLC                    ; Clear Carry

subtract_loop:
CMP CX, 2
JE end_of_loop

MOV AX, [DI]
SBB AX, [SI]
MOV [BX], AX        ; Store the result of the Subtraction

ADD DI, 2   ;increment our indices
ADD SI, 2
ADD BX, 2
INC CX
jmp subtract_loop

end_of_loop:

; Dont we need to make an extra step to preserve the borrow?
; Answer: no :) if there is an extra borrow, we can simply underflow
; the entire register and turn it negative.
; 

main endp
end main