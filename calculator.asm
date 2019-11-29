section .data
	welcome_msg db	'Qual o seu nome? ',0
	welcome_msg_size	EQU	$-welcome_msg

	hello_msg db	'Ola, ',0
	hello_msg_size	EQU	$-hello_msg

	hello_cont db	', bem-vindo ao programa de CALC IA-32',0
	hello_cont_size	EQU	$-hello_cont

	choose_msg	db	'ESCOLHA UMA OPÇÃO:',0dh,0ah
	choose_msg_size	EQU	$-choose_msg

	sum_msg	db	'-1: SOMA',0dh,0ah
	sum_msg_size EQU	$-sum_msg

	sub_msg	db	'-2: SUBTRAÇÃO',0dh,0ah
	sub_msg_size EQU	$-sub_msg

	mul_msg	db	'-3: MULTIPLICAÇÃO',0dh,0ah
	mul_msg_size EQU	$-mul_msg

	div_msg	db	'-4: DIVISÃO',0dh,0ah
	div_msg_size EQU	$-div_msg

	mod_msg	db	'-5: MOD',0dh,0ah
	mod_msg_size EQU	$-mod_msg

	quit_msg	db	'-6: SAIR',0dh,0ah
	quit_msg_size EQU	$-quit_msg

	op1_msg db	'Digite o primeiro argumento da operação: ',0
	op1_msg_size	EQU	$-op1_msg

	op2_msg db	'Digite o segundo argumento da operação: ',0
	op2_msg_size	EQU	$-op2_msg

	result_msg db	'O resultado é: ',0
	result_msg_size	EQU	$-result_msg

	new_line	db	0Dh, 0Ah
	new_line_size	EQU	$-new_line

	press_enter_msg db 'Pressione enter para voltar ao menu',0
	press_enter_size EQU $-press_enter_msg


section .bss
	user_name	resb	16	; nome do usuário da calculadora
	option	resb	1	; menu option
	arg1	resb	11	; operandos com até 32 bits (10 algarismos)
	arg2	resb	11	; operandos com até 32 bits (10 algarismos)
	resposta resb   11  ; Resultado da operacao
	arg1Int resd	1	; Inteiro do argumento 1
	arg2Int	resd	1	; Inteiro do argumento 2

section .text
global _start
_start:

; Qual o seu nome?
	push welcome_msg_size
	push welcome_msg
	call put_string

; Get user_name
	push 16
	push user_name
	call get_string

; 'Hóla, '
	push hello_msg_size
	push hello_msg
	call put_string

; 'user_name'
	push user_name
	call put_name

; ', bem-vindo ao programa de CALC IA-32'
	push hello_cont_size
	push hello_cont
	call put_string
	; Imprime uma new line no terminal
	push new_line_size
	push new_line
	call put_string

menu:
	mov dword [arg1Int],0
	mov dword [arg2Int],0
	mov dword [resposta],0
	;Imprime uma new line no terminal
	push new_line_size
	push new_line
	call put_string

	; Escolha uma opcao:
	push choose_msg_size
	push choose_msg
	call put_string

; add operation
	push sum_msg_size
	push sum_msg
	call put_string

; sub operation
	push sub_msg_size
	push sub_msg
	call put_string

; mul operation
	push mul_msg_size
	push mul_msg
	call put_string

; div operation
	push div_msg_size
	push div_msg
	call put_string

; mod operation:
	push mod_msg_size
	push mod_msg
	call put_string

	push quit_msg_size
	push quit_msg
	call put_string

; get operation:
	push 1
	push option
	call get_string

	; Faz a logica do menu e a opcao selecionada

	cmp byte [option], 31h	; 1d = 31h
	je	add_operation
	
	cmp byte [option], 32h	; 2d = 32h
	je	sub_operation
	
	cmp byte [option], 33h	; 3d = 33h
	je	mul_operation
	
	cmp byte [option], 34h	; 4d = 34h
	je	div_operation
	
	cmp byte [option], 35h	; 5d = 35h
	je	mod_operation
	
	cmp byte [option], 36h	; 6d = 36h
	jne menu

return:
	mov eax, 1			; sys_exit
	mov ebx, 0
	int 80h





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
espera:
	push new_line_size
	push new_line
	call put_string
	push press_enter_size
	push press_enter_msg
	call put_string
	push option
	call get_string
	cmp byte [option], 0ah
	jne espera
	jmp menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - ADICAO
;
add_operation:
	; mensagem para Digitar o primeiro arg
	push op1_msg_size
	push op1_msg
	call put_string
	; Funcao para pegar a string e retornar inteiro
	; Recebe como argumento o lugar para guardar o inteiro e o lugar da string
	
	push arg1Int	; Lugar para guardar o inteiro 	
	push arg1		; Lugar para armazenar a string do inteiro
	call get_signed_int

	mov eax,[arg1Int] ;Coloca o numero inteiro no EAX

