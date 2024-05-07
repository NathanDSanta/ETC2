#Nom: Darius Natan, Santa


.data
    vector1: .ascii "aeiou"
    vector2: .ascii "eioua"
    cadena: .space 20

    text1: .asciiz "Enter entrat:"
    text2: .asciiz "Cadena entrada:"
    text3: .asciiz "Resultat:"

.text

    main:
        #imprimir: "Enter Entrat:"
        li	$v0, 4		
        la $a0, text1
        syscall 

        #Llegir enter
        li $v0, 5
        syscall
        addi $t1, $v0, -1           #guardar enter restantli un, ja que l'index comença per 0

        lb $s0, vector1($t1)        #guardar el caràcter a substituir en s0
        lb $s1, vector2($t1)        #guardar el caràcter substitut en s1

        #Imprimir "Cadena entrada:"
        li $v0, 4
        la $a0, text2
        syscall

        li $t0, 0                   #Comptador 0
        li $t3, 20                  #màxim cadena = 20
        li $t6, 0x0a                #constant = \n

    llegir:
        #llegir caràcter
        li $v0, 12                  
        syscall
        move $t2, $v0               #guardar caràcter llegit en $t2

        beq $t0, $t3, final         #si comptador = 20, salta al final
        beq $t2, $t6, final         #si caràcter = salt de línia, salta al final
        beq $t2, $s0, substituir    #si caràcter = caràcter desitjat, salta a susbtituir
        
        sb $t2, cadena($t0)         #afegir el caràcter llegit a la cadena
        addi $t0, $t0, 1            #incrementar comptador
        j llegir                    #tornar al bucle


    substituir:
        sb $s1, cadena($t0)         #afegir el substitut del llegit a la cadena
        addi $t0, $t0, 1            #incrementar comptador
        j llegir                    #tornar al bucle

    final:
        sb $0, cadena($t0)          #afegir el 0 del final del string
        
        #imprimir "Resultat:"
        li $v0, 4           
        la $a0, text3
        syscall

        #imprimir la cadena modificada
        li $v0, 4
        la $a0, cadena
        syscall

        #Retorna al principi del programa
        move $t2, $t0
        j main

.end