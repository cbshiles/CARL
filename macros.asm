%ifndef MACROS_MAC 
    %define MACROS_MAC 
    
%macro string 2
	%1 db %2,0
	%1Len equ $-%1-1
%endmacro

%macro pout 1
	mov ecx, %1
	mov edx, %1Len
	call print
%endmacro


%endif
