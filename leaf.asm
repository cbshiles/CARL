%include "macros.asm"
%include "header.asm"
	
SECTION .data
	stringL open_source, "Unable to access source file."

	iPtr dd iBuff

SECTION .bss
	BSZ equ 50
	iBuff resb BSZ
	oBuff resb BSZ
	iLast resd 1

SECTION .text
global _start
	
_start:
	pop ebx 		;# of arguments
	pop ebx			;Program's path
	
	pop ebx			;Source path
	call open_r

	cmp eax, -1 ;Sucessful calls return a positive fd
	jne .cont
	pout open_source

.cont:
	nop


wrap_up:
	
	jmp exit



	

fill_iBuff:			;Fill input buffer
	mov ecx, iBuff
	mov edx, BSZ
	call read
	mov [iLast], eax
	ret
;;; Returns # of bytes read into EAX, iLast

chpu:				;Character pull
	mov eax, iBuff
	mov ebx, [iPtr]
	add eax, [iLast]	;EAX = bytes read + start of iBuff
	cmp ebx, eax		
	jb .simp_pull		;If iPtr(ebx) less than that, all good

	sub eax, BSZ 		;To figure out whether last read filled iBuff
	cmp eax, iBuff		
	jb .daEnd		;If less than iBuff, file over

	call fill_iBuff
	
.simp_pull:
	mov al, [ebx]
	inc ebx
	mov [iPtr], ebx
	ret

.daEnd:
	jmp wrap_up
