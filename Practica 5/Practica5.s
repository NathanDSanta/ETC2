#Practica 5 - Darius Natan Santa

.data

    eos: .ascii "X"
    cadena: .space 800

    frase1: .asciiz "Entra com a màxim de 10 frases de màxim 78 caràcters cadascuna.\nAcaba cada frase amb un RETURN i si vols plegar entra la frase 'XX' \n\n"
    frase2: .asciiz "El número de linies és: "
    frase3: .asciiz "El número de paraules és: "
    frase4: .asciiz "El número de caràcters és: "

.text

    main:
        
        li $v0, 4
        la $a0, frase1
        syscall

        lb $s0, eos
        li $s1, 1
        li $s2, 0
        li $s3, 0
        li $t0, 0
        li $t2, 0
        li $t3, 2
        li $t5, 11
        li $t6, 0x0a
        li $t7, 0x20


    loop:

        li $v0, 12
        syscall
        move $v0, $t1
        beq $s1, $t5, final
        beq $t1, $s0, x
    
    afegir:

        addi $s3, $s3, 1
        bne $t1, $t7, loop
        addi $s2, $s2, 1
        bne $t1, $t6, loop
        addi $s1, $s1, 1
        j loop


    x:
        li $v0, 12
        syscall
        move $v0, $t1
        bne $t1, $s0, afegir
        


    final:




.end