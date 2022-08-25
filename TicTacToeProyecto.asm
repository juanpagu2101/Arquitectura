.data
menu: .asciiz "¿Donde quiere colocar su ficha?: "
opciones: .asciiz "\n Ingrese numero entre 0-8: "
incorrecto: .asciiz "\nNo se puede utilizar ese espacio porque ya esta ocupado\n"
ganador1: .asciiz "\nGano el jugador\n"
ganador2: .asciiz "\nGano la CPU\n"
empate: .asciiz "\nExite empate\n"
vacio: .asciiz " "
pleca: .asciiz "|"
ficha1: .asciiz "X"
ficha2: .asciiz "O"
salto: .asciiz "\n"
tabXaO: .space 9 #numero de bytes para reservar

.text
li $v0, 42 #es el encargado de generar un numero random
li $a1, 2
syscall
move $t0, $a0 #mueve el numero que genero a $t0

li $t9, 0 #se inicaliza el $t9 en cero, ya que este va hacer el contador de cuantos espacios estan ocupados
decidet: 
	la $a0,salto #imprime un salto
	li $v0,4
	syscall

	li $t2,0 #contador
	printtab: #imprimir tablero 
		lb $t3, tabXaO($t2) #se carga $t3 lo que se encuentre en tabXaO
		beqz $t3, printv #si $t3 es igual a 0 salta a printv
		bnez $t3, printp #si $t3 no es igual a 0 salta a printp
		printv:
			la $a0, vacio #se imprime un vacio
			li $v0, 4
			syscall
			j crear 
		printp:
			li $t4, 0x58 #es (X) en codigo ASCII
			beq $t3, $t4, printX #si lo que esta en $t4 es igual a $t3 (0x58) se salta a printX
			li $t4, 0x4f #es (O) en codigo ASCII
			beq $t3, $t4, printO #si lo que esta en $t4 es igual a $t3 (0x4f) se salta a printO
			printX:
				la $a0,ficha1 #se imprimiria X
				li $v0,4
				syscall
				j crear
			printO: 
				la $a0,ficha2 #se imprimiria O
				li $v0,4
				syscall
				
			crear: #según vaya el contador $t2 decidira que simbolo debe de imprimir si un "|" o un "\n"
			beq $t2, 0, stick
			beq $t2, 1, stick
			beq $t2, 2, jump
			beq $t2, 3, stick
			beq $t2, 4, stick
			beq $t2, 5, jump
			beq $t2, 6, stick
			beq $t2, 7, stick
			beq $t2, 8, jump
			stick: #se imprime la pleca
				la $a0,pleca
				li $v0,4
				syscall
				addi $t2,$t2,1 #se le va sumando 1 al contador 
				j printtab
			jump: #se imprime el salto
				la $a0, salto
				li $v0,4
				syscall
				addi $t2,$t2,1 #se le va sumando 1 al contador 
				blt $t2,9,printtab #si $t2 es menor a 9 que salte a printtab
				bnez $s1, ultimo #se ultiliza para cuando ya haya un ganador o sino seguiria avanzando
				j decidir
	ultimo:
		li $s2, 1 #se utiliza para confirmar el ganador
		j Ganador
	decidir: 
		beq $t9,9,Empate #se determina empate si llega al limite y aun no hay ganador
		beq $t0,0,pantallaJ #si es el turno del jugador se muestra el mensaje "opciones"
		beq $t0,1,pantallaCPU #si es el turno de la CPU se muestra el mensaje "opciones"
pantallaJ:
	la $a0,opciones #imprime las opciones				
	li $v0,4
	syscall
	li $v0,5 #guarda la opcion que digito por medio de la sentencia que es para un entero
	syscall
	move $t1,$v0
	j verificar
pantallaCPU:
	la $a0,opciones #imprime las opciones				
	li $v0,4
	syscall 
	li $v0,42 #como la CPU no puede ingresar ningun digito lo que hace es que vuelve a generar un numero random hasta 8
	li $a1,9
	syscall
	li $v0,1 # llamada de sistema a 1, se toma mas para una prueba de impresion 
	syscall
	move $t1,$a0
