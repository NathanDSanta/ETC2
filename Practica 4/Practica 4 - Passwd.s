#Nom: Darius Natan, Santa


.data
    vocals: .ascii "aeiou"
    num_voc: .ascii "43101"
    cadena: .space 16

    frase1: .asciiz "Entra la cadena:"
    frase2: .asciiz "Password generat:"

.text

    main:
        #print("Entra la cadena:")
        li $v0, 4
        la $a0, frase1
        syscall

        li $t0, 0                   #comptador 0
        li $t3, 16                  #constant màxim caràcters contrasenya
        li $t6, 0x0a                #constant: \n

    llegir:
        #llegir 1 caracter
        li $v0, 12                  
        syscall
        move $t1, $v0               #guardar el caràcter llegit en $t1

        beq $t0, $t3, fi            #si el comptador és 16, saltar
        beq $t1, $t6, fi            #si el caràcter és un salt de línia, saltar
        li $t4, 0                   #comptador index 0
        li $t5, 5                   #constant max index
        jal index                   #subrutina index (busca l'index de la vocal a substituri)

        beq $s0, $t5, not_change    #si no ha trobat l'index (index = 5), salta a not_change

        lb $s1, num_voc($s0)        #llegir el caràcter a imprimir
        sb $s1, cadena($t0)         #escriure el caràcter a imprimir

        addi $t0, $t0, 1            #incrementar el comptador
        j llegir                    #tornar al bucle

    not_change:

        sb $t1, cadena($t0)         #imprimir el caràcter llegit

        addi $t0, $t0, 1            #incrementar el comptador
        j llegir                    #tornar al bucle

    fi: 
        sb $0, cadena($t0)          #afegir el 0 final per determinar el final del string
        
        #imprimir "Password generat:"
        li $v0, 4                   
        la $a0, frase2
        syscall

        #imprimir la cadena (lloc on està guardada la contrasenya generada)
        li $v0, 4
        la $a0, cadena
        syscall

        #tornar al principi del programa
        move $t1, $0
        j main



    #Troba l'index de la vocal coincident
    index:
        beq $t5, $t4, equal         #si el comptador és 5, salta a equal
        lb $t2, vocals($t4)         #llegir la vocal en la posició actual del comptador(separat del principal)
        beq $t1, $t2, equal         #si la vocal llegida és la mateixa que el carácter salta a equal
        
        addi $t4, $t4, 1            #incrementa comptador
        j index                     #torna al principi d'aquesta subrutina
    equal: 
        move $s0, $t4               #guarda l'index de vocal (el comptador)
        jr $ra                      #retorna al programa principal  
        

.end