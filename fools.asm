global str_len
global stringx
str_len_max equ 2000 ;max length of a string
SEGMENT .data
;;; Determine the length of a string
;;; ECX - location of string
str_len:	jecxz str_empty	;More like pointer empty
push ecx ;Push initial pointer
mov ebx, ecx	;Give pointer to ebx
dec ebx	;For wind-up loop
mov ecx, str_len_max	;Loop unitl size = max
mov edx, ecx	;Store max val
str_len_a:	inc ebx	;This is the wind-up
cmp byte[ebx], 0
je str_len_z
loop str_len_a
str_len_z:	sub edx, ecx ;# of characters
pop ecx ;ECX retains initial value
ret
str_empty:	mov edx, ecx	;0
ret
;;; ECX - location of string
;;; EDX - # of characters
;;; Determine the length of a string
;;; 'string' hex values
;;; EAX - hex value to turn into a string
;;; ECX - memory location to store string
stringx:mov ebx, eax
mov esi, ecx
mov edx, 8
add esi, edx ;End of string
shl edx, 8   ;Into DH
hex_l:	mov dl, al
shr eax, 4	;Prepare for next hex digit
and dl, 0Fh ;Single hex val
cmp dl, 10	
jge hex_lett ;If < 10, digit - else, letter
add dl, 48	;If a digit
jmp hex_z
hex_lett: add dl, 55	;If a letter
hex_z:	dec esi
mov byte[esi], dl
cmp esi, ecx
jne hex_l
shr edx, 8	;into DL
ret
;;; EAX - unchanged - numerical hex value
;;; ECX - unchanged - memory location
;;; EDX - 8 - for length of hex string
;;; 'string' hex values 
