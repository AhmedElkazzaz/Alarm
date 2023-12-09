//***************************************************************
// Edited:  Steve Undy
// Changes- For Lab 8: separated InitUART out from individual calls.
// Changes- Converted to single file and reuse common code.
//          Converted to GNU ASM format.
//			Added OutHex routine.
// 09/20/2023
// 
// Edited:	Aaron Davenport
// Changes-	Converted original OutChar.s to subroutine standard
//			using R0 as input, preserve used registers above R3,
//			and formating
// 07/20/2017
// OutChar-	Output ASCII character through UART0 
// Input	 -	R0:	ASCII character to be output 
// Output -	UART0: Baud = 9600, 8-bit, No Parity, 1-Stop bit
//				   No Flow control		(16 Mhz Clock)
//*************************************************************** 

//*************************************************************** 
//	.equ Directives
// 	These directives do not allocate memory
//*************************************************************** 
//	***************** GPIO Registers *****************
	    .equ RCGCGPIO, 		0x400FE608		//	GPIO clock register
	    .equ PORTA_DEN, 	0x4000451C		//	Digital Enable
	    .equ PORTA_PCTL, 	0x4000452C		//	Alternate function select
	    .equ PORTA_AFSEL, 	0x40004420		//	Enable Alt functions
	    .equ PORTA_AMSEL, 	0x40004528		//	Enable analog
	    .equ PORTA_DR2R,	0x40004500		//	Drive current select
	
//	***************** UART Registers *****************
	    .equ RCGCUART,		0x400FE618		//	UART clock register
	    .equ UART0_DR,		0x4000C000		//	UART0 data / base address
	    .equ UART0_CTL,		0x4000C030		//	UART0 control register
	    .equ UART0_IBRD,	0x4000C024		//	Baud rate divisor Integer part
	    .equ UART0_FBRD,	0x4000C028		//	Baud rate divisor Fractional part
	    .equ UART0_LCRH,	0x4000C02C		//	UART serial parameters
	    .equ UART0_CC, 		0x4000CFC8		//	UART clock config
	    .equ UART0_FR, 		0x4000C018		//	UART status

//	***************** PLL Registers *****************
	    .equ SYSCTL_RCC2,	0x400FE070		//	PLL control
									
//***************************************************************
// OutChar Subroutine
// - send a character to UART
//
// Input: R0 - character to output
// Output:                         
//***************************************************************
        .section .text
        .syntax unified
        .thumb
		.align  2
        .global OutChar     //	Make available to other programs
OutChar:
		PUSH		{R4-R7, LR}
		LDR			R7,=UART0_DR
        BL          PutChar          	// send char in R0        
		POP			{R4-R7, LR}
		BX			LR					//	Return

//***************************************************************
// OutStr Subroutine
// - send a string to UART
//
// Input: R0 - address of null-terminated string to output
// Output:                       
//***************************************************************
        .global OutStr
OutStr:		
		PUSH		{R4-R7, LR}
		LDR			R7,=UART0_DR
        MOV         R1,R0
StrLoop:
		LDRB		R0,[R1],#1			//	Load character, post inc address
		CMP			R0,#0x0			    //	has end character been reached?
		BEQ			StrDone	            //	if so, end
        BL          PutChar          	//  else send char in R0
        B           StrLoop
StrDone:
        POP         {R4-R7, LR}
        BX          LR                  // Return

//***************************************************************
// OutHex Subroutine
// - send number in hex to UART. Leading zeros will be supressed
//
// Input: R0 - number to output in hex
// Output:                       
//***************************************************************
		.global		OutHex
OutHex:
		PUSH		{R4-R7, LR}
		LDR			R7,=UART0_DR
		MOV			R1, R0
		MOV			R2, #8				// Count
		MOV			R3,	#0				// Suppress zeros
HexLoop:
		AND 		R0, R1, #0xF0000000
		LSR			R0, R0, #28			// R0 now has upper nibble of R1

		// skip over leading zeros
		CMP			R0, #0
		IT 			NE 
		MOVNE 		R3, #1 				// non-zero => force output
		CMP			R2, #1
		IT			EQ
		MOVEQ 		R3, #1				// last nibble => force output
		CBZ			R3, NextNibble

		CMP			R0, #10
		ITE 		LT
		ADDLT		R0, R0, #48			// 0-9: Add 48 ('0'-'9')
		ADDGE 		R0, R0, #55			// A-F: Add 55 ('A'-'F')
		BL 			PutChar				// write it out
NextNibble:
		LSL 		R1, R1, #4			// shift next nibble to top
		SUBS		R2, #1 				// decrement count
		BNE			HexLoop

		POP			{R4-R7, LR}
		BX			LR					// Return

//***************************************************************
// InChar Subroutine
// - read a character from UART
//
// Input:
// Output: R0 - character read                      
//***************************************************************
		.global		InChar				//	Make available to other programs
InChar:
		PUSH		{R4-R7, LR}
		LDR			R7,=UART0_DR
		BL			GetChar
		POP			{R4-R7, LR}
		BX			LR					//	Return

//***************************************************************
// InChar_Echo Subroutine
// - read a character from UART and echo back to UART
//
// Input:
// Output: R0 - character read                                               
//***************************************************************
		.global		InChar_Echo			//	Make available to other programs
InChar_Echo:
		PUSH		{R4-R7, LR}
		LDR			R7,=UART0_DR
		BL			GetChar
		BL			PutChar
		POP			{R4-R7, LR}
		BX			LR					//	Return

