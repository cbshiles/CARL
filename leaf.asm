%include "macros.asm"
%include "header.asm"
	
SECTION .data
	stringL open_source, "Unable to access source file."
	stringL arg_num, "Invalid # of arguments."

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
	cmp ebx, 2		;Only takes 1 arg atm
	je arg_check		;Passed the check
	pout arg_num
	jmp wrap_up
	
arg_check:	
	pop ebx			;Program's path
	
	pop ebx			;Source path
	call open_r

	cmp eax, -1 ;Sucessful calls return a positive fd
	jg .cont
	pout open_source
	jmp wrap_up
	


.cont:
	;jmp router		
;;; Create output file here, i believe (Yes indeed)
	
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

;;; Returns char in al, uses ebx
