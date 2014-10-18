%include "macros.asm"
%include "header.asm"
	
SECTION .data
	string iXten ".carl"
	string oXten ".csm"
SECTION .bss
	
SECTION .text
global _start

_start: int 3
	nwln
	jmp exit
;;; ;;
	pop ecx 		;# of arguments
	pop ecx			;Program's path
	pop ecx			;First argument
	call str_len 		;tools.asm

	cmp edx, 0		;If length = 0
	jz exit 		;Skip print
	
	call print		;sys_calls.asm
	call print_ln

	jmp exit

;;;code-stack
	
;;; Creation of new file
	mov ebx, test_file
	mov edx, 1FFh 		;Is an ok permission for now
	call create

