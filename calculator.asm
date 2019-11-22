section .data
	welcome_msg db	'Qual o seu nome? ',0
	welcome_msg_size	EQU	$-welcome_msg

	hello_msg db	'Hóla, ',0
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

	result_msg db	'Digite o segundo argumento da operação: ',0
	result_msg_size	EQU	$-result_msg

	new_line	db	0Dh, 0Ah
	new_line_size	EQU	$-new_line

section .bss
	user_name	resb	16	; nome do usuário da calculadora
	option	resb	1	; menu option
	arg1	resb	11	; operandos com até 32 bits (11 algarismos)
	arg2	resb	11	; operandos com até 32 bits (11 algarismos)

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

	push new_line_size
	push new_line
	call put_string

menu:
	push new_line_size
	push new_line
	call put_string

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

	cmp byte [option], 31h	; 1d = 31h
	je	add_operation
	cmp byte [option], 36h	; 6d = 36h
	jne menu

return:
	mov eax, 1			; sys_exit
	mov ebx, 0
	int 80h

add_operation:
	push op1_msg_size
	push op1_msg
	call put_string

	push ax	; save space for return firts operand
	push bx ; save space for return second operand
	push 11
	push arg1
	call get_signed_int

	;push op2_msg_size
	;push op2_msg
	;call put_string
;
	;push 11
	;push arg2
	;call get_signed_int

	jmp return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;
put_name:
	sub edx, edx
	mov ecx, [esp + 4]	; string pointer
name:
	cmp byte [ecx], 0	; null character
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
	mov eax, 3	; sys_write
	mov ebx, 0	; std_out
	mov ecx, [esp + 4]	; string pointer
	mov edx, [esp + 6] ; string length
	int 80h
	ret 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROCEDURE
;	stack ->	ax (esp+10)
;						bx (esp+8)
;						arg_size (esp+6)
;						arg (esp+4)
;						return Addrs (esp)
get_signed_int:
	mov eax, 3	; sys_write
	mov ebx, 0	; std_out
	mov ecx, [esp + 4]	; string pointer
	mov edx, [esp + 6] ; string length
	int 80h
	ret 4


	


