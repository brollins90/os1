.section .init
.globl _start
_start:
    movw r4, 0x0
    movt r4, 0x3f20
    movw r5, 0x0
    movt r5, 0x20
    
    /* Enable GPIO */
    str r5, [r4, #16]
        
    movw r5, 0x8000

loop:
    /* Turn LED on */
    str r5, [r4, #32]
    
    movw r0, 0xffff
    /* push {r0} */
    bl wait1
    /* pop {r0} */
    
    /* Turn LED off */
    str r5, [r4, #44]
    
    movw r0, 0xffff
    /* push {r0} */
    bl wait1
    /* pop {r0} */
    
    bal loop

wait1:
    /* push {r0,lr} */
    /* ldr r0, [sp, #4] */

wait_loop:
    subs r0,#1
    bne wait_loop
    /* pop {r0,pc} */
    mov pc, lr

