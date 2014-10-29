;;; Sys-calls meta function
SEGMENT .data

newline db 0xA,0
	
SEGMENT .text
	
global create
global open_r
global open_rw
global open_w
global open
global hear
global read
global perror
global nwln
global print_ln
global print
global write
global exit


;;; sys_open
;;; EBX - file name


;;; WARNING - Ugly hack - set for *eventual* removal
;;; Initially will be used as catch all creation default
;;; EDX - mode is required for this one
;;; (1 execute) (2 write) (4 read) can be added. ex: (7 all)
;;; (*1 other) (*10 group) (*100 usr) these section are or'd together
;;; 1FFh is an ok permission for now
;;; WARNING - Ugly hack - set for *eventual* removal
create:	mov 	ecx, 102 	;Hopefully create (100) + rw (2)
	jmp open

open_w:	mov ecx, 1		;Write-only
	jmp open

open_rw:mov ecx, 2		;Read-write
	jmp open
	
open_r:	mov ecx, 0		;Read-only

;;; ECX - flags
open:	mov eax, 5		;sys_open
	jmp sysc

	
;;; EBX - file descriptor (int - fd)
;;; sys_open

;;; hear-write fns
;;; EBX - file descriptor
;;; ECX -location of memory for read to / write from
;;; EDX - length of chunk of memory
hear:	mov ebx, 0 		;0 is for stdin
read:	mov eax, 3 		;3 is sys_read
	jmp sysc

;;; EAX - # of bytes actually read
	
perror:	mov ebx, 3		;3 = stderr
	jmp write

;;; Newline functions
;;; These print their own seperate strings, so all regs are used
nwln:	mov ecx, newline
	mov edx, 1
	jmp write

print_ln:mov ecx, newline
	mov edx, 1
;;; Newline functions
	
print:	mov ebx, 1 		;1 is stdout
write:	mov eax, 4		;4 is sys_write
	jmp sysc
;;; hear-write fns
	
exit:	mov eax, 1
	mov ebx, 0

;;; EAX - sys call
;;; Others might need to be set, depending on which sys call
sysc:	int 80h 		
	ret
;;; Normally EAX modified. Dependent again on the specific sys call.