verificar: #se encarga de verificar cada opcion que pueden seleccionar dirigiendose a cada funcion dependiendo la opcion que escojan 
	beq $t1,0,opcion1
	beq $t1,1,opcion2
	beq $t1,2,opcion3
	beq $t1,3,opcion4
	beq $t1,4,opcion5
	beq $t1,5,opcion6
	beq $t1,6,opcion7
	beq $t1,7,opcion8
	beq $t1,8,opcion9
	j decidir
opcion1:
	li $t2,0 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion2:
	li $t2,1 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion3:
	li $t2,2 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion4:
	li $t2,3 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion5:
	li $t2,4 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion6:
	li $t2,5 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion7:
	li $t2,6 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion8:
	li $t2,7 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
opcion9:
	li $t2,8 #se inicializa $t2 con la posicion que se tiene en tabXaO
	lb $t3, tabXaO($t2) #se carga el byte en la posicion que este en tabXaO
	bnez $t3, error #si no es igual a cero se dirige a la funcion error
	beqz $t3, PosFicha #sino se dirije a PosFicha que ayuda a decidir que ficha guardar
error: 
	la $a0,incorrecto #se imprime el mensaje de incorrecto
	li $v0,4 
	syscall
	beq $t0,0,pantallaJ
	beq $t0,1,pantallaCPU
PosFicha:
	addi $t9,$t9,1 #le voy agregando al contador de 1 para saber las fichas que se utilizan
	beq $t0,0,UbicarX #si es el turno del jugador se dirige a UbicarX
	beq $t0,1,UbicarO #si es el turno de la CPU se dirige a UbicarO
UbicarX:
	li $t4, 0x58 #se carga 0x58 a $t4, osea que se carga (X)
	sb $t4, tabXaO($t2) #ubica la X en la posciion que se encunetre en tabXaO
	j VerfColumnas #Verifica las columnas
UbicarO:
	li $t4, 0x4f #se carga 0x4f a $t4, osea que se carga (O)
	sb $t4, tabXaO($t2) #ubica la O en la posciion que se encunetre en tabXaO
VerfColumnas: #verifica si hay un jugador en las columnas 
	beq $t1,0,verif1 # carga los numeros que esten de forma vertical al tablero
	beq $t1,1,verif2
	beq $t1,2,verif3
	beq $t1,3,verif1
	beq $t1,4,verif2		
	beq $t1,5,verif3
	beq $t1,6,verif1
	beq $t1,7,verif2
	beq $t1,8,verif3
verif1: 
	li $t5,0
	li $t6,3
	j comparar
verif2: 
	li $t5,1
	li $t6,4
	j comparar
verif3: 
	li $t5,2
	li $t6,5
	j comparar
comparar: #comparar si los dos bytes tanto de $t5 y #$t6 son iguales
	lb $t7,tabXaO($t5) #se encarga de cargar el byte que se encuentra en $t5 lo carga en $t7
	lb $t8,tabXaO($t6) #se encarga de cargar el byte que se encuentra en $t6 lo carga en $t8
	beq $t7,$t8, sig
	j VerfFilas
		sig: #realiza el mismo proceso pero le suma 3 a cada uno para ver que se movio en sentido de columnas
		addi $t5,$t5,3
		addi $t6,$t6,3
		lb $t7,tabXaO($t5)
		lb $t8,tabXaO($t6)
		beq $t7,$t8, Ganador
		j VerfFilas
VerfFilas: #verifica si hay un jugador en las filas
	beq $t1,0,verif4 # carga los numeros que esten de forma horizontal al tablero
	beq $t1,1,verif4
	beq $t1,2,verif4
	beq $t1,3,verif5
	beq $t1,4,verif5
	beq $t1,5,verif5
	beq $t1,6,verif6
	beq $t1,7,verif6
	beq $t1,8,verif6
verif4: 
	li $t5,0
	li $t6,1
	j comparar2
verif5: 
	li $t5,3
	li $t6,4
	j comparar2
verif6: 
	li $t5,6
	li $t6,7
	j comparar2
