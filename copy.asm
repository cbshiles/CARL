SECTION .data
	%include "errors.t"

SECTION .bss
	max_name equ 32
	file_name resb max_name
	
	max_buff equ 1000
	text_buff resb max_buff

SECTION .text
global _start
	
_start:
	int 3
	pop eax 			;program name
	pop eax				;argc
	pop eax				;first arg
	mov dword [file_name], eax
	mov ecx,   eax ;file_name	
	mov edx, max_name
	call print
	
	jmp exit
	%include "sys_calls.asm"
