; *****************************************************
; WinterOS Official Firmware
; Forked version of the official firmware for WinterOS
; *****************************************************

; Make sure that we are in the start of the BIOS region.
org 0xF0000000

entry:
    ; Set up the stack
    mov sbp, stack
    mov scp, stack
    mov stp, stack_end
    
    ; Load the IDT
    call load_idt
    
    ; Enter protected mode by setting CR0 register
    mov cr0, 1
    jmp main                    ; Jump to main boot process

main:
    ; Initialize the console device
    call Console_Init
    cmp r0, 0
    jnz .error                  ; Jump to error handling if initialization fails

    ; Initialize the storage device
    call Storage_Init
    cmp r0, 0
    jnz .storage_init_error     ; Jump to storage initialization error if fails

    ; Read the first 16 sectors from the storage device to memory at 0x10000
    mov r0, 0                   ; Sector 0
    mov r1, 16                  ; Read 16 sectors
    mov r2, 0x10000             ; Memory address to store data
    call Storage_Read
    cmp r0, 0
    jnz .storage_read_error     ; Jump to storage read error if fails

    ; Jump to the bootloader code located at 0x10000
    mov r0, protocol_table     ; Provide pointer to the protocol information table to the bootloader.
    jmp 0x10000

.storage_init_error:
    ; Error handling for storage initialization failure
    mov r0, storage_init_error_msg
    jmp .print_error

.storage_read_error:
    ; Error handling for storage read failure
    mov r0, storage_read_error_msg
    jmp .print_error

.print_error:
    ; Print error message using the console
    call Console_Print

.error: 
    ; If no console device is available, halt the system
    hlt

; Error messages for storage initialization and read errors
storage_init_error_msg:
    asciiz "Failed to initialise storage device\n"

storage_read_error_msg:
    asciiz "Failed to read from storage device\n"

; Include external assembly files for initialization
%include "console.asm"
%include "idt.asm"
%include "IO.asm"
%include "stack.asm"
%include "storage.asm"
%include "protocol.asm"