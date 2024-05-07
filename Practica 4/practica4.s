.data
		
		vector1 : .ascii "aeiou"
		vector2 : .ascii "eioua"
		cadena  : .space 20
		
		frase1 : .asciiz "Enter entrat(1-5):"
		frase2 : .asciiz "Cadena entrada"
		frase3 : .asciiz "Resultat:"
.text
	main:
		li $v0, 4 
		la $a0, frase1 
		syscall
		
		li $v0, 5 
		syscall
		addi $t1, $v0, -1
		
		lb $s0, vector1($t1)
		lb $s1, vector2($t1)
		
		li $v0, 4
		la $a0, frase2
		syscall
		
		li $t0, 0
		li $t3, 20
		li $t6, 0x0a # 0x0a = \n
	
	llegir:
		li $v0,12
		syscall
		
		move $t2, $v0
		beq $t0, $t3, fi
		beq $t2, $t6, fi
		beq $t2, $s0, canvi
		sb $t2, cadena($t0)
		addi $t0, $t0, 1
		j llegir
		
	canvi: 
		sb $s1, cadena($t0)
		addi $t0, $t0, 1
		j llegir
		
	fi:
		sb $0, cadena($t0)
		li $v0, 4
		la $a0, frase3
		syscall
		
		li $v0, 4
		la $a0, cadena
		syscall
		move $t2, $0
		j main
		
.end