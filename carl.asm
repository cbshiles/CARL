SECTION .data
	spec_chars db `\'\"\`{[( )]}\t\n`, 0
	spec_len equ $-spec_chars
	
	test_file db "/home/brenan/johns-edmacs",0

	%include "strings.t"

SECTION .bss
	max_buff equ 1000
	text_buff resb max_buff+1 ;Always keep final byte 0
	
SECTION .text
global _start

_start:
;;; print hex values
	
	jmp exit

;;; Procedure include section
	%include "sys_calls.asm"
	%include "tools.asm"
;;; Procedure include section

;;;code-stack
	
;;; Creation of new file
	mov ebx, test_file
	mov edx, 1FFh 		;Is an ok permission for now
	call create

;;; what it does so far-
;;; takes a single argument and prints it back out
	pop ecx 		;# of arguments
	pop ecx			;Program's path
	pop ecx			;First argument
	call str_len 		;tools.asm


	cmp edx, 0		;If length = 0
	jz exit 		;Skip print
	
	call print		;sys_calls.asm
	call print_ln
