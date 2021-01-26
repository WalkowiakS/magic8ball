; YOUR NAME HERE
; Magic 8 ball emulator
; Calling a subroutine in 64-bit mode    (eightBall.asm)

 ;Irvine64 Prototypes
 ExitProcess proto
WriteString PROTO         ; Irvine64 library
Crlf PROTO               ; Irvine64 library
ReadInt64 proto
WriteInt64 proto
ReadString proto

 ;Add appropriate prompts:
.data
	prompt1 byte  "Pick your lucky number:  ", 0
	prompt2 byte  "What is your question?  ", 0
	prompt3 byte  "Magic 8 Ball says:  ", 0
	keyVal QWORD ?

	;magic 8 ball answers. name will correspond to random number
	zero byte "Concentrate and ask again.", 0
	one byte "It is certain.", 0
	two byte "Outlook not so good.", 0
	three byte "My sources say no.", 0
	four byte "Don't count on it.", 0

	
.code
 main PROC
	;Output message to ask for lucky number:
	mov rdx, offset prompt1
	call WriteString
	call Crlf

	;read and store number
	call ReadInt64
	mov keyVal, rax


	; Determine random number:
	mov rax,  343FDh
	imul keyVal
	add rax, 269EC3h
	ror rax, 8		;rotate out lowest digit


	; Convert number to the appropriate range:
	mov rcx, 6
	div rcx			;RDX = RAX/RCX (remainder between 0 and 5)

	mov keyVal, rdx	;store number of answer in keyVal


	;Output message to ask for question:
	mov rdx, offset prompt2
	call WriteString;why does she call WriteString but not me :'(
	call Crlf
	call ReadString						;user input does not matter and is ignored
	call Crlf
	call Crlf

	;Output message to to answer question:
	mov rdx, offset prompt3
	call WriteString

	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Determine result:
	mov rax, keyVal
	
	cmp rax, 0
	jne CASEONE		;rax != 0
	;case zero		rax == 0
	mov rdx, offset zero		;move answer into rdx to be printed
	jmp ANSFOUND				;jump over other paths

	CASEONE:
	cmp rax, 1
	jne CASETWO			;rax != 1
	;case one		rax == 1
	mov rdx, offset one
	jmp ANSFOUND

	CASETWO:
	cmp rax, 2
	jne CASETHREE		;rax != 2
	;case two		rax == 2
	mov rdx, offset two
	jmp ANSFOUND

	CASETHREE:
	cmp rax, 3
	jne CASEFOUR		;rax != 3
	;case three		rax == 3
	mov rdx, offset three
	jmp ANSFOUND

	CASEFOUR:
	mov rdx, offset four

	ANSFOUND:
	;answer is in rdx and ready to be printed


	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Output the message
	call WriteString			;Output message
	call Crlf


 mov  ecx,0				; Process return code
 call    ExitProcess

main ENDP
END

comment $

~~~~~~~~~~~~~~~~~~~~~~OUTPUT
Pick your lucky number:
78
What is your question?
Will I pass CIS 244?


Magic 8 Ball says:  It is certain.

C:\Users\swalk\Desktop\64 bit assembly\EightBall\x64\Debug\Project.exe (process 17520) exited with code 0.
Press any key to close this window . . .



Pick your lucky number:
1
What is your question?
Is my cat plotting to kill me?


Magic 8 Ball says:  Concentrate and ask again.

C:\Users\swalk\Desktop\64 bit assembly\EightBall\x64\Debug\Project.exe (process 19344) exited with code 0.
Press any key to close this window . . .



$
