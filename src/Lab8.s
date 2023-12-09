//***************************************************************
// Lab8 template
// Modified by Ahmed Elkazzaz
// Date 8-12-23
// 
// Student Version Adapted from version from Sanja Manic
// Date 10-19-18
// Lab #8 - Maskable interrupts 
// Uses Monitor and PortF LED (RG&B)
//***************************************************************

//*************************************************************** 
// EQU Directives
//*************************************************************** 
		.equ SYSCTL_RCGCGPIO, 0x400FE608
// Interupt symbols
        .equ    NVIC_ST_CTRL,		0xE000E010
        .equ    NVIC_ST_RELOAD,  	0xE000E014
        .equ    NVIC_ST_CURRENT,	0xE000E018
        .equ    SHP_SYSPRI3,	    	0xE000ED20 	
        .equ    RELOAD_VALUE,		0x003C0000	// To be completed: One second at 4 MHz

// Use built-in LED on Port F. Not all may be needed
        .equ    GPIO_PORTF_BASE,        0x40025000
        .equ    GPIO_DATA,  	        0x3FC
        .equ    GPIO_DIR,   	        0x400
        .equ    GPIO_AFSEL, 	        0x420
        .equ    GPIO_PUR,   	        0x510
        .equ    GPIO_DEN,   	        0x51C
        .equ    GPIO_AMSEL, 	        0x528
        .equ    GPIO_PCTL,  	        0x52C

        .equ    SYSCTL_RCGCGPIO_R,  	0x400FE608
        .equ    PCTLCNST,           	0x0000FFF0

//***************************************************************
// This Data Section is part of the code
// It is in the read only section  so values cannot be changed.
//***************************************************************
                .section .rodata
// messgaes
Hello:          .ascii  "Hello from Lab8!\n\0"
STREQUAL:           .ascii  "#################\n The Alarm is on!\n#################\n\0"
STRNOTEQUAL:          .ascii  "the 2 Strings are not equal!\n\0"
CURRENTTime:	.ascii  "\Current Time is \0"
ALARMDISP:	.ascii  "Alarm is on  \0"
MSGTime:	.ascii  "\nSet the Clock Time (hh:mm:ss)\0"
MSGAlarm:       .ascii  "\nSet the Alarm Time (hh:mm:ss)\0"
entrT1:		.ascii	"\nEnter hours [values should be from 00 to 23] (hh): \0"
entrT2:		.ascii	"\nEnter minutes [values should be from 00 to 59] (mm): \0"
entrT3:		.ascii	"\nEnter seconds [values should be from 00 to 59](ss): \0"
entrT4:		.ascii	"\nEnter A (for AM) or P (for PM) [Values should be Capital letters]: \0"
CR:             .ascii  "\n\0"

//***************************************************************
// Data Section in READWRITE
// Values of the data in this section are initialazed at reset 
//***************************************************************
                .section .data
// memory where I store if LED should be on or off 
// this also controls interrupts, while LED is off, interrupts are on                
LedIsOn:	.byte   0x00

// memory for time and alarm. It gets updated each second
time:	        .ascii  "00:00:00 AM\n\0"

// memory where we save alarm time
alarm:	        .ascii   "00:00:00 AM\n\0"

//***************************************************************
// Program section					      
//***************************************************************
//LABEL		DIRECTIVE	VALUE			COMMENT
        .section .text
        .align 	2
        .syntax unified
        .thumb
	.global main			// Make available
main:
	LDR R1, =SYSCTL_RCGCGPIO
	LDR R0, [R1]
 	ORR R0, R0, #0x3f
	STR R0, [R1]
        nop
        nop
		nop
        // init UART and print out welcome message
	BL      InitUART
        LDR     R0,=Hello
        BL      OutStr



	LDR	R1,=MSGTime	// Message that asks for 2 digits of the minutes
	//BL	OutStr
	LDR	R0,=time	// Message that asks for 2 digits of the minutes
	BL setme
	
	//LDR R1, =time
	//STR R4, [R1]
	LDR     R0,=time
    BL      OutStr
	nop
	nop
	nop
	
	LDR	R1,=MSGAlarm	// Message that asks for 2 digits of the minutes
	LDR	R0,=alarm
	BL setme
	LDR     R0,=alarm
    BL      OutStr
	BL _Init_PortF
	BL systick_ini
	// Wait for any key to be pressed
	BL	InChar_Echo	

	//Turn Led off when any key is pressed
	LDR R1, =GPIO_PORTF_BASE
	LDR R0, [R1, GPIO_DATA]
	BIC R0, #0xFF
	ORR R0, #0x00
	STR R0, [R1, GPIO_DATA]
	

	
        
