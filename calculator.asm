section .data
	welcome_msg db	'Qual o seu nome?'
	welcome_msg_size	EQU	$-welcome_msg

	hello_msg db	'Hóla, ', 0
	hello_msg_size	EQU	$-hello_msg

	hello_cont db	', bem-vindo ao programa de CALC IA-32'
	hello_cont_size	EQU	$-hello_cont

	choose_msg	db	'ESCOLHA UMA OPÇÃO:'
	choose_msg_size	EQU	$-choose_msg

	sum_msg	db	'-1: SOMA'
	sum_msg_size EQU	$-sum_msg

	sub_msg	db	'-2: SUBTRAÇÃO'
	sub_msg_size EQU	$-sub_msg

	mult_smg	db	'-3: MULTIPLICAÇÃO'
	mult_msg_size EQU	$-mult_smg

	div_msg	db	'-4: DIVISÃO'
	div_msg_size EQU	$-div_msg

	mod_msg	db	'-5: MOD'
	mod_msg_size EQU	$-mod_msg

	quit_msg	db	'-6: SAIR'
	quit_msg_size EQU	$-quit_msg

	op1_msg db	'Digite o primeiro argumento da operação: '
	op1_msg_size	EQU	$-op1_msg

	op2_msg db	'Digite o segundo argumento da operação: '
	op2_msg_size	EQU	$-op2_msg

	result_msg db	'Digite o segundo argumento da operação: '
	result_msg_size	EQU	$-result_msg

	new_line	db	0Dh, 0Ah
	new_line_size	EQU	$-new_line

section .bss
	user_name	resb	16	; nome do usuário da calculadora
	arg1	resb	11	; operandos com até 32 bits (11 algarismos)
	arg2	resb	11	; operandos com até 32 bits (11 algarismos)

section .text
global _start
_start:

	push welcome_msg_size
	push welcome_msg
	push 1
	push 4
	call put_string

return:
	mov eax, 1			; sys_exit
	mov ebx, 0
	int 80h

put_string:
	mov eax, [esp + 4]	; sys_write
	mov ebx, [esp + 8]	; std_out
	mov ecx, [esp + 12]	; string pointer
	mov edx, [esp + 16] ; string length
	int 80h
	ret 6

