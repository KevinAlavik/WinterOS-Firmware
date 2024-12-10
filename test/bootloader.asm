org 0x10000

; r0 = Pointer to the protocol table.
main:
    ; Print a hello message
    mov r10, r0         ; Move the table to r10.
    mov r0, message     ; Set arg1 (r0) of the Print() function.
    call [r10]          ; Call the print handler from the table.
    hlt

message:
    asciiz "Hello from the bootloader!\n"