section        .text
; Group Members
; Daniel Haselock ID 40276733
; Student Two ID 22222222
; Student Three ID 33333333

global         _start        
_start:
    mov al, byte [number] ; Load input number (1 byte)
    mov bl, 2             ; Start divisor at 2
    xor ah, ah            ; Clear ah
    call check_loop       ; Call loop

check_loop:
    cmp al, bl            ; compare input and divisor (input - divisor)
    jle checkAndPrint     ; if compare <= 0 loop should end
    push eax              ; Saves al(input) and ah(0x00) value to stack
    div bl                ; Divide ax by bl and store quotient in al and remainder in ah
    cmp ah, 0             ; Check if remainder is 0
    je set_notPrime       ; If remainder is 0, goto notPrime
    jmp end_loop          ; goto end_loop

set_notPrime:
    mov byte [answer], 0  ; Set answer to 0 (not prime)
    jmp end_loop          ; goto end_loop

end_loop:
    inc bl                ; Increment divisor
    pop eax               ; retrieve al(input) and ah(0x00) from stack
    jmp check_loop        ; Repeat the loop


; print statements
checkAndPrint:
    cmp byte [answer], 0   ; Check if answer is 0 (not prime)
    je print_not_prime     ; If not prime, print not prime message
    jmp print_prime        ; Else, print prime message

print_not_prime:
    mov eax, 4             ; syscall: sys_write
    mov ebx, 1             ; file descriptor: stdout
    mov ecx, not_prime_msg ; Load message
    mov edx, not_prime_msg_len ; Length of message
    int 80h                ; Call kernel
    jmp exitProgram

print_prime:
    mov eax, 4             ; syscall: sys_write
    mov ebx, 1             ; file descriptor: stdout
    mov ecx, prime_msg     ; Load message
    mov edx, prime_msg_len ; Length of message
    int 80h                ; Call kernel
    jmp exitProgram

exitProgram:
    mov eax, 1             ; syscall: sys_exit
    xor ebx, ebx           ; Return 0
    int 80h                ; Call kernel


    section        .data       
    number db 97                                 ; input value (should be below 128)
    answer db 1                                  ; answer value (we start by assuming it is prime = 1)

    prime_msg db "Number is prime", 0x0a         ; Prime message
    prime_msg_len equ $ - prime_msg              ; Prime Message length


    not_prime_msg db "Number is NOT prime", 0x0a ; Not Prime message
    not_prime_msg_len equ $ - not_prime_msg      ; Not Prime message length