%include "macros.asm"
%include "header.asm"
	
SECTION .data

SECTION .bss
	num resb 8
SECTION .text
global _start
	
_start:

	mov eax, 25
	call primer
	mov ecx, num
	call stringx
	call print
	call print_ln
	jmp exit

primer:
	cmp eax, 2
	ja .cont 		;Above, larger than 2
	ret

.cont:
	test eax, 1		;Is it even?
	jnz .cont2		;Not zero, final bit was 1 (odd)
	mov eax, 2
	ret

.cont2:
	mov edi, eax
	mov ebx, 3
	int 3

Qoop:	cmp eax, ebx
	jbe .out 		;Done if divisor > potential prime number

	div ebx

	cmp edx, 0 		;Zero remainder, clean division
	je .end
	add ebx, 2
	mov eax, edi
	jmp Qoop

.end:
	mov eax, ebx
	ret

.out:
	mov eax, 0
	ret
	

	
	
