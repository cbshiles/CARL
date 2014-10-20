global str_len
global stringx
global xten

SEGMENT .data

SEGMENT .text

	
str_len:			;ECX - ptr to string
	mov edx, ecx
	push ecx
	mov ecx, 0
.loop:	cmp [edx], ecx 		;ecx=0
	je .daEnd
	inc edx
	jmp .loop
.daEnd:	pop ecx
	sub edx, ecx
	ret		
;;; (ECX)-location of string
;;; EDX-length of string

;;; EAX - value to convert
;;; ECX - memory location to store string
stringx:			;Converts # into hex string
	mov	edx, ecx
	push	ecx
	mov ecx, 4 		;4 words to process
.loop:
	mov bl, al
	and bl, 0xF 		;L-O nibble
	call .trans
	
	mov bl, al
	shr bl, 4
	call .trans
	
.test:	shr eax, 8
	loop .loop
	pop ecx
	mov edx,8
	ret

.trans:	cmp bl, 10		;Translate to char
	jge .lett		;If its a letter (A-F)
	add bl, 48
	jmp .wrap
.lett:	add bl, 55
.wrap:	mov [edx], bl
	inc edx
	ret

;;; Allows you to change the extension on a file name
;;; EBX Pointer to original file name
;;; EDX Pointer to new extension
;;; Uses AX
xten:	push ebx		;Pop back into EBX
	mov ax,	0x2E00		; . and zero

.rloop:
	cmp [ebx], ah
	jz .period

	cmp [ebx], al
	jz .zero

	inc ebx
	jmp .rloop

.zero:				;If hit a zero, add a period
	mov [ebx], ah

.period:			;If hit a period inc pointer
	inc ebx
.wloop:
	mov ah, [edx]
	mov [ebx], ah

	cmp ah, al		;0
	jz .daend
	
	inc edx
	inc ebx

	jmp .wloop
	
.daend:
	pop ebx
	ret
	
;;; Return EBX Indentical pointer to modified file name
;;; Return ECX Length of modified string
;;; EAX, EDX : junk

;;; TEST - on ones w/ xtens and w/o
