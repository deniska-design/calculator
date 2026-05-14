SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

%include "stdmac.inc"

global conv_in_line
global conv_in_digit_num
global split_line
global poliz
global stack
global strlen

section .bss
    buf         resb    20

section .text   

strlen: 
        push ebp
        mov ebp, esp
        push ecx
        xor eax, eax
        mov ecx, [ebp+8]
.lp:    cmp byte [eax+ecx], 0
        jz .quit
        inc eax
        jmp short .lp
.quit:  pop ecx                 ; eax contains the result 
        mov esp, ebp
        pop ebp
        ret

conv_in_digit_num:              ; convert num line into one number
        push ebp
        mov ebp, esp
        push ecx
        mov eax, [ebp+8]

        mov dword [buf], eax

        function strlen, buf

        mov ecx, eax
        sub ecx, 1

        push ecx
.cmp_lp: 
        sub byte [buf+ecx-1], 48
loop .cmp_lp
        pop ecx

        mov al, 1
        push ecx
.mul_lp:
        mov bh, al
        mov al, byte [buf+ecx-1]
        mul bh
        mov byte [buf+ecx-1], al

        mov al, bh
        mov bh, 10
        mul bh
loop .mul_lp        
        pop ecx
        xor eax, eax

        xor al, al
        push ecx
.sum_lp:
        add eax, dword [buf+ecx-1]
loop .sum_lp
        pop ecx

.quit:  pop ecx                 ; eax contains the result 
        mov esp, ebp            
        pop ebp
        ret


conv_in_line:                   ; convert a number into line
        push ebp
        mov ebp, esp
        push ecx
        push esi
        mov eax, [ebp+8]
        
        mov ecx, 2              ;не надо считать длину специальной функцией потому что число одно 
        mov eax, [ebp+8]
        mov ebx, 10
        mov esi, 0
.div_lp:
        xor edx, edx  
        div ebx

        push ebx
        mov dword [buf+esi], eax
        add dword [buf+esi], 48 
        kernel SYS_WRITE, STDOUT, buf, 1
        pop ebx

        mov eax, edx
        push eax

        mov eax, ebx
        mov ebx, 10
        xor edx, edx  
        div ebx
        mov ebx, eax

        pop eax
        inc esi
        
loop .div_lp

        mov eax, buf

.quit:  pop esi         ; eax contains the result
        pop ecx                  
        mov esp, ebp            
        pop ebp
        ret
