section .data
    numbers db 5, 3, 8, -1, 2, 4, 6  ; Lista de números (termina con un número negativo)
    sum db 0                           ; Variable para almacenar la suma
    count db 0                         ; Variable para contar los números leídos

section .text
    global _start

_start:
    ; Inicializar puntero a la lista de números
    mov esi, numbers                   ; ESI apunta al inicio de la lista
    xor ecx, ecx                       ; Inicializar sum a 0 (en ECX)

do_while_loop:
    ; Leer el número actual
    mov al, [esi]                      ; Cargar el número actual en AL
    add ecx, eax                       ; Sumar el número a sum (en ECX)
    
    ; Comprobar si el número es negativo
    cmp al, 0                          ; Comparar el número con 0
    js end_loop                        ; Si es negativo, salir del bucle

    ; Mover el puntero al siguiente número
    inc esi                            ; Incrementar el puntero para apuntar al siguiente número
    jmp do_while_loop                  ; Volver al inicio del bucle

end_loop:
    ; Almacenar el resultado en sum
    mov [sum], cl                      ; Almacenar la suma en la variable sum (CL tiene el resultado)

    ; Terminar el programa
    mov eax, 1                         ; syscall: exit
    xor ebx, ebx                       ; return 0
    int 0x80