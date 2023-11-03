.model small
.stack 64

.Data
InputString DB "THis iS A TEsT MESsaGE"
ResultString DB 22 DUP(?)

.code
main proc far

mov ax, @data       ;load the data section into the data segment
mov ds, ax

mov cx, 0           ; our counter, from 0 to 22
mov si, offset InputString      ;address of first element of InputString
mov di, offset ResultString     ;address of first element of ResultString

mov bh, 'A'                 ;bh now contains the ascii of capital A which is 41h
mov bl, 'a'                 ;bl now contains the ascii of lower A which is 61h

small_case_loop:
    cmp cx, 22                  ;loop exit condition
    jge end_loop

    mov dl, [si]
    cmp dl, bl                  ; Check if the ascii of the letter is greater than "a", ie a smallcase letter
    jge next

    cmp dl, bh                  ; if the char was not lower case, Check if it is upper case (by checking if char > "A")
    jl next

    ;if the char > "A", add 20h to it
    ADD dl, 20h

    next:
        mov [di], dl           ; store the result
        inc cx                 ; increment the loop counter
        inc DI                 ; increment the InputString pointer
        inc si                 ; increment the ResultStrig pointer
        jmp small_case_loop    ; do one more loop iteration

end_loop:

main endp
end main