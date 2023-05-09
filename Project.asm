.386
.MODEL flat, stdcall
.STACK
INCLUDE Irvine32.inc
.data 
	logIn Byte "LogIn: ",0
	accNum Byte "   Account Number: ",0
	pass Byte "   Password: ",0
	errorr  Byte "Invalid data,please retry :(",0
	welcome Byte "Welcome to our bank: ",0
	logInSuccess  Byte "Login succesfully!!",0
	inquire  Byte "   1.Balance inquiry",0
	cashWithdraw  Byte "   2.Cash WithDraw",0
	cashDeposit  Byte "   3.Cash Deposit",0
	bill  Byte "   4.Bill Payment",0
	transfer  Byte "   5.Transfer money",0
	logOut Byte "   6.LogOut: ",0
	choiceMessage  Byte "Enter a choice: ",0
	balanceMessage  Byte "   Your Balance is: ",0
	dollar  Byte "$",0
	InquireMessage  Byte "Balance inquiry: ",0
	withdrawMessage  Byte "WithDraw: ",0
	depositMessage  Byte "Deposit: ",0
	amountMessage  Byte "   Enter amount: ",0
	amount Dword ?
	currBalance  Byte "   Current Balance: ",0
	spaces  Byte "   ",0
	spacess  Byte " ",0
	space  Byte "                                               ",0
	Loadsign  Byte "|",0
	billMessage  Byte "Bill Payment: ",0
	transferMessage  Byte "Transfer money: ",0
	billNum  Byte "   Bill Number: ",0
	balance1 Dword 500
	user Dword ?
	balance2 Dword 700
.code
	main PROC 
		call loading
	main ENDP

	mainMenu proc
		call crlf
		lea edx,welcome
		call writeString
		call crlf
		lea edx,inquire
		call writeString
		call crlf
		lea edx,cashWithdraw
		call writeString
		call crlf
		lea edx,cashDeposit
		call writeString
		call crlf
		lea edx,bill
		call writeString
		call crlf
		lea edx,transfer
		call writeString
		call crlf
		lea edx,logOut
		call writeString
		call crlf
		rechoice:
			lea edx,choiceMessage
			call writeString
			call readDec
			cmp eax,1
			jne l1
			call clrscr
			call inquiryMenu

			l1:
			cmp eax,2
			jne l2
			call clrscr
			call withDrawMenu

			l2:
			cmp eax,3
			jne l3
			call clrscr
			call depositMenu

			l3:
			cmp eax,4
			jne l4
			call clrscr
			call billMenu

			l4:
			cmp eax,5
			jne l5
			call clrscr
			call transferMenu

			l5:
			cmp eax,6
			jne errorMessage
			call clrscr
			call loginScr

		errorMessage:
			lea edx,errorr
			call writeString
			call crlf
			call crlf
			jmp rechoice
	mainMenu endp

	LogInScr proc
		call clrscr
		lea edx,logIn
		call writeString

		relogin:
		call crlf
		validationUser1:
			lea edx,accNum
			call writeString
			call readDec
			cmp eax,123
			jne validationUser2
			mov user,eax
			je validationpass1

		validationpass1:
			lea edx,pass
			call writeString
			call readDec
			cmp eax,321
			jne errorMessage
			je succes

		validationUser2:
			cmp eax,456
			jne errorMessage
			mov user,eax
			je validationpass2

		validationpass2:
			lea edx,pass
			call writeString
			call readDec
			cmp eax,654
			jne errorMessage
			je succes
	
		succes:
			lea edx,logInSuccess
			call writeString
			call crlf
			call clrscr
			call MainMenu

		errorMessage:
			lea edx,errorr
			call writeString
			call crlf
			call crlf
			jmp relogin
	LogInScr endp

	inquiryMenu Proc
		lea edx,InquireMessage
		call writeString
		call crlf
		lea edx,balanceMessage
		call writeString
		cmp user,123
		jne user2
		mov eax,balance1
		call writeDec
		jmp comp
		user2:
			mov eax,balance2
			call writeDec
		comp:
			lea edx,dollar
			call writeString
			call crlf
			call crlf
			call crlf
			lea edx,spaces
			call writeString
			call WaitMsg
			call clrscr
			call MainMenu                         
	inquiryMenu endP


	withDrawMenu proc
		lea edx,withdrawMessage
		call writeString
		call crlf
		lea edx,amountMessage
		call writeString
		call readdec
		sub balance1,eax
		lea edx,currBalance
		call writeString
		mov eax,balance1
		call writeDec
		lea edx,dollar
		call writeString
		call crlf
		call crlf
		call crlf
		lea edx,spaces
		call writeString
		call WaitMsg
		call clrscr
		call MainMenu              
	withDrawMenu endp

	depositMenu proc
		lea edx,depositMessage
		call writeString
		call crlf
		lea edx,amountMessage
		call writeString
		call readdec
		add balance1,eax
		lea edx,currBalance
		call writeString
		mov eax,balance1
		call writeDec
		lea edx,dollar
		call writeString
		call crlf
		call crlf
		call crlf
		lea edx,spaces
		call writeString
		call WaitMsg
		call clrscr
		call MainMenu
	depositMenu endp

	billMenu proc
		lea edx,billMessage
		call writeString
		call crlf
		lea edx,billNum
		call writeString
		call readdec
		lea edx,amountMessage
		call writeString
		call readdec
		sub balance1,eax
		lea edx,currBalance
		call writeString
		mov eax,balance1
		call writeDec
		lea edx,dollar
		call writeString
		call crlf
		call crlf
		call crlf
		lea edx,spaces
		call writeString
		call WaitMsg
		call clrscr
		call MainMenu    
	billMenu endp

	transferMenu proc
			lea edx,transferMessage
			call writeString
			call crlf
		reEnterAccNum:
			lea edx,accNum
			call writeString
			call readdec
			cmp eax,456
			jne errorMessage
			lea edx,amountMessage
			call writeString
			call readdec
			sub balance1,eax
			add balance2,eax
			lea edx,currBalance
			call writeString
			mov eax,balance1
			call writeDec
			lea edx,dollar
			call writeString
			call crlf
			call crlf
			call crlf
			lea edx,spaces
			call writeString
			call WaitMsg
			call clrscr
			call MainMenu

		errorMessage:
			lea edx,errorr
			call writeString
			call crlf
			call crlf
			jmp reEnterAccNum

	transferMenu endp

	loading proc
		mov ecx,13
		l1:
			call crlf
			loop l1
		lea edx,space
		call writeString
		mov ecx, 30
		l:	mov eax, Green+(white*16)
			call setTextColor
			lea edx,Loadsign
			call writeString
			mov eax, Green+(Black*16)
			call setTextColor
			mov eax,170
			call delay
			loop l
			call crlf
			call crlf
			lea edx,space
			call writeString
			lea edx,spacess
			call writeString
			call waitmsg
		call logInScr
	loading endp
END main