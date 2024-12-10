org 0x10000

main: ; r0 = pointer to print function

    mov r1, r0 ; move it to r1
    mov r0, message
    call r1

    hlt

message:
    asciiz "Hello from the bootloader!\n"