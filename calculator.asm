global _start

%include "stdmac.inc"

extern conv_in_line
extern conv_in_digit_num
extern strlen
extern split_line
extern stack
extern poliz

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1


section .data
        msg_num1 db "please, write the first number:", 0
        len_num1 equ $-msg_num1

        msg_num2 db "please, write the second number:", 0
        len_num2 equ $-msg_num2

        msg_op db "please, write the operation:", 0
        len_op equ $-msg_op

        nl db 10, 0
        len_nl equ $-nl

section .bss
    buf          resd    20
    res          resd    20
    num1         resd    4
    num2         resd    4
    operation    resd    4

    
section .text
_start: 
    kernel SYS_WRITE, STDOUT, msg_num1, len_num1
    kernel SYS_READ, STDIN, num1, 4
    function conv_in_digit_num, dword [num1]        ;need fix
    mov dword [num1], eax

    kernel SYS_WRITE, STDOUT, msg_op, len_op
    kernel SYS_READ, STDIN, operation, 4

    kernel SYS_WRITE, STDOUT, msg_num2, len_num2
    kernel SYS_READ, STDIN, num2, 4
    function conv_in_digit_num, dword [num2]        ;need fix
    mov dword [num2], eax

    xor edx, edx
    mov eax, dword [num1]
    mov ecx, dword [num2]

    cmp byte [operation], 42
    je .mul
    cmp byte [operation], 43
    je .plus
    cmp byte [operation], 45
    je .sub
    cmp byte [operation], 47
    je .div

.mul:
    mul ecx
    jmp .pr_res

.plus:
    add eax, ecx
    jmp .pr_res

.sub:
    sub eax, ecx
    jmp .pr_res

.div:
    div ecx
    jmp .pr_res

.pr_res:
    mov dword [buf], eax
    function conv_in_line, dword [buf]
    mov dword [res], eax
    kernel SYS_WRITE, STDOUT, res, 3
    kernel SYS_WRITE, STDOUT, nl, len_nl
.quit:
    kernel SYS_EXIT, 0