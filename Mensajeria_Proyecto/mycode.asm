;Proyecto de Arquitectura
;Grupo 1
;Integrantes: Samantha Acuna, Katherine Amador, Raquel Arguedas
;Objetivo: Disena mensajeria para codigo morse

.model large   
.stack 
.data  
    n1 dw 32,32,32,32,32,32,32,32,32,32,32,32,15,15,15,32,15,32,15,32,15,15,15,32,'$' 
    n2 dw 32,32,32,32,32,32,32,32,32,32,32,32,15,32,32,32,15,32,15,32,15,32,15,32,'$' 
    n3 dw 32,32,32,32,32,32,32,32,32,32,32,32,15,15,15,32,15,15,32,32,15,15,32,32,'$' 
    n4 dw 32,32,32,32,32,32,32,32,32,32,32,32,32,32,15,32,15,32,15,32,15,32,15,32,'$'
    n5 dw 32,32,32,32,32,32,32,32,32,32,32,32,32,32,15,32,15,32,32,32,15,32,15,32,'$' 
    n6 dw 32,32,32,32,32,32,32,32,32,32,32,32,15,15,15,14,15,32,15,14,15,32,15,32,'$'   
    nombre dw 32,32,32,32,32,32,32,32,32,32,32,32,32,'Mensajeria morse',32,32,32,32,32,32,32,32,32,'$'
    integrantes db 32,32,32,32,32,32,32,32,32,"Realizado por: Samantha Acu",164,"a, Katherine Amador y Raquel Arguedas",'$'
    msjEnters dw 32,32,32,32,32,32,32,32,32,'Presione enter para escribir un mensaje ',10,13,'$'
    saltos db 10, 13, '$'  
    texnumero db 'Ingrese el n',163,'mero de tel',130,'fono a quien le enviara el mensaje',10,13, '$'
    texmensaje db ' Ingresa el mensaje que desea enviar',10,13, '$'
    msjTraducido db 'El mensaje traducido es:',10,13, '$'  
    msjEspera db 'Esperando a que el mensaje se envie...',10,13, '$' 
    msj db "Favor ingrese un secuencia de clicks para traducir de codigo morse a letras.",10,13,"$" 
    msj1 db "Click derecho marca un punto, click izquierdo marca una raya.",10,13,"$" 
    msj2 db "Cuando quiera cambiar de letra apriete click del centro, seguido de la tecla espacio.",10,13,"$" 
    msj3 db "Cuando haya acabado con su palabra apriete click del centro, seguido de la tecla enter.",10,13,"$"  
    punto db ".","$"
    raya db "-","$"
    espacio db " ","$" 
    a db "a","$"  
    b db "b","$"
    c db "c","$"
    d db "d","$"
    e db "e","$"
    f db "f","$"
    g db "g","$"
    h db "h","$"
    i db "i","$"
    j db "j","$"
    k db "k","$"
    l db "l","$"
    m db "m","$"
    n db "n","$"
    o db "o","$"
    p db "p","$"
    q db "q","$"
    r db "r","$"
    s db "s","$"
    t db "t","$"
    u db "u","$"
    v db "v","$"
    w db "w","$"
    x db "x","$"
    y db "y","$"
    z db "z","$"
    noChar db "?","$"
    string1 db 256 dup (?),"$" 
    archivonumero db 'numero.txt',0    
    archivomensaje db 'mensaje.txt',0 
    traducido db 256 dup (?),"$" 
    numero db 08 dup (?)
    maneja dw ? 
    
     
                                                               
.code 
 
;INICIALIZAR DATOS
mov ax, @data
mov ds, ax  
     
     
;MACROS
imprimirMensaje macro mensaje ;Macro para imprimir mensajes
lea DX, mensaje    
mov AH, 09
int 21h
endm 

agregarSalto macro ;Macro saltos de linea
lea DX, saltos
mov AH, 09
int 21h
endm 

