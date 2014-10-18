%include "macros.asm"
%include "header.asm"
	
SECTION .data
	string specChars, `\'\"\`{[( )]}\t\n`
SECTION .bss
	buffa resb 8
SECTION .text
global _start
	
_start:	
	call nwln
	call nwln
	pout specChars
	mov ecx, specChars
	call str_len
	mov eax, edx
	mov ecx, buffa
	call stringx
	jmp exit