; Pegar o 2 numero
	push op2_msg_size
	push op2_msg
	call put_string

	push arg2Int	; Lugar para guardar o inteiro 	
	push arg2		; Lugar para armazenar a string do inteiro
	call get_signed_int
	
	
	;O resultado é 
	push result_msg_size
	push result_msg
	call put_string
	
	; é feito a soma dois dois
	mov eax,[arg1Int]
	mov	ebx,[arg2Int]
	add eax,ebx
	mov ecx , 10

	push eax ; Numero que se deseja escrever na tela
	push ecx ; Tamanho do numero inteiro

	call int_to_string
		
	jmp espera
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - SUBTRACAO
;
sub_operation:
; mensagem para Digitar o primeiro arg
	push op1_msg_size
	push op1_msg
	call put_string
	; Funcao para pegar a string e retornar inteiro
	; Recebe como argumento o lugar para guardar o inteiro e o lugar da string
	
	push arg1Int	; Lugar para guardar o inteiro 	
	push arg1		; Lugar para armazenar a string do inteiro
	call get_signed_int

	mov eax,[arg1Int] ;Coloca o numero inteiro no EAX

; Pegar o 2 numero
	push op2_msg_size
	push op2_msg
	call put_string

	push arg2Int	; Lugar para guardar o inteiro 	
	push arg2		; Lugar para armazenar a string do inteiro
	call get_signed_int
	
	
	;O resultado é 
	push result_msg_size
	push result_msg
	call put_string
	
	; é feito a subtracao dos dois
	mov eax,[arg1Int]
	mov	ebx,[arg2Int]
	sub eax,ebx
	mov ecx , 10

	push eax ; Numero que se deseja escrever na tela
	push ecx ; Tamanho do numero inteiro

	call int_to_string
		
	jmp espera




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - MULTIPLICACAO
;
; mensagem para Digitar o primeiro arg
mul_operation:
	push op1_msg_size
	push op1_msg
	call put_string
	; Funcao para pegar a string e retornar inteiro
	; Recebe como argumento o lugar para guardar o inteiro e o lugar da string
	
	push arg1Int	; Lugar para guardar o inteiro 	
	push arg1		; Lugar para armazenar a string do inteiro
	call get_signed_int

	mov eax,[arg1Int] ;Coloca o numero inteiro no EAX

; Pegar o 2 numero
	push op2_msg_size
	push op2_msg
	call put_string

	push arg2Int	; Lugar para guardar o inteiro 	
	push arg2		; Lugar para armazenar a string do inteiro
	call get_signed_int
	
	
	;O resultado é 
	push result_msg_size
	push result_msg
	call put_string
	
	; é feito a multiplicacao dos dois numeros
	mov eax,[arg1Int]
	mov	ebx,[arg2Int]
teste:
	;zera edx
	sub edx,edx
	imul ebx
	mov ecx , 10

	push eax ; Numero que se deseja escrever na tela
	push ecx ; Tamanho do numero inteiro

	call int_to_string
		
	jmp espera



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - MOD
;
mod_operation:
; mensagem para Digitar o primeiro arg
	push op1_msg_size
	push op1_msg
	call put_string
	; Funcao para pegar a string e retornar inteiro
	; Recebe como argumento o lugar para guardar o inteiro e o lugar da string
	
	push arg1Int	; Lugar para guardar o inteiro 	
	push arg1		; Lugar para armazenar a string do inteiro
	call get_signed_int

	mov eax,[arg1Int] ;Coloca o numero inteiro no EAX

; Pegar o 2 numero
	push op2_msg_size
	push op2_msg
	call put_string

	push arg2Int	; Lugar para guardar o inteiro 	
	push arg2		; Lugar para armazenar a string do inteiro
	call get_signed_int
	
	
	;O resultado é 
	push result_msg_size
	push result_msg
	call put_string
	
	; é feito a divisao dos dois
	mov eax,[arg1Int]
	mov	ebx,[arg2Int]
	sub edx,edx
	; Verifica se eax é negativo
	cmp eax,2147483647
	ja	extende_sinalmod
continua_mod:
	;idiv pega (EDX:EAX) / EBX
	idiv ebx
	mov ecx , 10

	push edx ; Numero que se deseja escrever na tela
	push ecx ; Tamanho do numero inteiro

	call int_to_string
		
	jmp espera
extende_sinalmod:
	mov edx,4294967295
	jmp continua_mod


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - Divisao
;

div_operation:
; mensagem para Digitar o primeiro arg
	push op1_msg_size
	push op1_msg
	call put_string
	; Funcao para pegar a string e retornar inteiro
	; Recebe como argumento o lugar para guardar o inteiro e o lugar da string
	
	push arg1Int	; Lugar para guardar o inteiro 	
	push arg1		; Lugar para armazenar a string do inteiro
	call get_signed_int

	mov eax,[arg1Int] ;Coloca o numero inteiro no EAX

