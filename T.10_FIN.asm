section .data
    num1 db 3                     ; Primer número (0)
    num2 db 9                     ; Segundo número (0)
    result db 0                   ; Variable para almacenar el resultado de la suma
    msg db "Resultado: ", 0       ; Mensaje inicial
    resultStr db "00", 10         ; Cadena para el resultado en ASCII y salto de línea
    zeroMsg db "Esto es un cero", 10  ; Mensaje "Esto es un cero" con salto de línea

section .text
    global _start

_start:
    ; Realizar la suma
    mov al, [num1] ; Cargar el valor de num1 en AL
    add al, [num2] ; Sumar el valor de num2 a AL
    mov [result], al ; Guardar el resultado en 'result'
    
    ; Salto para verificar si el resultado es mayor a 0
    cmp byte [result], 0
    jz end_program ; Si el resultado es 0, salta al final del programa
    ; Si el resultado es mayor que 0, convertir a ASCII y mostrarlo
    movzx eax, byte [result] ; Cargar el valor de result en el registro EAX
    add eax, '0'; Convertir a carácter ASCII
    mov [resultStr], al ; Guardar el carácter en resultStr para imprimir

    ; Imprimir mensaje de texto
    mov eax, 4                    ; Syscall para escribir
    mov ebx, 1                    ; Salida estándar (stdout)
    mov ecx, msg                  ; Dirección del mensaje
    mov edx, 11                   ; Longitud del mensaje
    int 0x80                      ; Llamada al sistema

    ; Imprimir el resultado de la suma
    mov eax, 4                    ; Syscall para escribir
    mov ebx, 1                    ; Salida estándar (stdout)
    mov ecx, resultStr            ; Dirección de la cadena del resultado
    mov edx, 1                    ; Longitud de la cadena (2 dígitos y nueva línea)
    int 0x80                      ; Llamada al sistema

end_program:
    ; Verificar si el resultado es cero y mostrar el mensaje correspondiente
    cmp byte [result], 0
    jnz exit_program ; Si el resultado no es 0, saltar a la salida
    
    ; Imprimir "Esto es un cero"
    mov eax, 4 ; Syscall para escribir
    mov ebx, 1 ; Salida estándar (stdout)
    mov ecx, zeroMsg ; Dirección del mensaje 'Esto es un cero'
    mov edx, 15 ; Longitud del mensaje (14 caracteres + salto de línea)

    int 0x80 ; Llamada al sistema
    exit_program:
    
    ; Terminar el programa
    mov eax, 1                    ; Syscall para salir
    xor ebx, ebx                  ; Código de salida 0
    int 0x80

