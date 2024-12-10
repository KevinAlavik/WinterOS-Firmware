; *****************************************************
; WinterOS Official Firmware
; Forked version of the official firmware for WinterOS
; *****************************************************

%define VIDEO_DEVICE_LOCATION 0xD0000000

/* Video_Init
 * Initializes the video device
 * Input: None
 * Output: r0 is 0 for success, 1 for failure
 */
Video_Init:
    ; Check for device 1 in the IO Bus (Video).
    mov r0, 1
    call IOBus_FindDevice
    cmp r0, -1
    jz .error

    ; Just finish once we find the device (for now).
    jnz .finish

.finish:
    ; Display warning on console device.
    mov r0, video_warning_msg
    call Console_Print

    ; Return successful result.
    mov r0, 0
    ret
.error:
    mov r0, 1
    ret

video_warning_msg:
    asciiz "WARNING: The video device isnt properly handled in the firmware, so it wont work\n"