; Pegar o 2 numero
	push op2_msg_size
	push op2_msg
	call put_string

	push arg2Int	; Lugar para guardar o inteiro 	
	push arg2		; Lugar para armazenar a string do inteiro
	call get_signed_int
	
	
	;O resultado é 
	push result_msg_size
	push result_msg
	call put_string
	
	; é feito a divisao dos dois
	mov eax,[arg1Int]
	mov	ebx,[arg2Int]
	sub edx,edx
	; Verifica se eax é negativo
	cmp eax,2147483647
	ja	extende_sinaldiv
continua_div:
	;idiv pega (EDX:EAX) / EBX
	idiv ebx
	mov ecx , 10

	push eax ; Numero que se deseja escrever na tela
	push ecx ; Tamanho do numero inteiro

	call int_to_string
		
	jmp espera
extende_sinaldiv:
	mov edx,4294967295
	jmp continua_div


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
put_name:
	sub edx, edx
	mov ecx, [esp + 4]	; string pointer
name:
	cmp byte [ecx], 0ah	; line feed character
	je	final_name
	cmp byte [ecx], 13	; enter character
	je	final_name
	inc edx	; size name counter
	inc ecx	; get next character
	jmp name

final_name:
	mov ecx, [esp + 4]	; restart pointer to initial string character
	mov eax, 4	; sys_write
	mov ebx, 1	; std_out
	int 80h
	ret 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
put_string:
	mov eax, 4	; sys_write
	mov ebx, 1	; std_out
	mov ecx, [esp + 4]	; string pointer
	mov edx, [esp + 8] ; string length
	int 80h
	ret 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
get_string:
	mov eax, 3	; sys_read
	mov ebx, 0	; std_out
	mov ecx, [esp + 4]	; string pointer
	mov edx, [esp + 6] ; string length
	int 80h
	ret 4



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE - pegar numero do teclado e transformar em inteiro
;
get_signed_int:
	;Pega a string e coloca no vetor do argumento
	mov eax, 3	; sys_read
	mov ebx, 0	; (teclado)
	mov ecx, [esp + 4]	; Coloca a string do numero digitado nessa posicao
	mov edx, 11 ; string length o maximo é 10 algarismos + o sinal = 11
	int 80h
	;Zera os registradores EBX - resultado 
	sub esi,esi
	sub ebx,ebx
	sub eax,eax
	mov edi,10
	mov ecx, [esp + 4] ; LUgar do numero digitado
comecoStringToInt: 
	movzx ebx,byte [ecx + esi] ; coloca o digito do numero no ebx
	cmp bl , 45 ; ASCII do '-'
	je	incrementaStringToInt
	cmp bl, 48 ; Compara o  digito com 0 - 48d
	jb	fimStringToInt
	cmp bl , 57 ; Compara o  digito com 9 - 57d
	ja 	fimStringToInt
	sub bl,30h ; transforma o digito em decimal
	
	mul edi ; Pega o resultado parcial(eax) e multiplica por 10
	add eax,ebx	; O valor final fica em eax
incrementaStringToInt:	
	inc esi
	jmp comecoStringToInt
fimStringToInt:
	cmp byte [ecx],45 ; Compara e verifica se o numero é negativo
	jne finalStringToInt
	sub ebx,ebx	; Zera ebx
	sub ebx,eax	; Torna o numero negativo
	dec esi		; O numero negativo tem -1 o tamanho do esi
	mov eax,ebx	; Coloca ele de novo em EAX
finalStringToInt:	
	mov ebx,[esp+8] ; Endereco que guarda o numero inteiro
	mov [ebx],eax	; Numero inteiro
	mov ecx,esi		; Tamanho do numero
	ret 8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
int_to_string:
	mov eax,[esp+8]		; EAX - Valor a ser impresso na tela
	;mov eax,[eax]
	mov	ebx,resposta+10	; EBX - Digito menos significativo do numero
	cmp eax,2147483647	; Se for maior que esse valor significa que o numero é negativo
	ja negativo
continuacao:
	mov	ecx,[esp+4]	; ECX - O tanto de algarismos que o numero contem
	mov	edi,10
					;-2147483648	 Maior numero negativo
	
TransformaEmString:
	mov	edx,0
	div	edi
	add	edx,48
	mov	[ebx],dl
	dec	ebx
	dec ecx
	jnz TransformaEmString
fim:
	mov	eax,4			
	mov	ebx,1			
	mov	ecx,resposta
	mov	edx,11
	int	80h
	
	ret 

negativo:
	mov byte [resposta],45
	mov edx,4294967295		; Transforma o numero em negativo
	sub edx,eax		
	mov eax,edx				; Recoloca no registrador EAX
	inc eax					;
	jmp continuacao			; VOlta ao procedimento normal




	


