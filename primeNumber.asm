section        .text         
global         _start        
_start:
    mov al, byte [number] ; Load the 8-bit number to check
    mov bl, 2             ; Start divisor at 2

check_loop:
    cmp al, bl            ; Compare divisor with the number
    jle print_prime       ; If divisor >= number, number is prime
    xor ah, ah            ; Clear ah for division
    mov al, byte [number] ; Move the number into the lower byte of ax (al)
    div bl                ; Divide ax by bl and store quotient in al and remainder in ah
    cmp ah, 0             ; Check if remainder is 0
    je print_not_prime    ; If remainder is 0, number is not prime
    inc bl                ; Increment divisor
    jmp check_loop        ; Repeat the loop

; print statements

print_not_prime:
    mov ecx, not_prime_msg ; Load message
    mov edx, not_prime_msg_len ; Length of message
    jmp print_result

print_prime:
    mov ecx, prime_msg    ; Load message
    mov edx, prime_msg_len ; Length of message
    jmp print_result

print_result:
    mov eax, 4             ; syscall: sys_write
    mov ebx, 1             ; file descriptor: stdout
    int 0x80               ; Call kernel
    ; Exit program
    mov eax, 1             ; syscall: sys_exit
    xor ebx, ebx           ; Return 0
    int 0x80               ; Call kernel

    section        .data       

    number db 17 ; input value
    prime_msg db "Number is prime", 0x0a
    prime_msg_len equ $ - prime_msg


    not_prime_msg db "Number is NOT prime", 0x0a
    not_prime_msg_len equ $ - not_prime_msg