// main code goes here:
// To be completed
// - Call Port F Initialization subroutine. 
// - Calls subroutine setme prompts for inputting time and alarm data: 
//   hour, minute, second, AM/PM.
// - Initialize variable LedIsOn to 0. 
// - Call subroutine to initialize interrupts.
// - Turn on interrupts.
// - Wait for LedIsOn to be set; then turn on LED (RG&B).
// - Disable interrupts:
//   Turn off Led when any key is entered (monitor).
// About 35 lines of assembly code

// Deadloop ends program.
done:   BL      done	

//*********************************************************
// systick_ini subroutine
//*********************************************************
systick_ini:			// initialize interupts subroutine

PUSH		{R0-R1, LR}
LDR R1, =NVIC_ST_CTRL
MOV R0, #0
STR R0, [R1]
LDR R1, =NVIC_ST_RELOAD
LDR R0, =RELOAD_VALUE
STR R0, [R1]
LDR R1, =NVIC_ST_CURRENT
MOV R0, #0
STR R0, [R1]
LDR R1, =SHP_SYSPRI3
MOV R0, #0x40000000
STR R0, [R1]
LDR R1, =NVIC_ST_CTRL
MOV R0, #0x03
STR R0, [R1]
CPSIE I
//wait: WFI
//B wait
POP         {R0-R1, LR}
BX  LR  
// To be completed
// Code goes here to initialize Systick interrupts (From lab procedure)
// 16 lines of assembly code.

//*********************************************************
// setme subroutine
//*********************************************************
setme:
// Input: R0 is value of the address to store current time or alarm
//        R1 points to prompt string
// 
// this subroutine reads in and saves 6 digits of current time or alarm in
// the following format "hh:ss:mm AM" and adding new line and end of transmission
// at the end of string for displaying convenience
//
// NOTE:  This code does NOT check for valid data entry. That code is to be added.
		PUSH	{R4, LR}
                MOV     R4, R0          // save parameter
                MOV     R0, R1
		BL	OutStr		// displays message asking for current time or alarm time
		enterHour :
		LDR	R0,=entrT1	// Message that asks for 2 digits of the hour
		BL	OutStr		
		//CMP R0,#24
		//BLE correcthr		
		BL	InChar_Echo	// gets tens hour digit
		//STRB	R0,[R4],#1	// stores it and increments address
		MOV R2,R0
		MOV R5,R0
		BL	InChar_Echo	// gets units digit
		//STRB	R0,[R4],#1	// stores it and increments address
		//Check valid hour
		MOV R3,#10
		SUB R2,R2,#48
		MUL R2,R2,R3
		MOV R3,R0
		SUB R3,R3,#48
		ADD R2,R2,R3
		CMP R2,#0
		BLT enterHour
		CMP R2,#23
		BGT enterHour
		STRB	R5,[R4],#1
		STRB	R0,[R4],#1	
			
		
		LDR	R0,=':'		// stores : sign between hours and minutes
		STRB	R0,[R4],#1
		
		enterMinutes:
		LDR	R0,=entrT2	// Message that asks for 2 digits of the minutes
		BL	OutStr
		BL	InChar_Echo	// Gets tens minutes digit
		//STRB	R0,[R4],#1
		MOV R2,R0
		MOV R5,R0
		BL	InChar_Echo	// Gets units minutes digit
		//STRB	R0,[R4],#1

		//check minutes 

		MOV R3,#10
		SUB R2,R2,#48
		MUL R2,R2,R3
		MOV R3,R0
		SUB R3,R3,#48
		ADD R2,R2,R3
		CMP R2,#0
		BLT enterMinutes
		CMP R2,#59
		BGT enterMinutes
		STRB	R5,[R4],#1	
		STRB	R0,[R4],#1	
		LDR	R0 ,=':'	// Stores ":" between minutes and seconds
		STRB	R0,[R4],#1

		enterSconds:
		LDR	R0,=entrT3	// Message that asks for 2 digits of the seconds
		BL	OutStr
		BL	InChar_Echo	// Gets tens seconds digit
		//STRB	R0,[R4],#1
		MOV R2,R0
		MOV R5,R0
		BL	InChar_Echo	// Gets units seconds digit
		//STRB	R0,[R4],#1
		//checkSecond
			MOV R3,#10
		SUB R2,R2,#48
		MUL R2,R2,R3
		MOV R3,R0
		SUB R3,R3,#48
		ADD R2,R2,R3
		CMP R2,#0
		BLT enterSconds
		CMP R2,#59
		BGT enterSconds
		STRB	R5,[R4],#1	
		STRB	R0,[R4],#1	
		
		LDR	R0 ,=' '	// Stores " " after seconds
		STRB	R0,[R4],#1
		enter_AM_PM:
		LDR	R0,=entrT4	// Message that asks for AM or PM (A or P)
		BL	OutStr
        	BL	InChar_Echo     // Gets 'A' or 'P'
			CMP R0,#65
			BEQ valid_AM_PM
			CMP R0,#80
			BEQ valid_AM_PM
			B enter_AM_PM
			

		valid_AM_PM :STRB	R0,[R4],#1	// Stores that A or P
                LDR     R0,=CR
                BL      OutStr
                // 'M', newline and NULL are already initialized in line. No need to store
		POP	{R4, LR}	
		BX	LR

