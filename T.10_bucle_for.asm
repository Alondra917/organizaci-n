section .data
    product db 1        ; Variable para almacenar el producto, inicializada a 1

section .text
    global _start

_start:
    ; Inicializar la variable i a 1
    mov ecx, 1          ; ECX se utiliza como contador (i), inicializado a 1

for_loop:
    ; Comparar i (en ECX) con 5
    cmp ecx, 6          ; Comparamos con 6 para que el bucle se ejecute mientras i <= 5
    jge end_loop        ; Si i > 5, salir del bucle

    ; Multiplicar product por i
    mov al, [product]   ; Cargar el valor de product en AL
    mov bl, cl          ; Mover el valor de i (en ECX) a BL
    mul bl              ; Multiplicar AL (product) por BL (i)
    mov [product], al   ; Almacenar el resultado en product

    ; Incrementar i
    inc ecx             ; Incrementar el contador (i)
    jmp for_loop        ; Volver al inicio del bucle

end_loop:
    ; Terminar el programa
    mov eax, 1          ; syscall: exit
    xor ebx, ebx        ; return 0
    int 0x80