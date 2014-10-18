global str_len
global stringx

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
	jmp .trans
	
	mov bl, al
	shr bl, 4
	jmp .trans
	
.test:	shr eax, 8
	loop .loop
	pop ecx
	ret

.trans:	cmp bl, 10		;Translate to char
	jge .lett		;If its a letter (A-F)
	add bl, 48
	jmp .wrap
.lett:	add bl, 55
.wrap:	mov [edx], bl
	inc edx
	jmp .test
	

