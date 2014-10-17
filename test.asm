%include "macros.asm"
%include "head.asm"
	
SECTION .data
	string specChars, `\'\"\`{[( )]}\t\n`
SECTION .bss

SECTION .text
global _start
	
_start:
	pout specChars
	jmp exit