limpiarRegistros macro ;Macro limpiar registro y que no aparezca basura en pantalla               
MOV AX,0600H 
MOV BH,07H 
MOV CX,0000H 
MOV DX,184FH 
INT 10H   
endm
    
inicioPantalla macro ;Inicializar con mensaje en pantalla
    agregarSalto 
    agregarSalto 
    agregarSalto 
    imprimirMensaje n1  
    agregarSalto 
    imprimirMensaje n2
    agregarSalto
    imprimirMensaje n3
    agregarSalto
    imprimirMensaje n4
    agregarSalto 
    imprimirMensaje n5
    agregarSalto  
    imprimirMensaje n6 
    agregarSalto 
    agregarSalto 
    imprimirMensaje nombre 
    agregarSalto
    agregarSalto
    imprimirMensaje integrantes
    agregarSalto  
    agregarSalto
    imprimirMensaje msjEnters 
     
endm   
    
addToString macro char
   mov al, char
   mov string1[di],al
   inc di
endm  

addToTraducido macro char
   mov al, char
   mov traducido[si],al
   inc si
endm
    
  
;CODIGO PARA INICIO DEL PROGRAMA PANTALLA PRINCIPAL
PantallaPrincipal:
     mov ah,06h
     mov bH,00111111B
     mov cx,0000h
     mov dx,184fh
     int 10h  
     
     
           
    inicioPantalla  
    
    enter:
    mov ah,08     
    int 21h
    cmp al,0Dh
    je PantallaSecundaria 
    jne enter 

