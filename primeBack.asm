%include "macros.asm"
%include "header.asm"

SECTION .data
endSieve dd 7FFFFFFEh 		;Last valid bit

SECTION .bss
	sieve resd 04000000h
SECTION .text
global _start

;;; Sieve idea could be very fast but is not well suited for this problem

_start:
;;; Fill sieve will all ones
	mov ecx, [endSieve] 	;#of bits
	shr ecx, 5 		;2^5 = 32 = 8bits*4bytes # of dwords
	inc ecx 		;In case one got rounded
	mov edi, sieve

.fill:
	mov dword[edi+ecx-1], -1	;Fill in sieve with those 1s
	loop .fill

	mov eax, 88

	call primer
	
	jmp exit

primer:

even-or-one:
	cmp eax, 1
	jbe daend

	test eax, 1 		;Is it even?
	jnz .cont
	mov eax, 2
	jmp daend

.cont:


	
