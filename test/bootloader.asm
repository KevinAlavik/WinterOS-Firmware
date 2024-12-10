;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; WinterOS Firmware Test    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org 0x10000

; Parameters passed from Firmware:
;  - r0 = Pointer to the WFPT
entry:
    ; Display hello message via the console
    mov r10, r0             ; Move the WFPT pointer to r10.
    mov r0, message         ; Set arg1 (r0) of the Print() function.
    call [r10]              ; Call the print handler from the table, WFPT[0](boot_msg) = [WFPT + (0x08 * 0)] -> Print(boot_msg)

    ; Initialize the display
    call [r10 + 0x08]       ; Call the video init from the table, WFTP[1]() = [WFTP + (0x08 * 1)] -> VideoInit()
    hlt

message:
    asciiz "Hello from the bootloader!\n"