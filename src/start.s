
.section ".text.startup"

.global _start
.global _get_stack_pointer

_start:
    ldr     sp, =0x9000
    b       _cstartup

_inf_loop:
    b       _inf_loop
