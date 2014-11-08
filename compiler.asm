%include "macros.asm"
%include "header.asm"
	
SECTION .data
	string ta, "test1.carl"
	string tb, "test2"
	string oXten, "asm"
SECTION .bss

SECTION .text
global _start
	
_start:
	mov ebx, ta
	mov edx, oXten

	call xten

	mov edx, 400	;File permissiosn
	call create
	jmp exit