comparar2: #comparar si los dos bytes tanto de $t5 y #$t6 son iguales
	lb $t7,tabXaO($t5) #se encarga de cargar el byte que se encuentra en $t5 lo carga en $t7
	lb $t8,tabXaO($t6) #se encarga de cargar el byte que se encuentra en $t6 lo carga en $t8
	beq $t7,$t8, sig1
	j VerfCruzadas 	
		sig1: #realiza el mismo proceso pero le suma 1 a cada uno para ver que se movio en sentido de filas
		addi $t5, $t5, 1
		addi $t6, $t6, 1
		lb $t7, tabXaO($t5)
		lb $t8, tabXaO($t6)
		beq $t7, $t8, Ganador	
		j VerfCruzadas
VerfCruzadas: #se realiza esta funcion solamente cuando se el numero sea par incluyendo el 0
	beq $t1,0,verf7 #este verf7 verifica de manera de posciones 0, 4, 8
	beq $t1,2,verf8 #este verf7 verifica de manera de posciones 2, 4, 6
	beq $t1,4,verf9 #este verf9 logra hacer la verificacion de manera cruzada pero partiendo desde la posicion 4
	beq $t1,6,verf8
	beq $t1,8,verf7 
	j SigTurno
verf7: 
	li $t5,0
	li $t6,4
	lb $t7, tabXaO($t5)
	lb $t8, tabXaO($t6)
	beq $t7,$t8,sig2
	j SigTurno
		sig2:
		addi $t5,$t5,4
		addi $t6,$t6,4
		lb $t7, tabXaO($t5)
		lb $t8, tabXaO($t6)
		beq $t7,$t8,Ganador
		j SigTurno
verf8: 
	li $t5,2
	li $t6,4
	lb $t7, tabXaO($t5)
	lb $t8, tabXaO($t6)
	beq $t7,$t8,sig3
	j SigTurno
		sig3:
		addi $t5,$t5,2
		addi $t6,$t6,2
		lb $t7, tabXaO($t5)
		lb $t8, tabXaO($t6)
		beq $t7,$t8,Ganador
		j SigTurno
verf9: #como esta verificacion es de todas las esquinas iniciando desde 4, inicia con las esquinas de 0, 4, 8.
	li $t5,0
	li $t6,4
	lb $t7, tabXaO($t5)
	lb $t8, tabXaO($t6)
	beq $t7,$t8,sig4
	j SigVerif
		sig4:
		addi $t5,$t5,4
		addi $t6,$t6,4
		lb $t7, tabXaO($t5)
		lb $t8, tabXaO($t6)
		beq $t7,$t8,Ganador
		j SigVerif
	SigVerif: #despues de realizar la verificaciones de las esquinas 0, 8, se realiza la verificacion de las esquinas 2 y 6.
	li $t5,2
	li $t6,4
	lb $t7, tabXaO($t5)
	lb $t8, tabXaO($t6)
	beq $t7,$t8,sig5
	j SigTurno
		sig5:
		addi $t5,$t5,2
		addi $t6,$t6,2
		lb $t7, tabXaO($t5)
		lb $t8, tabXaO($t6)
		beq $t7,$t8,Ganador
		j SigTurno
SigTurno: # se encarga de dar el siguiente turno ya sea al jugador o a la CPU
	beq $t0,0,Turno1
	beq $t0,1,Turno2
Turno1: 
	li $t0,1 #como era el turno del primer jugador se cambiaria al segundo jugador
	j decidet
Turno2:
	li $t0,0 #como era el turno del segundo jugador se cambiaria al primer jugador
	j decidet
Ganador: 
	li $s1, 1 #Cuando se encuentra un jugador se carga en $s1
	beqz $s2, decidet #si $s2 se ecuentra en 0, vuelve a SigTurno e imprime por ultima vez el tablero
	beq $t0,0,Ganador1 #si esta igualado a 0 pasa a Ganador1
	beq $t0,1,Ganador2 #si esta igualado a 0 pasa a Ganador2
Ganador1:
	la $a0,ganador1 #imprime e mensaje que se encuentra en ganador1
	li $v0,4
	syscall
	j salir
Ganador2:
	la $a0,ganador2 #imprime e mensaje que se encuentra en ganador2
	li $v0,4
	syscall
	j salir
Empate: 
	la $a0,empate #imprime e mensaje que se encuentra en ganador2
	li $v0,4
	syscall
	j salir
salir:
	li $v0,10 #sale del juego
	syscall
