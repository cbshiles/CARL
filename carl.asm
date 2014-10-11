sys_exit equ 1
sys_read equ 3
sys_write equ 4
stdin equ 0
stdout equ 1
stderr equ 3
	;; add those other sys calls
	
SECTION .data
	spec_chars db `\'\"\`{[( )]}\t\n`
	spec_len equ $-spec_chars

SECTION .bss

SECTION .text
global _start
	
_start:
	mov ecx, spec_chars
	mov edx, spec_len
	call DisplayText
	jmp Exit

DisplayText:
;;; ecx - string location
;;; edx - number of chars
	mov eax, sys_write
	mov ebx, stdout
	int 80h
	ret
	
Exit:
	mov eax, sys_exit
	mov ebx, 0
	int 80h
	
