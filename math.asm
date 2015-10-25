; lab 2 ex 2 ocw.cs.pub.ro/cns
extern puts
extern printf

section .data
	helloStr: db 'Hello, World!', 0
	printFormat: db '%d', 10, 0
	printFormat_char: db '%c', 10, 0
	printFormat_string: db '%s', 10, 0

section .text
	global main

main:
	; preamble
	push ebp
	mov ebp, esp
	
	; save ecx state
	mov ecx, 0
	push ecx
loop:
	; get the saved ecx value
	pop ecx
	
	xor eax, eax
	mov al, byte [helloStr + ecx]

	inc ecx
	push ecx

	;save character value
	push eax
	
	; compare character with \0
	cmp al, 0x0
	
	; if not end of string jump to math
	jne math

	;else the string is already changed
	jmp done	

check_string:

	; print each char after 
	push eax
	push printFormat_char
	call printf

	; clean the stack - remove the printf params
	pop eax
	pop eax
	
	; get the ecx in order to know where to change the char
	pop ecx

	; change the value in memory
	; the saved ecx is already increased, pointing to the next char of the string
	; a dec op is needed
	dec ecx
	
	; get the reference to the char that needs to be changed
	lea ebx, [helloStr + ecx]
	
	; change the value in memory
	mov [ebx], al

	;restore the original ecx
	inc ecx
	push ecx

	jmp loop


math:

	pop eax ; pop the real eax

	;OLD_letter * 42 = LT42
	mov ebx, 42
	mul ebx

	;LT42 / 3 = D3
	mov ebx, 3
	xor edx, edx
	div ebx

	;D3 + 13 = A13
	add eax, 13

	;A13 % 94 = M94
	mov ebx, 94
	xor edx, edx
	div ebx
	mov eax, edx

	;M94 + 33 = NEW_letter
	add eax, 33

	jmp check_string 


done:
	; print the modified string
	push helloStr
	push printFormat_string
	call printf

	; clean the stack
	pop eax
	pop eax

	leave
	ret
