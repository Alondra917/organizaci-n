section .data
    msg db "Número: ", 0      ; Mensaje a imprimir antes del número
    len equ $ - msg           ; Longitud del mensaje
    newline db 0x0A           ; Carácter de nueva línea

section .bss
    count resb 1              ; Reservamos espacio para la variable count
    num_str resb 2            ; Reservamos espacio para los dígitos del número

section .text
    global _start

_start:
    ; Inicializar count con 10
    mov byte [count], 10

bucles:
    ; Leer el valor de count
    mov al, [count]          ; Cargar el valor de count en AL

    ; Comprobar si count < 1
    cmp al, 1
    jl  fin                  ; Si count < 1, salir del bucle

    ; Imprimir mensaje "Número: "
    mov eax, 4               ; syscall para sys_write
    mov ebx, 1               ; fd = 1 (salida estándar)
    mov ecx, msg             ; mensaje a imprimir
    mov edx, len             ; longitud del mensaje
    int 0x80                 ; llamada al sistema

    ; Convertir el número a una cadena
    movzx ebx, byte [count]  ; Cargar el valor de count en ebx

    ; Comprobamos si el número es menor que 10 (un solo dígito)
    cmp ebx, 10
    jl  print_single_digit   ; Si es menor que 10, imprimimos solo un dígito

    ; Si el número es 10 o mayor, lo dividimos en decenas y unidades
    mov edx, 0               ; Limpiar edx
    mov ecx, 10              ; Dividir entre 10 (para obtener las decenas)
    div ecx                  ; Dividir ebx entre 10. El cociente está en al, el residuo en ah

    ; Convertir el primer dígito (decena)
    add al, '0'              ; Convertir el cociente (decena) a ASCII
    mov [num_str], al        ; Almacenar el primer dígito en num_str

    ; Convertir el segundo dígito (unidad)
    mov al, ah               ; Copiar el residuo a al (la unidad)
    add al, '0'              ; Convertir a ASCII
    mov [num_str + 1], al    ; Almacenar el segundo dígito en num_str + 1

    ; Imprimir los dos dígitos (decenas y unidades)
    mov eax, 4               ; syscall para sys_write
    mov ebx, 1               ; fd = 1 (salida estándar)
    mov ecx, num_str         ; Dirección de la cadena num_str
    mov edx, 2               ; Longitud de la cadena (2 dígitos)
    int 0x80                 ; Llamada al sistema
    jmp print_newline        ; Ir a imprimir el salto de línea

print_single_digit:
    ; Si el número es menor que 10 (un solo dígito), convertirlo y mostrarlo
    add bl, '0'              ; Convertir el número a ASCII
    mov [num_str], bl        ; Almacenar el único dígito en num_str

    ; Imprimir el único dígito
    mov eax, 4               ; syscall para sys_write
    mov ebx, 1               ; fd = 1 (salida estándar)
    mov ecx, num_str         ; Dirección de la cadena num_str
    mov edx, 1               ; Longitud de la cadena (1 dígito)
    int 0x80                 ; Llamada al sistema

print_newline:
    ; Imprimir salto de línea (0x0A)
    mov eax, 4               ; syscall para sys_write
    mov ebx, 1               ; fd = 1 (salida estándar)
    mov ecx, newline         ; Dirección del salto de línea
    mov edx, 1               ; Longitud del salto de línea (1 byte)
    int 0x80                 ; Llamada al sistema

decrement_and_loop:
    ; Decrementar count
    dec byte [count]         ; Decrementar count

    ; Repetir el bucle
    jmp bucles

fin:
    ; Salir del programa
    mov eax, 1               ; syscall para sys_exit
    xor ebx, ebx             ; código de salida 0
    int 0x80                 ; llamada al sistema

