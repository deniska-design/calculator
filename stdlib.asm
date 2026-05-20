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
    buf         resd    20

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
        push ecx
.sum_lp:
        add al, byte [buf+ecx-1]
loop .sum_lp
        pop ecx

.quit:  mov esp, ebp          ; eax contains the result             
        pop ebp
        ret


conv_in_line:                   ; convert a number into line
        push ebp
        mov ebp, esp
        push ecx
        push esi
        mov eax, [ebp+8]
        
        mov ecx, 3              
        mov eax, [ebp+8]
        mov ebx, 100
        mov esi, 0
.div_lp:
        xor edx, edx  
        div ebx

        push ebx
        mov dword [buf+esi], eax
        add dword [buf+esi], 48 
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

        mov eax, dword [buf]

.quit:  pop esi         ; eax contains the result
        pop ecx                  
        mov esp, ebp            
        pop ebp
        ret
