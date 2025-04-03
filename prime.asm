section        .text         
global         _start        
_start:
    mov al, byte [number] ; Load the 8-bit number to check
    mov bl, 2             ; Start divisor at 2
    mov byte [answer], 1  ; Assume the number is prime initially

check_loop:
    cmp al, bl            ; Compare divisor with the number
    jle print_prime     ; If divisor >= number, number is prime
    xor ah, ah            ; Clear ah for division
    mov al, byte [number] ; Move the number into the lower byte of ax (al)
    div bl                ; Divide ax by bl and store quotient in al and remainder in ah
    cmp ah, 0             ; Check if remainder is 0
    je print_not_prime       ; If remainder is 0, number is not prime
    inc bl                ; Increment divisor
    jmp check_loop        ; Repeat the loop

; print statements

; set_notPrime:
;     mov byte [answer], 0  ; Set answer to 0 (not prime)
;     jmp check_loop        ; Return to the loop

; checkAndPrint:
;     cmp byte [answer], 0   ; Check if answer is 0 (not prime)
;     je print_not_prime     ; If not prime, print not prime message
;     jmp print_prime        ; Else, print prime message

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

    number db 97 ; input value
    answer db 1 ; 1 means number is prime,
    ; 0 means number is not prime   

    prime_msg db "Number is prime", 0x0a
    prime_msg_len equ $ - prime_msg


    not_prime_msg db "Number is NOT prime", 0x0a
    not_prime_msg_len equ $ - not_prime_msg