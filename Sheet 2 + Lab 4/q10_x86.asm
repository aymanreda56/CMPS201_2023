.model small
.stack 64
.data
Grades db 81, 65, 77, 82, 73, 55, 88, 78, 51, 91, 86, 76    ;grades as a byte each
ResultGrades db 12 dup (?)                                  ;space for the result


.code
main proc far
    mov ax, @data   ;data segment
    mov ds, ax

    mov cx, 0               ; loop counter
    mov si, offset Grades   ;pointer to Grades
    mov di, offset ResultGrades ;pointer to result

    mov ax, 0               ;I will put the max value of all grades into ax, so I initialize the max to 0
    mov bx, 0               ;just to initialize things

    findMaxLoop:
        cmp cx, 12          ;exit condition
        jge endMaxloop

        mov bl, [si]        ;read each grade as a byte
        cmp bl, al          ;compare this grade with the current max, if the current grade is greater, then reassign a new max grade
        jle next:           ;skip if the grade is not greater than the max
        mov al, bl
        next:
        inc cx
        inc si
        jmp findMaxLoop
    endMaxloop:

    mov dx, 99          ;I will put the difference between 99 and max grade in dx
    SUB dx, ax

    mov cx, 0           ; dont forget to reinitialize loop counter
    mov si, offset Grades   ;also dont forget to reinitialize input pointer

    scaleGradesLoop:
        cmp cx, 12      ;exit condition
        jge endloop
        MOV bx, [si]    ;load grade into bx
        ADD bx, dx      ;add the difference to this grade
        mov [di], bx    ;store the new grade into result

        ;increment loop counter and both pointers
        inc DI          
        inc si
        inc cx
        jmp scaleGradesLoop


    endloop:

main endp
end main