//*********************************************************
// clock Subroutine
// no inputs or outputs
// updates clock by 1 second (handles rollovers)
//*********************************************************
clock:
                PUSH    {R4,R5}
		LDR	R5,=time		// Puts in R5 address of the variable time
		ADD	R5,R5,#7		// Adds 7. R5 contains address of the units digit of seconds number
		LDRB	R4,[R5]
		ADD	R4,R4,#1		// Increments the units digit of seconds
		CMP	R4,#0x3A		// if it is equal to ascii character 0x3A (would display A = 10), there should be rollover
		BEQ	rosec			// if larger than 9s, rollover second
		STRB	R4,[R5]			// if there is no rollover, save updated lower digit
		B	doneCl
rosec:  	MOV	R4,#0x30		// if there was rollover, save "0"
		STRB	R4,[R5],#-1		// and point to the tens digit of seconds number
		LDRB	R4,[R5]			// Get tens digit
		ADD	R4,R4,#1		// Increment tens digit
		CMP	R4,#0x36		// Compare with "6"
		BEQ	rosec2			// If "6", rollover
		STRB	R4,[R5]			// If not, save and done
		B	doneCl
rosec2:	        MOV	R4,#0x30		// Tens digit rollover. Save "0"
		STRB	R4,[R5],#-2		// skip over tens digit and ':' sign
		LDRB	R4,[R5]			// Get units digit of minutes
		ADD	R4,R4,#1		// Increment minutes units digit
		CMP	R4,#0x3A		// Compare with "9"+1
		BEQ	romin			// if larger than 9, rollover
		STRB	R4,[R5]			// If not, save and done
		B	doneCl
romin:	        MOV	R4,#0x30		// Minutes rollover. Set to "0"
		STRB	R4,[R5],#-1		// and move to minutes tens digit
		LDRB	R4,[R5]			// Get minutes tens digit
		ADD	R4,R4,#1		// Increment tens digit	
		CMP	R4,#0x36		// Check for "6"
		BEQ	romin2			// if so, rollover
		STRB	R4,[R5]			// if not, save and done
		B	doneCl