/////////////////////////////////////////////////////////////////
// InitUART: set up PLL, GPIOs and UART
/////////////////////////////////////////////////////////////////
		.global		InitUART
InitUART:
		PUSH		{R4-R6}
//	***************** Enable UART clock ***************** 
		LDR			R5,=RCGCUART
		LDR			R4,[R5]
		ORR			R4,R4,#0x01			//	Set bit 0 to enable UART0 clock
		STR			R4, [R5]
		NOP								//	Let clock stabilize
		NOP
		NOP  

//	***************** Setup GPIO ***************** 
//	Enable GPIO clock to use debug USB as com port (PA0, PA1)
		LDR			R5,=RCGCGPIO
		LDR			R4,[R5]
		ORR			R4,R4,#0x01			//	Set bit 0 to enable port A clock
		STR			R4,[R5]
		NOP								//	Let clock stabilize
		NOP
		NOP 
	
// 	Make PA0, PA1 digital
		LDR			R5,=PORTA_DEN
		LDR			R4,[R5]
		ORR			R4,R4,#0x03			//	Set bits 1,0 to enable digital on PA0, PA1
		STR			R4,[R5]
	
// 	Disable analog on PA0, PA1
		LDR			R5,=PORTA_AMSEL
		LDR			R4,[R5]
		BIC			R4,R4,#0x03			//	Clear bits 1,0 to disable analog on PA0, PA1
		STR			R4,[R5]

// 	Enable alternate functions selected
		LDR			R5,=PORTA_AFSEL
		LDR			R4,[R5]
		ORR			R4,R4,#0x03			//	Set bits 1,0 to enable alt functions on PA0, PA1
		STR			R4,[R5]				//	TX LINE IS LOW UNTIL AFTER THIS CODE

//	Delay for voltage on serial to stabalize
		LDR			R4,=0x15		//	At 0x10 there are still errors, voltage not stable
del:	SUBS		R4,R4,#1		//	this needs to run once if serial is used, not every time
		BNE			del
	
// 	Select alternate function to be used (UART on PA0, PA1)
		LDR			R5,=PORTA_PCTL
		LDR			R4,[R5]
		ORR			R4,R4,#0x11			//	Set bits 4,0 to select UART Rx, Tx
		STR			R4,[R5]
	
//	***************** Setup UART ***************** 
// 	Disable UART0 while setting up
		LDR			R5,=UART0_CTL
		LDR			R4,[R5]
		BIC			R4,R4,#0x01			//	Clear bit 0 to disable UART0 while
		STR			R4,[R5]				//	Setting up
	
//	Set baud rate to 9600.  
//	Divisor = 16MHz/(16*9600)= 104.16666
		LDR			R5,=UART0_IBRD
		MOV			R4,#104				//	Set integer part to 104
		STR			R4,[R5]
	
//	0.16666*64+0.5 = 11.16666 => Integer = 11
		LDR			R5,=UART0_FBRD
		MOV			R4,#11				//	Set fractional part
		STR			R4,[R5]
	
//	Set serial parameters
		LDR			R5,=UART0_LCRH
		MOV			R4,#0x70			//	No stick parity, 8bit, FIFO enabled, 
		STR			R4,[R5]				//	One stop bit, Disable parity, Normal use
	
//  UART will use 16Mhz Precision clock
		LDR			R5,=UART0_CC
		MOV			R4,#0x5
		STR			R4,[R5]

// 	Enable UART, RX, TX
		LDR			R5,=UART0_CTL
		LDR			R4,[R5]
		MOVW		R6,#0x0301		    //	Set bits 9,8,0
		ORR			R4,R4,R6
		STR			R4,[R5]	
		NOP								//	Let UART settle
		NOP
		NOP
		POP			{R4-R6}
        BX          LR

/////////////////////////////////////////////////////////////////
// PutChar: send a single character out on UART
// R0: char to send
/////////////////////////////////////////////////////////////////
PutChar:
//	***************** Output *****************
//	Check if UART is ready to send (buffer is not full)
		LDR		 	R5,=UART0_FR		//	Load UART status register address
waitR:
		LDR			R4,[R5]
		ANDS		R4,R4,#0x20         //	Check if TXFF = 1
		BNE 		waitR	            //	If so, UART is full, so wait / check again
		STR			R0,[R7]				//	Else, send character

waitS:  LDR			R4,[R5]				
		ANDS		R4,R4,#0x08			// Check if BUSY = 0
		BEQ			waitS				// If not, wait for UART signals to catch up

// 	Check if UART is done transmitting
waitD:
		LDR			R4,[R5]
		ANDS		R4,R4,#0x08         //	Check if BUSY = 1
		BNE 		waitD	            //	If so, UART is busy, so wait / check again
        BX          LR                  // return

/////////////////////////////////////////////////////////////////
// GetChar: read a single character from UART
// R0: char received
/////////////////////////////////////////////////////////////////
GetChar:
//	***************** Input *****************
// 	Preload R4 with UART data address
		LDR			R6,=UART0_DR
		LDR			R5,=UART0_FR		//	Load UART status register address
gcheck:                               
// check for incoming character
		LDR			R4,[R5]
		ANDS		R4,R4,#0x10			//	Check if char received (RXFE is 0)
		BNE			gcheck				//	If no character, check again 
		LDR			R0,[R6]				//	Else, load received char into R0
		BX			LR					//  return      

        .end

