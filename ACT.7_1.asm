section .data
    num1 db 5      ; se define num1 con valor 5
    num2 db 11      ; se define num2 con valor 11
    result db 0     ; se inicializa la variable result con valor 0
    msg db 'Resultado: ', 0 ; se define Resultado con valor 0  

section .bss
    buffer resb 4 ; reserva de bytes 

section .text
    global _start 

_start:
    mov al, [num1] ; mover num1 al registro al
    add al, [num2] ; sumar num2 al registro al 
    mov [result], al    ; Convertir el resultado a ASCII
    movzx eax, byte [result] ; cargar valor de result en eax
    add eax, '0'         ; Convertir el valor numérico en su correspondiente ASCII ('0' = 48)
    mov [buffer], al    ; Almacenar el carácter ASCII en el buffer

    mov eax, 4 ; cargar el número de sistema de llamada para sys_write
    mov ebx, 1 ; descriptor de archivo
    mov ecx, msg ; dirección de la cadena de caarateres a imprimir
    mov edx, 11 ; longitud de la cadena de caracteres
    int 0x80 ; llamar al sistema


    mov eax, 4 ; llamada para escribir
    mov ebx, 1 ; descriptor de archivo
    mov ecx, buffer ; mover dirección de buffer a registro ecx
    mov edx, 1 ; longitud de la cadena de caracteres
    int 0x80 ; llamar al sistema

    mov eax, 1 ; salida de programa
    xor ebx, ebx ; establecer salida
    int 0x80 ; llamar al sistema
