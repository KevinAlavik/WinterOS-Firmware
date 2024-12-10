; *****************************************************
; WinterOS Official Firmware
; Forked version of the official firmware for WinterOS
; *****************************************************


; ============================================
; The WinterOS Firmware Protocol Table (WFPT).
; ============================================
WFPT:
    ; To calculate the address of a function in the WFPT simply do:
    ;  - address =  [WFTP_Base + (0x08 * idx)]

    ; -- BEGIN --
    dq Console_Print    ; ProtocolTable[0] -> Print()
    ; -- END --