;CODIGO PARA INICIO DE MENSAJERIA PANTALLA SECUNDARIA 
PantallaSecundaria:   
 limpiarRegistros
 imprimirMensaje texnumero
 leernumero:
     mov ah,01       ;pedir un dato           
     int 21h
     cmp al,13
     je agregararchivonumero
     mov numero[di],al
     inc di  
     loop leernumero
     
  agregararchivonumero: 
     mov cx, 0       
     lea dx, archivonumero
     mov ah, 3ch
     int 21h 
  
     jc salir 
    
     mov maneja, ax
    
     mov bx, maneja  
     mov cx, offset maneja - offset numero
     lea dx, numero
     mov ah, 40h
     int 21h 
    
     jc salir
    
     mov bx, maneja
     mov ah, 3eh
     int 21h 
     
 limpiarRegistros
 imprimirMensaje texmensaje 
 imprimirMensaje msj      ; imprime las instrucciones de uso
    imprimirMensaje msj1 
    imprimirMensaje msj2 
    imprimirMensaje msj3 
    
    mov cx,64999
    mov di,0 
    mov si,0
               
               
    
    consultar:
        mov ax, 03h
        int 33h
        
        cmp bx, 0
        je consultar
             
        cmp bx, 2  
        je der
        cmp bx, 1
        je izq
        cmp bx, 4
        je centro
        
        der:
            imprimirMensaje punto
            addToString punto 
            jmp consultar         
            
        izq:
            imprimirMensaje raya
            addToString raya 
            jmp consultar  
             
                   
        centro:
            addToString espacio   
            jmp terminar
    
    
    
    terminar: 
    
          mov ah,01       ;poregunta si quiere continuar agregando letras          
          int 21h
          cmp al,13
          je traducir
             
          jmp consultar     
          
    traducir: 
          addToString 13
          mov di,0 
          
          
          
    traducirLoop:             
   
          cmp string1[di], '.'   ;.
          jne empiezaConRaya
          inc di  
          
          cmp string1[di], ' '
          jne contPP:
          addToTraducido e
          jmp sig
          
          
      contPP:
          cmp string1[di], '.'   ;..
          jne contPR
          inc di  
          
          cmp string1[di], ' '
          jne contPPP:
          addToTraducido i
          jmp sig    
          
      contPR:
          cmp string1[di], '-'   ;.-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contPRP:
          addToTraducido a
          jmp sig 
          
          
      
      contPPP:
          cmp string1[di], '.'   ;...
          jne contPPR
          inc di  
          
          cmp string1[di], ' '
          jne contPPPP:
          addToTraducido s
          jmp sig
          
      contPPR:
          cmp string1[di], '-'   ;..-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contPPRP:
          addToTraducido u
          jmp sig
          
          
       contPRP:
          cmp string1[di], '.'   ;.-.
          jne contPRR
          inc di  
          
          cmp string1[di], ' '
          jne contPRPP:
          addToTraducido r
          jmp sig
          
      contPRR:
          cmp string1[di], '-'   ;.--
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contPRRP:
          addToTraducido w
          jmp sig
      
      
      
      contPPPP:
          cmp string1[di], '.'   ;....
          jne contPPPR
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido h
          jmp sig
          
      contPPPR:
          cmp string1[di], '-'   ;...-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido v
          jmp sig
          
      contPPRP:
          cmp string1[di], '.'   ;..-.
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido f
          jmp sig
      
      contPRPP:
          cmp string1[di], '.'   ;.-..
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido l
          jmp sig
          
      contPRRP:
          cmp string1[di], '.'   ;.--.
          jne contPRRR
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido p
          jmp sig
      
      contPRRR:
          cmp string1[di], '-'   ;.---
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido j
          jmp sig
                
    empiezaConRaya:  
          cmp string1[di], '-'   ;-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contRP:
          addToTraducido t
          jmp sig
          
          
      contRP:
          cmp string1[di], '.'   ;-.
          jne contRR
          inc di  
          
          cmp string1[di], ' '
          jne contRPP:
          addToTraducido n
          jmp sig    
          
      contRR:
          cmp string1[di], '-'   ;--
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contRRP:
          addToTraducido m
          jmp sig
     
     
     
     
      contRPP:
          cmp string1[di], '.'   ;-..
          jne contRPR
          inc di  
          
          cmp string1[di], ' '
          jne contRPPP:
          addToTraducido d
          jmp sig
          
      contRPR:
          cmp string1[di], '-'   ;-.-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne contRPRP:
          addToTraducido k
          jmp sig
          
          
      contRRP:
          cmp string1[di], '.'   ;--.
          jne contRRR
          inc di  
          
          cmp string1[di], ' '
          jne contRRPP:
          addToTraducido g
          jmp sig
          
      contRRR:
          cmp string1[di], '-'   ;---
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido o
          jmp sig   
          
          
      
      contRPPP:
          cmp string1[di], '.'   ;-...
          jne contRPPR
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido b
          jmp sig
      
      contRPPR:
          cmp string1[di], '-'   ;-..-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido x
          jmp sig
      
      contRPRP:
          cmp string1[di], '.'   ;-.-.
          jne contRPRR
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido c
          jmp sig
      
      contRPRR:
          cmp string1[di], '-'   ;-.--
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido y
          jmp sig
      
      contRRPP:
          cmp string1[di], '.'   ;--..
          jne contRRPR
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido z
          jmp sig
      
      contRRPR:
          cmp string1[di], '-'   ;--.-
          jne noImplementado
          inc di  
          
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido q
          jmp sig       
              
               
      noImplementado:
          inc di
          cmp string1[di], ' '
          jne noImplementado:
          addToTraducido noChar
          jmp sig      
        
          
       sig:
          inc di
          cmp string1[di],13
          jne traducirLoop
          
      imprimirstring:
      agregarSalto 
      imprimirMensaje msjTraducido
      imprimirMensaje traducido
      
    
  agregararchivomensaje:
     mov cx, 0       
     lea dx, archivomensaje
     mov ah, 3ch
     int 21h 
  
     jc salir 
    
     mov maneja, ax
    
     mov bx, maneja  
     mov cx, offset maneja - offset traducido
     lea dx, traducido
     mov ah, 40h
     int 21h 
    
     jc salir
    
     mov bx, maneja
     mov ah, 3eh
     int 21h
          
     limpiarRegistros
     imprimirMensaje msjEspera
  
salir: 
    endm


