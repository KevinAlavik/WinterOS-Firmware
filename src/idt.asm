load_idt:
    lidt idt
    ret

global_interrupt_handler:
    pusha

    mov r0, scp
.l:
    jmp .l

    popa
    sub scp, 0x18 ; remove error code and interrupt number
    iret

%include "idt_entries.asm"