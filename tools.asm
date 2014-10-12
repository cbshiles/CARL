;;; Determine the length of a string
;;; ECX - location of string
		str_len_max equ 2000 	;max length of a string
	
str_len:	jecxz str_empty	     ;More like pointer empty
		push ecx 		;Push initial pointer
		mov ebx, ecx		;Give pointer to ebx
		dec ebx			;For wind-up loop
		mov ecx, str_len_max	;Loop unitl size = max
		mov edx, ecx		;Store max val

str_len_a:	inc ebx		;This is the wind-up
		cmp byte[ebx], 0
		je str_len_z 	
		loop str_len_a

str_len_z:	sub edx, ecx 	;# of characters
		pop ecx 	;ECX retains initial value
		ret

str_empty:	mov edx, ecx	;0
		ret
;;; ECX - location of string
;;; EDX - # of characters

	
