; Programa de Resta en Ensamblador 
;Por: Alondra Judith Gonzalez Borbolla
; Objetivo: Realizar una resta básica de dos números enteros
; Justificación: Demostrar operaciones aritméticas básicas en lenguaje ensamblador

; Macros para simplificar operaciones de entrada/salida
%macro escribir 2
    mov eax, 4          ; Syscall para escribir
    mov ebx, 1          ; Descriptor de archivo (stdout)
    mov ecx, %1         ; Dirección del mensaje
    mov edx, %2         ; Longitud del mensaje
    int 0x80            ; Llamada al kernel
%endmacro

%macro leer 2
    mov eax, 3          ; Syscall para leer
    mov ebx, 0          ; Descriptor de archivo (stdin)
    mov ecx, %1         ; Dirección del búfer
    mov edx, %2         ; Longitud máxima
    int 0x80            ; Llamada al kernel
%endmacro

section .data
    ; Mensajes para interacción con el usuario
    msg_input1 db 'Ingrese el primer número: '
    len_input1 equ 26   ; Longitud manual y explícita
    
    msg_input2 db 'Ingrese el segundo número: '
    len_input2 equ 27   ; Longitud manual y explícita
    
    msg_result db 'El resultado de la resta es: '
    len_result equ 28   ; Longitud manual y explícita
    
    msg_newline db 10   ; Carácter de nueva línea
    
section .bss
    ; Búferes para entrada de números
    num1 resb 5         ; Búfer para el primer número
    num2 resb 5         ; Búfer para el segundo número
    resultado resb 10   ; Búfer para almacenar el resultado como cadena
    
section .text
    global _start

_start:
    ; Solicitar primer número
    escribir msg_input1, len_input1
    leer num1, 5
    
    ; Solicitar segundo número
    escribir msg_input2, len_input2
    leer num2, 5
    
    ; Convertir cadenas a números enteros
    ; Método simple de conversión ASCII a entero
    mov eax, 0          ; Limpiar EAX para el primer número
    mov ebx, 0          ; Limpiar EBX para el segundo número
    
    ; Convertir primer número
    mov esi, num1
    call ascii_to_int
    mov [num1], eax     ; Guardar primer número convertido
    
    ; Convertir segundo número
    mov esi, num2
    call ascii_to_int
    mov [num2], eax     ; Guardar segundo número convertido
    
    ; Realizar resta
    mov eax, [num1]
    sub eax, [num2]     ; Restar segundo número del primero
    mov [resultado], eax ; Guardar resultado
    
    ; Convertir resultado a cadena para mostrar
    mov esi, resultado
    call int_to_ascii
    
    ; Mostrar mensaje de resultado
    escribir msg_result, len_result
    escribir resultado, 10   ; Mostrar resultado
    escribir msg_newline, 1  ; Nueva línea
    
    ; Salir del programa
    mov eax, 1          ; Syscall de salida
    xor ebx, ebx        ; Código de salida 0
    int 0x80            ; Llamada al kernel

; Función para convertir cadena ASCII a entero
ascii_to_int:
    xor eax, eax        ; Limpiar EAX
.loop:
    movzx edx, byte [esi]  ; Obtener siguiente carácter
    cmp edx, 10        ; Verificar fin de línea
    je .done
    
    sub edx, '0'        ; Convertir carácter a valor numérico
    imul eax, 10        ; Multiplicar valor actual por 10
    add eax, edx        ; Sumar nuevo dígito
    
    inc esi             ; Avanzar al siguiente carácter
    jmp .loop
.done:
    ret

; Función para convertir entero a cadena ASCII
int_to_ascii:
    mov ecx, 10         ; Base para división
    mov edi, resultado + 9  ; Final del búfer
    mov byte [edi], 0   ; Marcar fin de cadena
    
.conversion:
    xor edx, edx        ; Limpiar EDX para división
    div ecx             ; Dividir EAX por 10
    add dl, '0'         ; Convertir residuo a carácter
    dec edi             ; Retroceder en el búfer
    mov [edi], dl       ; Guardar dígito
    
    test eax, eax       ; Verificar si quedan dígitos
    jnz .conversion
    
    mov [resultado], edi ; Actualizar puntero de resultado
    ret