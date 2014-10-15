%include "macros.m"
%include "start.h"
	
SECTION .data

SECTION .bss
	fname resd 1		;Name of input file
	BMAX equ 4096 		;Max buffer size
	buff  resb BMAX		;read buffer
	bsize resd 1		;Current size(fullness) of buffer 
SECTION .text
	
global _start

_start:
	pop ebx ;# of arguments
	cmp ebx, 1
	jb daend
	pop ebx	;Program's path
	pop ebx	;First argument, file name
	mov [fname], ebx
	call open_r  ;sys
	cmp eax, 0 		;Sucessful calls return a positive fd
	jge .cont
	;; make a macro for defining and printing strings
	;;print out cant open file msg here
.cont   mov ebx, eax		;Move fd
	mov ecx, buff
	mov edx, BMAX
	call read
	mov [bsize], eax	;eax is # of chars read

	mov ebx, [fname]
	mov al, [ebx]
	mid equ (32+126)/2 ;For the name change hack 
	sub al, mid

	cmp al, 0
	jne .cunt
	inc al
.cunt	add [ebx], al
	;; Creation of new file
	mov ebx, [fname]
	mov edx, 1FFh ;Is an ok permission for now
	call create
	
daend:	jmp exit
	
