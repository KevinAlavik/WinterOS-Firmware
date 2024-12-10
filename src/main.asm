org 0xF0000000

entry:
    mov sbp, stack
    mov scp, stack
    mov stp, stack_end
    call load_idt
    mov cr0, 1 ; enter protected mode
    jmp main

main:
    ; initialise the console device
    call Console_Init
    cmp r0, 0
    jnz .error

    mov r0, message
    call Console_Print

    ; initialise the storage device
    call Storage_Init
    cmp r0, 0
    jnz .storage_init_error

    ; read first 16 sectors to 0x1'0000
    mov r0, 0
    mov r1, 16
    mov r2, 0x10000
    call Storage_Read
    cmp r0, 0
    jnz .storage_read_error

    ; jump to the bootloader which should be at 0x1'0000
    mov r0, Console_Print
    jmp 0x10000

.storage_init_error:
    mov r0, storage_init_error_msg
    jmp .print_error

.storage_read_error:
    mov r0, storage_read_error_msg
    jmp .print_error

.print_error:
    call Console_Print

.error: ; if there is no console device, then we can't print anything
    hlt

message:
    asciiz "WinterOS firmware loaded.\n"

storage_init_error_msg:
    asciiz "Failed to initialise storage device\n"

storage_read_error_msg:
    asciiz "Failed to read from storage device\n"

%include "console.asm"
%include "idt.asm"
%include "IO.asm"
%include "stack.asm"
%include "storage.asm"