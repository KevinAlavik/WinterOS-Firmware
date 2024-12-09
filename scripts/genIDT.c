#include <stdio.h>

int main() {
    for (int i = 0; i < 256; i++) {
        printf("idt_handler_%d:\n", i);
        if (i != 1 && i != 2 && i != 4 && i != 7)
            printf("    push 0\n"); // dummy error code
        if (i != 7)
            printf("    push 0\n"); // second dummy error code
        printf("    push %d\n", i);
        printf("    jmp global_interrupt_handler\n");
    }
    printf("\nidt:\n");
    for (int i = 0; i < 256; i++) {
        printf(".entry%d:\n", i);
        printf("    db 1\n");
        printf("    dq idt_handler_%d\n", i);
    }
    return 0;
}