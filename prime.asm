section        .text         
global         _start        
_start:
    mov al, byte [number] ; Load the 8-bit number to check
    mov bl, 2             ; Start divisor at 2
    xor ah, ah            ; Clear ah
    call check_loop

check_loop:
    cmp al, bl            ; number - divisor
    jle checkAndPrint     ; If divisor >= number, number is prime
    push eax              ; Saves al value to stack
    div bl                ; Divide ax by bl and store quotient in al and remainder in ah
    cmp ah, 0             ; Check if remainder is 0
    je set_notPrime       ; If remainder is 0, number is not prime
    jmp end_loop

set_notPrime:
    mov byte [answer], 0  ; Set answer to 0 (not prime)
    jmp end_loop

end_loop:
    inc bl                ; Increment divisor
    pop eax               ; retrieve al value from stack
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

    mov eax, 1             ; syscall: sys_exit
    xor ebx, ebx           ; Return 0
    int 80h                ; Call kernel


print_prime:
    mov eax, 4             ; syscall: sys_write
    mov ebx, 1             ; file descriptor: stdout
    mov ecx, prime_msg     ; Load message
    mov edx, prime_msg_len ; Length of message
    int 80h                ; Call kernel
    ; Exit program
    mov eax, 1             ; syscall: sys_exit
    xor ebx, ebx           ; Return 0
    int 80h                ; Call kernel

    section        .data       

    number db 107 ; input value
    answer db 1 ; 1 means number is prime,
    ; 0 means number is not prime   

    prime_msg db "Number is prime", 0x0a
    prime_msg_len equ $ - prime_msg


    not_prime_msg db "Number is NOT prime", 0x0a
    not_prime_msg_len equ $ - not_prime_msg