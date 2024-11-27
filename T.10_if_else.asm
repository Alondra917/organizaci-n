section .data
    num db 5                     ; Número a comprobar (puedes cambiarlo a cualquier otro)
    result_even db 'Even', 0     ; Mensaje para número par
    result_odd db 'Odd', 0       ; Mensaje para número impar
    msg db 0                      ; Espacio para almacenar el mensaje resultante

section .text
    global _start

_start:
    ; Cargar el valor de num
    mov al, [num]                ; Cargar el número en AL

    ; Comprobar si es par o impar
    test al, 1                    ; Verificar el bit menos significativo
    jz is_even                    ; Si es 0 (par), saltar a is_even

is_odd:
    ; Almacenar el mensaje de número impar
    mov edi, result_odd          ; Cargar la dirección del mensaje impar
    jmp store_result              ; Saltar a la sección de almacenamiento

is_even:
    ; Almacenar el mensaje de número par
    mov edi, result_even         ; Cargar la dirección del mensaje par

store_result:
    ; Copiar el mensaje a la variable msg
    mov esi, msg                 ; Cargar la dirección de msg
    mov ecx, 4                   ; Longitud del mensaje (4 caracteres para "Even" o "Odd")
    
copy_loop:
    mov al, [edi]                ; Cargar el carácter del mensaje
    mov [esi], al                ; Almacenar el carácter en msg
    inc esi                      ; Incrementar el puntero de msg
    inc edi                      ; Incrementar el puntero del mensaje
    loop copy_loop               ; Repetir hasta que se copien todos los caracteres

    ; Terminar el programa
    mov eax, 1                   ; syscall: exit
    xor ebx, ebx                 ; return 0
    int 0x80