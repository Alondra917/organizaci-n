section .data 
    num1 db 5                     ; Definición del primer número (5) en la sección de datos 
    num2 db 11                    ; Definición del segundo número (11) en la sección de datos 
    result db 0                   ; Espacio para almacenar el resultado de la suma
    message db "Resultado: ", 0   ; Mensaje de texto que se imprimirá antes del número, terminado en 0 (carácter nulo)

section .bss
    buffer resb 4                  ; Reserva de 4 bytes de memoria en la sección BSS para almacenar el número como cadena

section .text
    global _start                  ; Declaración de la etiqueta _start como el punto de entrada del programa

%macro PRINT_STRING 1
    ; Macro para imprimir una cadena de texto
    mov eax, 4                    ; Llamada al sistema para escritura (sys_write)
    mov ebx, 1                    ; Descriptor de archivo 1 (salida estándar)
    mov ecx, %1                   ; Dirección de la cadena de texto a imprimir
    mov edx, 13                   ; Longitud de la cadena (en este caso, 13 caracteres)
    int 0x80                      ;Interrupción del sistema para ejecutar la llamada
%endmacro                         ; Cerrando el macro 

%macro PRINT_NUMBER 1
; Macro para imprimir un número de un solo dígito
    mov eax, %1                   ; Cargar el número en el registro EAX
    add eax, '0'                  ; Convertir el número a su equivalente ASCII sumando '0'
    mov [buffer], eax             ; Almacenar el carácter convertido en el buffer
    mov eax, 4                    ; Llamada al sistema para escritura (sys_write)
    mov ebx, 1                    ; Descriptor de archivo 1 (salida estándar)
    mov ecx, buffer               ; Dirección del buffer que contiene el carácter
    mov edx, 1                    ; Longitud de 1 byte (un solo carácter)
    int 0x80                      ; Interrupción del sistema para ejecutar la llamada
%endmacro

_start:
    ; Comienzo del programa
    mov al, [num1]                ; Cargar el primer número en AL
    add al, [num2]                ; Sumar el segundo número a AL
    mov [result], al              ; Guardar el resultado en la variable result

    PRINT_STRING message          ; Imprimir el mensaje "Resultado: "
    PRINT_NUMBER [result]         ; Imprimir el número resultante

    ; Salir del programa
    mov eax, 1                    ; Llamada al sistema para salir (sys_exit)
    mov ebx, 0                    ; Código de salida 0 (sin error)
    int 0x80                      ; Interrupción del sistema para ejecutar la salida
    
    
    