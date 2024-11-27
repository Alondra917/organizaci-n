section .data       ; seccion que se utiliza para difinir datos con valores iniciales asignados 
    sum db 0          ; Variable para almacenar la suma
    count db 1        ; Variable para contar desde 1 hasta 10

section .text
    global _start

_start:
    ; Inicializar sum a 0 y count a 1 (ya está hecho en la sección .data)

while_start:
    ; Comprobar si count <= 10
    mov al, [count]   ; Cargar el valor de count en AL
    cmp al, 10        ; Comparar count con 10
    jg while_end      ; Si count > 10, salir del bucle

    ; Sumar count a sum
    mov bl, [sum]     ; Cargar el valor de sum en BL     (se usea bl para evitar usar registros mas grandes)
    add bl, al        ; Sumar count (en AL) a sum (en BL)
    mov [sum], bl     ; Almacenar el nuevo valor de sum

    ; Incrementar count
    inc byte [count]  ; Incrementar count

    ; Volver al inicio del bucle
    jmp while_start

while_end:
    ; Terminar el programa
    mov eax, 1        ; syscall: exit
    xor ebx, ebx      ; return 0
    int 0x80