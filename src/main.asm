org 0xF0000000

%define CONSOLE_DEVICE_LOCATION 0xE0000000

entry:
    mov sbp, stack
    mov scp, stack
    mov stp, stack_end
    call load_idt
    mov cr0, 1 ; enter protected mode
    jmp main

main:
    ; find the console device
    call Console_Init
    cmp r0, 0
    jnz .error

    mov r0, message
    call Console_Print
    hlt

.error: ; if there is no console device, then we can't print anything
    hlt

message:
    asciiz "Hello from the official Frost64 firmware!\n"

%include "console.asm"
%include "IO.asm"
%include "idt.asm"
%include "stack.asm"