romin2:	        MOV	R4,#0x30		// Tens of minutes rollover. Set to 0
		STRB	R4,[R5],#-2		// skip this digit and  ':' sign
		LDRB	R4,[R5],#-1		// Get hours units digit and move to hours tens digit
		ADD	R4,R4,#1		// Increment hours units digit			
		LDRB	R3,[R5]			// Get hours tens digit
		CMP	R3,#0x30		// compare this tens digit to "0"
		BNE	hour1x			// If not "0" (ie if "1") then check for hours overflow
		CMP	R4,#0x3A		// Tens is "0", so check if units is now "9" +1
		BEQ	hour10			// Units overflow, so set go to set to "10"
		STRB	R4,[R5,#1]		// no units overflow, so point to units and store that digit
		B	doneCl
hour10:         MOV	R3,#0x31		// put 10 hours
		STRB	R3,[R5],#1		// store "1" (tens digit) and increment pointer
		MOV	R4,#0x30
		STRB	R4,[R5]			// store "0" (units digit)
		B	doneCl
hour1x: 	CMP	R4,#0x33		// is hour "13"?
		BEQ	swAll			// If so, go to change to "01"
		ADD	R5,R5,#1		// Hour not "13"
		STRB	R4,[R5]			// So store hour units digit
		CMP	R4, #0x32		// Check if 12:00:00
		BEQ	swAMPM			// If so, go swap AM and PM
		B	doneCl			// If not, done
swAll:	        MOV	R3,#0x30		// Put "0" in hours tens digit
		STRB	R3,[R5],#1
		MOV	R4,#0x31		// Put "1" in hours units digit
		STRB	R4,[R5]	
		B	doneCl
swAMPM:	        LDR	R5,=time
		ADD	R5,R5,#0x09 		// pointing to A/P character
		LDRB	R4,[R5]
		RSB	R4,R4,#0x91		// Turn A to P or P to A 
		STRB	R4,[R5]			// and save it
doneCl:
                POP     {R4,R5}
		BX	LR                      // return

//*********************************************************
// almon subroutine
// checks if current time and alarm time are the same
//*********************************************************	
almon:
		//LDR	R2,=time		// puts in R2 address of current time
		//LDR	R3,=alarm		// puts in R3 address of alarm time
PUSH		{R0-R3, LR}
	LDR	R2,=time	
	LDR	R3,=alarm			
  Loop:
		LDRB		R0,[R2],#1			//	Load character, post inc address
		LDRB		R1,[R3],#1			//	Load character, post inc address
		CMP			R0,#0x0			    //	has end character been reached?
		BEQ			StrDone	            //	if so, end
        CMP			R0,R1	         	//  else send char in R0
        BEQ	         Loop


 	//LDR     R0,=STRNOTEQUAL
    B doneloop
	 
	StrDone:
	LDR R1, =GPIO_PORTF_BASE
	LDR R0, [R1, GPIO_DATA]
	BIC R0, #0xFF
	ORR R0, #0x0E
	STR R0, [R1, GPIO_DATA]
	LDR     R0,=STREQUAL
	//BX  LR  
	doneloop: 
	BL      OutStr
	POP         {R0-R3, LR}
 	BX          LR  
// To be completed...
// almon subroutine goes here
// A loop checks if strings containing current and alarm time are the same
// it checks byte of data by byte of data until either it reaches different value bytes
// or it reaches end of string  (i.e. strings are the same). 13 lines of assembly code

//*********************************************************
// cdisp subroutine
// subroutine to display current time in montior
//*********************************************************
cdisp:
	PUSH		{R0, LR}
	LDR     R0,=CURRENTTime
    BL      OutStr
	LDR     R0,=time
    BL      OutStr
	//display Alarm
	LDR     R0,=ALARMDISP
    BL      OutStr
	LDR     R0,=alarm
    BL      OutStr
	POP         {R0, LR}
 	BX          LR  
	
// To be completed
// cdisp subroutine goes here. 5 lines of assembly code

//*********************************************************
// _Init_PortF subroutine
//*********************************************************
// Make Port F 1-3 outputs, enable digital I/O, ensure alt. functions off.
// Input: none  Output: none   Modifies: R0, R1
// 32 lines of assembly code available in several examples using built-in LEDs

_Init_PortF:
.equ GPIO_PORTF_BASE, 0x40025000 // Port F Base Addr
.equ GPIO_LOCK, 0x520 // Lock Register
.equ GPIO_CR, 0x524 // Lock Register
.equ Lock_Key, 0x4C4F434B // Unlock code
// Unlock Port F
LDR R1, =GPIO_PORTF_BASE // load R1 with PortF base
LDR R0, =Lock_Key // load R0 with lock key
STR R0, [R1, GPIO_LOCK] // store key in PORTF_LOCK_R
MOV R0, #0xFF // 1 means allow access
STR R0, [R1, GPIO_CR] // enable commit for Port F
///
LDR R1, =GPIO_PORTF_BASE
LDR R0, [R1, GPIO_DIR]
BIC R0, #0xFF
ORR R0, #0x0E
STR R0, [R1, GPIO_DIR]
LDR R0, [R1, GPIO_AFSEL]
BIC R0, #0xFF
//disable ALT Function
STR R0, [R1, GPIO_AFSEL]
LDR R0, [R1, GPIO_DEN]
// enable Port F digital port
ORR R0, #0xFF
STR R0, [R1, GPIO_DEN]
//
LDR R0, [R1, GPIO_DATA]
BIC R0, #0xFF
ORR R0, #0x00
STR R0, [R1, GPIO_DATA]
BX  LR  
// To be completed
// Code to initialize PortF goes here
// 1) activate clock for Port F
// 2) no need to unlock PF		
// 3) disable analog functionality
// 4) configure as GPIO
// 5) set direction register
// 6) regular port function
// 7) enable Port F digital port
// Turn off LED (RG&B)

//*********************************************************
// SysTick ISR
//*********************************************************
// Interrupt Service routine
// This gets called every 1 s (determined by interrupt setup)
// calls clock,almon and cdisp
	.global sys_tick_handler
        .thumb_func
sys_tick_handler:
PUSH {LR}


BL clock
BL cdisp
BL almon

//LDR R0,=hi
//BL OutStr


POP {LR}
BX LR
hi: .ascii "Hello from SysTick\n\0"
.end

// To be completed
// Code goes here to: Call clock, Call almon, Call cdisp
// 6 lines of assembly code

//***************************************************************
// End of the program  section
//***************************************************************
		.end
