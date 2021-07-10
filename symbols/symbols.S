.intel_syntax noprefix

.data

.global base_offset
.hidden base_offset
base_offset: .quad 0

.text

.global set_base_offset
.type set_base_offset, @function
set_base_offset:
    mov [rip + base_offset], rdi
    ret

.macro decl_symbol symbol_name offset
.global \symbol_name
.type \symbol_name, @function
\symbol_name:
    mov rax, [rip + base_offset]
    add rax, \offset
    jmp rax
.endm

#include MODLOADER_SYMBOLS_TABLE