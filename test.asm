org 0x7C00
bits 16

%define endl 0x0D, 0x0A

entry: 
    my_string: db 'hello worldhehehe', endl, 0
    my_array: db '10 20 30 40 50',endl,endl,endl,0
    math: db 49,0
    mov si, my_string

    mov ax, 0
    
    mov sp, 0x7E00 
    jmp main

preserve_edited_registers:
    push ax
    push si

print_characters:
    lodsb
    cmp al,0
    je print_arrayvalues_entry

    mov ah, 0x0e
    int 0x10

    call print_characters

main:
    call preserve_edited_registers


print_arrayvalues_entry:
    mov si, my_array
    pop ax
    mov dx, 0


print_arrayvalues:
    lodsb         ; if end of array jump out

    cmp al,0
    je reassign_register_values

    mov ah, 0x0e        ; moving into ah register interuppt version tty.
    int 0x10 
       
    jmp print_arrayvalues


reassign_register_values:
    mov si, math
    mov dl, 0


maths_print:
    lodsw
    or al, 0
    jz halt

    add al, al
    mov ah, 0x0e
    int 0x10 
    jmp maths_print    


addition:
    mov si, math
    lodsb   
    ;je halt

    mov ah,0x0e
    int 0x10
    inc dl
    ;jmp addition

halt:
    jmp halt


times 510-($-$$) db 0
dw 0xAA55