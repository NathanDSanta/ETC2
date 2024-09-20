#Practica 5 - Darius Natan Santa

.data
    #incialitzem les dades necessàries
    eos: .ascii "X"

    frase1: .asciiz "Entra com a màxim de 10 frases de màxim 78 caràcters cadascuna.\nAcaba cada frase amb un RETURN i si vols plegar entra la frase 'XX' \n\n"
    frase2: .asciiz "El número de linies és: "
    frase3: .asciiz "El número de paraules és: "
    frase4: .asciiz "El número de caràcters és: "

.text

    main:

        #mostrar frase incial
        li $v0, 4
        la $a0, frase1
        syscall

        lb $s0, eos                 #carregar la lletra 'X' de memòria (per no haver de buscar el codi ascii)
        li $s1, 0                   #inicialitzar comptador de línies a 0
        li $t5, 10                  #constant màxim línies
        li $s2, 0                   #inicialitzar comptador de paraules a 0
        li $s3, 0                   #inicialitzar comptador de carácters a 0
        li $t2, 0                   #inicialitzar comptador de 'X' a 0
        li $t3, 2                   #constant màxim 'X' consecutives
        li $t0, 0                   #incialitzar comptador de carácters en línia actual
        li $t4, 79                  #constant màxim carácters en línia actual (el final de línia s'introdueix automàticament)
        li $t6, 0x0a                #constant salt de línia '\n'
        li $t7, 0x20                #constant espai ' '   


    loop:

        jal llegir_caracter         #subrutina llegeix carácter de teclat i el guarda en $t1
        jal augmentar_comptadors    #subrutina comprova quin tipus de carácter és $t1 i actualitza els comptadors $s1, $s2 i $s3

        jal max_linia               #subrutina que comprova els carácters d'aquesta línia i la salta automàticament si s'ha arribat al máxim
        beq $s1, $t5, final         #es salta al final si s'ha arribat al màxim de línies
        beq $t2, $t3, final         #es salta al final si 2 'X' consecutives han sigut introduides
        bne $s4, $s0, not_x         #es salta a not_x si el carácter introduit no és una 'X'
        addi $t2, $t2, 1            #s'incrementa el comptador de caràcters 'X'
        j loop                      #es torna al loop

    not_x:
        li $t2, 0                   #es reincia el comptador de caràcters 'X'
        j loop                      #es torna al loop

    final:

        #imprimeix "El número de linies és: "
        li $v0, 4
        la $a0, frase2
        syscall

        #imprimeix el número de linies ($s1)
        li $v0, 1
        move $a0, $s1
        syscall

        #imprimeix un salt de línia (per organitzar les frases)
        li $v0, 11
        move $a0, $t6
        syscall

        #imprimeix "El número de paraules és: "
        li $v0, 4
        la $a0, frase3
        syscall

        #imprimeix el número de paraules ($s2)
        li $v0, 1
        move $a0, $s2
        syscall

        #imprimeix un salt de línia (per organitzar les frases)
        li $v0, 11
        move $a0, $t6
        syscall

        #imprimeix "El número de caràcters és: "
        li $v0, 4
        la $a0, frase4
        syscall

        #imprimeix el número de caràcters ($s3)
        li $v0, 1
        move $a0, $s3
        syscall

        #imprimeix un salt de línia (per organitzar les frases)
        li $v0, 11
        move $a0, $t6
        syscall

        #imprimeix un salt de línia (per tenir espai per a la següent execució)
        li $v0, 11
        move $a0, $t6
        syscall

        #imprimeix un salt de línia (per tenir espai per a la següent execució)
        li $v0, 11
        move $a0, $t6
        syscall

        #tornem a l'inici
        j main


    #Subrutines

    llegir_caracter:
        #llegeix caràcter de teclat
        li $v0, 12
        syscall
        move $s4, $v0           #mou el caràcter al registre $s4
        jr $ra                  #sortim de la subrutina

    augmentar_comptadors:
        addi $s3, $s3, 1        #incrementem el comptador de caràcters global
        addi $t0, $t0, 1        #incrementem el comptador de caràcters de la línia
        beq $s4, $t7, espai     #si és un espai, saltem a 'espai'
        beq $s4, $t6, salt      #si és un salt de línia, saltem a 'salt'
        jr $ra                  #sortim de la subrutina
    espai:
        addi $s2, $s2, 1        #incrementem el comptador de paraules
        jr $ra                  #sortim de la subrutina
    salt:
        addi $s1, $s1, 1        #incrementem el comptador de salt de línia
        addi $s2, $s2, 1        #incrementem el comptador de paraules
        jr $ra                  #sortim de la subrutina

    max_linia:
        beq $t4, $t0, continua  #comprovem si el nombre de caràcters de la línia ha arribat al màxim
        jr $ra                  #en el cas que no, sortim de la subrutina instantàniament
    continua:
        #imprimim un salt de línia
        li $v0, 11
        move $a0, $t6
        syscall

        li $t0, 0               #reiniciem el comptador de paraules de la línia
        addi $s1, $s1, 1        #incrementem el comptador de línia (ja que ha sigut un salt automàtic)
        jr $ra                  #sortim de la subrutina

.end