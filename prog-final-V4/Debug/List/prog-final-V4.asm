
;CodeVisionAVR C Compiler V3.16 Evaluation
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8535
;Program type           : Application
;Clock frequency        : 16,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8535
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x025F
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _aiToutRecu=R5
	.DEF _compteurRecu=R4
	.DEF _basculeBitValeur=R6
	.DEF _basculeBitValeur_msb=R7
	.DEF __lcd_x=R9
	.DEF __lcd_y=R8
	.DEF __lcd_maxx=R11

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _itPortSerieReception
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x0:
	.DB  0x4C,0x43,0x44,0x20,0x4F,0x4B,0x0,0x43
	.DB  0x20,0x52,0x0,0x20,0x56,0x0,0x20,0x42
	.DB  0x0,0xA,0x0,0x4C,0x20,0x58,0x0,0x20
	.DB  0x59,0x0,0x4D,0x20,0x0,0x4D,0x75,0x73
	.DB  0x69,0x63,0x20,0x4F,0x46,0x46,0x0,0x4D
	.DB  0x75,0x73,0x69,0x63,0x20,0x4F,0x4E,0x0
	.DB  0x50,0x4C,0x41,0x59,0x0,0x50,0x41,0x55
	.DB  0x53,0x45,0x0,0x53,0x54,0x4F,0x50,0x0
	.DB  0x50,0x52,0x45,0x56,0x0,0x4E,0x45,0x58
	.DB  0x54,0x0,0x4D,0x75,0x73,0x69,0x63,0x20
	.DB  0x55,0x4E,0x4D,0x55,0x54,0x45,0x0,0x4D
	.DB  0x75,0x73,0x69,0x63,0x20,0x4D,0x55,0x54
	.DB  0x45,0x0,0x4D,0x4F,0x49,0x4E,0x53,0x0
	.DB  0x50,0x4C,0x55,0x53,0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0

	.CSEG
;/*
; * prog-final-V4.c
; *
; * Created: 05/05/2018 17:13:12
; * Author: m
; */
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <delay.h>
;#include <stdlib.h>
;
;#define MAXIRECU    30
;
;char tabCaracteresRecus[MAXIRECU];
;char aiToutRecu=0;
;char compteurRecu=0;
;char affValeur[20];
;
;// dans dmx.c
;void initDmx(void);
;void couleurDmx(char,char,char);
;void lyreDmx(char,char);
;
;// dans rc5.c
;void rc5CmdOn(void);
;void rc5CmdOff(void);
;void rc5CmdMute(void);
;void rc5CmdNomute(void);
;void rc5CmdSoundUp(void);
;void rc5CmdSoundDown(void);
;void rc5CmdPlay(void);
;void rc5CmdStop(void);
;void rc5CmdPause(void);
;void rc5CmdNext(void);
;void rc5CmdPrev(void);
;
;interrupt [USART_RXC] void itPortSerieReception(void) {
; 0000 0025 interrupt [12] void itPortSerieReception(void) {

	.CSEG
_itPortSerieReception:
; .FSTART _itPortSerieReception
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0026     char data;
; 0000 0027 
; 0000 0028     data=UDR;                   // recupere la donnee recue sur le port serie
	ST   -Y,R17
;	data -> R17
	IN   R17,12
; 0000 0029 
; 0000 002A         if( data=='#' ) {       // si recu le carac # alors fin du message entier
	CPI  R17,35
	BRNE _0x3
; 0000 002B             aiToutRecu=1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 002C         }
; 0000 002D 
; 0000 002E     tabCaracteresRecus[compteurRecu]=data;
_0x3:
	MOV  R30,R4
	LDI  R31,0
	SUBI R30,LOW(-_tabCaracteresRecus)
	SBCI R31,HIGH(-_tabCaracteresRecus)
	ST   Z,R17
; 0000 002F     compteurRecu++;
	INC  R4
; 0000 0030 }
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;void initLCD( void ) {
; 0000 0032 void initLCD( void ) {
_initLCD:
; .FSTART _initLCD
; 0000 0033     PORTA=0x00;         // lcd sur le port A
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0034     DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0035     lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0036     lcd_clear();
	RCALL _lcd_clear
; 0000 0037     lcd_putsf( "LCD OK" );
	__POINTW2FN _0x0,0
	RCALL _lcd_putsf
; 0000 0038 }
	RET
; .FEND
;
;void initPortSerieBluetooth( void ) {
; 0000 003A void initPortSerieBluetooth( void ) {
_initPortSerieBluetooth:
; .FSTART _initPortSerieBluetooth
; 0000 003B     UCSRB='\x90';       // autorise les interruptions en reception
	LDI  R30,LOW(144)
	OUT  0xA,R30
; 0000 003C     UCSRC='\x86';       // 8 bits de données, pas de parité, 1 bit de stop
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 003D     UBRRH='\x00';
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 003E     UBRRL='\x67';       // 0x67 = 9600 Bauds pour 16MHz
	LDI  R30,LOW(103)
	RJMP _0x20A0009
; 0000 003F }
; .FEND
;
;
;void afficheOctet( char c ) {
; 0000 0042 void afficheOctet( char c ) {
_afficheOctet:
; .FSTART _afficheOctet
; 0000 0043     int valeur;
; 0000 0044 
; 0000 0045     valeur=c;
	RCALL __SAVELOCR4
	MOV  R19,R26
;	c -> R19
;	valeur -> R16,R17
	MOV  R16,R19
	CLR  R17
; 0000 0046     itoa(valeur,affValeur);
	ST   -Y,R17
	ST   -Y,R16
	LDI  R26,LOW(_affValeur)
	LDI  R27,HIGH(_affValeur)
	RCALL _itoa
; 0000 0047     lcd_puts(affValeur);
	LDI  R26,LOW(_affValeur)
	LDI  R27,HIGH(_affValeur)
	RCALL _lcd_puts
; 0000 0048 }
	RJMP _0x20A0002
; .FEND
;
;void decodeCouleur( void ) {
; 0000 004A void decodeCouleur( void ) {
_decodeCouleur:
; .FSTART _decodeCouleur
; 0000 004B     lcd_putsf( "C R" );
	__POINTW2FN _0x0,7
	RCALL SUBOPT_0x0
; 0000 004C     afficheOctet( tabCaracteresRecus[1] );
; 0000 004D     lcd_putsf( " V" );
	__POINTW2FN _0x0,11
	RCALL SUBOPT_0x1
; 0000 004E     afficheOctet( tabCaracteresRecus[2] );
; 0000 004F     lcd_putsf( " B" );
	__POINTW2FN _0x0,14
	RCALL _lcd_putsf
; 0000 0050     afficheOctet( tabCaracteresRecus[3] );
	__GETB2MN _tabCaracteresRecus,3
	RCALL _afficheOctet
; 0000 0051     lcd_putsf( "\n" );
	RCALL SUBOPT_0x2
; 0000 0052 
; 0000 0053     couleurDmx( tabCaracteresRecus[1], tabCaracteresRecus[2], tabCaracteresRecus[3] );
	__GETB1MN _tabCaracteresRecus,2
	ST   -Y,R30
	__GETB2MN _tabCaracteresRecus,3
	RCALL _couleurDmx
; 0000 0054 
; 0000 0055     initPortSerieBluetooth();
	RJMP _0x20A000A
; 0000 0056 }
; .FEND
;
;void decodeLight( void ) {
; 0000 0058 void decodeLight( void ) {
_decodeLight:
; .FSTART _decodeLight
; 0000 0059     lcd_putsf( "L X" );
	__POINTW2FN _0x0,19
	RCALL SUBOPT_0x0
; 0000 005A     afficheOctet( tabCaracteresRecus[1] );
; 0000 005B     lcd_putsf( " Y" );
	__POINTW2FN _0x0,23
	RCALL SUBOPT_0x1
; 0000 005C     afficheOctet( tabCaracteresRecus[2] );
; 0000 005D     lcd_putsf( "\n" );
	RCALL SUBOPT_0x2
; 0000 005E 
; 0000 005F     lyreDmx( tabCaracteresRecus[1], tabCaracteresRecus[2] );
	__GETB2MN _tabCaracteresRecus,2
	RCALL _lyreDmx
; 0000 0060 
; 0000 0061     initPortSerieBluetooth();
_0x20A000A:
	RCALL _initPortSerieBluetooth
; 0000 0062 }
	RET
; .FEND
;
;void decodeMusic( void ) {
; 0000 0064 void decodeMusic( void ) {
_decodeMusic:
; .FSTART _decodeMusic
; 0000 0065     lcd_putsf( "M " );
	__POINTW2FN _0x0,26
	RCALL SUBOPT_0x0
; 0000 0066     afficheOctet( tabCaracteresRecus[1] );
; 0000 0067     lcd_putsf( " " );
	__POINTW2FN _0x0,27
	RCALL SUBOPT_0x1
; 0000 0068     afficheOctet( tabCaracteresRecus[2] );
; 0000 0069     lcd_putsf( "\n" );
	__POINTW2FN _0x0,17
	RCALL _lcd_putsf
; 0000 006A 
; 0000 006B     switch( tabCaracteresRecus[1] ) {
	__GETB1MN _tabCaracteresRecus,1
; 0000 006C         case '\0' : if( tabCaracteresRecus[2]=='\0' )  {
	CPI  R30,0
	BRNE _0x7
	__GETB1MN _tabCaracteresRecus,2
	CPI  R30,0
	BRNE _0x8
; 0000 006D                         lcd_putsf("Music OFF");
	__POINTW2FN _0x0,29
	RCALL _lcd_putsf
; 0000 006E                         rc5CmdOff();
	RCALL _rc5CmdOff
; 0000 006F         }
; 0000 0070                     else {
	RJMP _0x9
_0x8:
; 0000 0071                         lcd_putsf("Music ON");
	__POINTW2FN _0x0,39
	RCALL _lcd_putsf
; 0000 0072                         rc5CmdOn();
	RCALL _rc5CmdOn
; 0000 0073                     }
_0x9:
; 0000 0074                     break;
	RJMP _0x6
; 0000 0075         case '\1' : lcd_putsf("PLAY");
_0x7:
	CPI  R30,LOW(0x1)
	BRNE _0xA
	__POINTW2FN _0x0,48
	RCALL _lcd_putsf
; 0000 0076                     rc5CmdPlay();
	RCALL _rc5CmdPlay
; 0000 0077                     break;
	RJMP _0x6
; 0000 0078         case '\2' : lcd_putsf("PAUSE");
_0xA:
	CPI  R30,LOW(0x2)
	BRNE _0xB
	__POINTW2FN _0x0,53
	RCALL _lcd_putsf
; 0000 0079                     rc5CmdPause();
	RCALL _rc5CmdPause
; 0000 007A                     break;
	RJMP _0x6
; 0000 007B         case '\3' : lcd_putsf("STOP");
_0xB:
	CPI  R30,LOW(0x3)
	BRNE _0xC
	__POINTW2FN _0x0,59
	RCALL _lcd_putsf
; 0000 007C                     rc5CmdStop();
	RCALL _rc5CmdStop
; 0000 007D                     break;
	RJMP _0x6
; 0000 007E         case '\4' : lcd_putsf("PREV");
_0xC:
	CPI  R30,LOW(0x4)
	BRNE _0xD
	__POINTW2FN _0x0,64
	RCALL _lcd_putsf
; 0000 007F                     rc5CmdPrev();
	RCALL _rc5CmdPrev
; 0000 0080                     break;
	RJMP _0x6
; 0000 0081         case '\5' : lcd_putsf("NEXT");
_0xD:
	CPI  R30,LOW(0x5)
	BRNE _0xE
	__POINTW2FN _0x0,69
	RCALL _lcd_putsf
; 0000 0082                     rc5CmdNext();
	RCALL _rc5CmdNext
; 0000 0083                     break;
	RJMP _0x6
; 0000 0084         case '\6' : if( tabCaracteresRecus[2]=='\0' ) {
_0xE:
	CPI  R30,LOW(0x6)
	BRNE _0xF
	__GETB1MN _tabCaracteresRecus,2
	CPI  R30,0
	BRNE _0x10
; 0000 0085                         lcd_putsf("Music UNMUTE");
	__POINTW2FN _0x0,74
	RCALL _lcd_putsf
; 0000 0086                         rc5CmdNomute();
	RCALL _rc5CmdNomute
; 0000 0087         }
; 0000 0088                     else {
	RJMP _0x11
_0x10:
; 0000 0089                         lcd_putsf("Music MUTE");
	__POINTW2FN _0x0,87
	RCALL _lcd_putsf
; 0000 008A                         rc5CmdMute();
	RCALL _rc5CmdMute
; 0000 008B                     }
_0x11:
; 0000 008C                     break;
	RJMP _0x6
; 0000 008D         case '\7' : lcd_putsf("MOINS");
_0xF:
	CPI  R30,LOW(0x7)
	BRNE _0x12
	__POINTW2FN _0x0,98
	RCALL _lcd_putsf
; 0000 008E                     rc5CmdSoundDown();
	RCALL _rc5CmdSoundDown
; 0000 008F                     break;
	RJMP _0x6
; 0000 0090         case '\8' : lcd_putsf("PLUS");
_0x12:
	CPI  R30,LOW(0x8)
	BRNE _0x6
	__POINTW2FN _0x0,104
	RCALL _lcd_putsf
; 0000 0091                     rc5CmdSoundUp();
	RCALL _rc5CmdSoundUp
; 0000 0092                     break;
; 0000 0093     };
_0x6:
; 0000 0094 }
	RET
; .FEND
;
;void main(void) {
; 0000 0096 void main(void) {
_main:
; .FSTART _main
; 0000 0097 
; 0000 0098     initLCD();
	RCALL _initLCD
; 0000 0099     initDmx();
	RCALL _initDmx
; 0000 009A     initPortSerieBluetooth();
	RCALL _initPortSerieBluetooth
; 0000 009B 
; 0000 009C     #asm("sei")                             // autorise les interruptions
	sei
; 0000 009D 
; 0000 009E     while (1) {
_0x14:
; 0000 009F          if( aiToutRecu==1 ) {              // on a recu une commande depuis le smartphone ?
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0x17
; 0000 00A0             #asm("cli")                     // interdit les interruptions pour eviter le remplissage avant affichage
	cli
; 0000 00A1             lcd_clear();
	RCALL _lcd_clear
; 0000 00A2 
; 0000 00A3             switch(tabCaracteresRecus[0]) {
	LDS  R30,_tabCaracteresRecus
; 0000 00A4                 case 'C' :  decodeCouleur();
	CPI  R30,LOW(0x43)
	BRNE _0x1B
	RCALL _decodeCouleur
; 0000 00A5                             break;
	RJMP _0x1A
; 0000 00A6                 case 'L' :  decodeLight();
_0x1B:
	CPI  R30,LOW(0x4C)
	BRNE _0x1C
	RCALL _decodeLight
; 0000 00A7                             break;
	RJMP _0x1A
; 0000 00A8                 case 'M' :  decodeMusic();
_0x1C:
	CPI  R30,LOW(0x4D)
	BRNE _0x1A
	RCALL _decodeMusic
; 0000 00A9                             break;
; 0000 00AA             }
_0x1A:
; 0000 00AB 
; 0000 00AC             compteurRecu=0;                 // on recommence a remplir le tab a partir du premier
	CLR  R4
; 0000 00AD             aiToutRecu=0;
	CLR  R5
; 0000 00AE             #asm("sei")                     // re autorise les interruptions
	sei
; 0000 00AF         }
; 0000 00B0     }
_0x17:
	RJMP _0x14
; 0000 00B1 }
_0x1E:
	RJMP _0x1E
; .FEND
;// dmx.c
;// fonctions d'envoi sur le dmx
;
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;char tabEnvoiDmx[6];      // start-code + 24 canaux dmx
;
;void initDmx( void ) {
; 0001 0009 void initDmx( void ) {

	.CSEG
_initDmx:
; .FSTART _initDmx
; 0001 000A     char i;
; 0001 000B     DDRD ='\x02';
	ST   -Y,R17
;	i -> R17
	LDI  R30,LOW(2)
	OUT  0x11,R30
; 0001 000C     PORTD='\x02';                   // pour dmx etat repos
	OUT  0x12,R30
; 0001 000D     for( i=0; i<7; i++)           // raz tabEnvoiDmx
	LDI  R17,LOW(0)
_0x20004:
	CPI  R17,7
	BRSH _0x20005
; 0001 000E         tabEnvoiDmx[i]='\0';
	RCALL SUBOPT_0x3
	LDI  R26,LOW(0)
	STD  Z+0,R26
	SUBI R17,-1
	RJMP _0x20004
_0x20005:
; 0001 000F }
	RJMP _0x20A0001
; .FEND
;
;void initPortSerieDmx( void ) {
; 0001 0011 void initPortSerieDmx( void ) {
_initPortSerieDmx:
; .FSTART _initPortSerieDmx
; 0001 0012     UCSRB='\x08';           // active transmission
	LDI  R30,LOW(8)
	OUT  0xA,R30
; 0001 0013     UCSRC='\x8E';           // asynchrone 2 bits de stop 8 bits de données
	LDI  R30,LOW(142)
	OUT  0x20,R30
; 0001 0014     UBRRH='\x00';
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0001 0015     UBRRL='\x03';           // 0x03 = 250000 Bauds
	LDI  R30,LOW(3)
_0x20A0009:
	OUT  0x9,R30
; 0001 0016 }
	RET
; .FEND
;
;void debutTrameDmx( void ) {
; 0001 0018 void debutTrameDmx( void ) {
_debutTrameDmx:
; .FSTART _debutTrameDmx
; 0001 0019     UCSRB='\x00';           // disable Tx port serie pour avoir controle port D
	LDI  R30,LOW(0)
	OUT  0xA,R30
; 0001 001A     PORTD='\x00';           // bit1 portD etait a 1 -> passe a 0
	OUT  0x12,R30
; 0001 001B     delay_us(150);           // temps mini dmx break
	__DELAY_USW 600
; 0001 001C     PORTD='\x02';           // bit1 portD passe a 1
	LDI  R30,LOW(2)
	OUT  0x12,R30
; 0001 001D     delay_us(8);            // temps mini dmx mark after break
	__DELAY_USB 43
; 0001 001E                             // pret pour envoi serie
; 0001 001F }
	RET
; .FEND
;
;void envoiTrameDmx( void ) {
; 0001 0021 void envoiTrameDmx( void ) {
_envoiTrameDmx:
; .FSTART _envoiTrameDmx
; 0001 0022     char i;
; 0001 0023 
; 0001 0024     for( i=0; i<7; i++ ) {
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0x20007:
	CPI  R17,7
	BRSH _0x20008
; 0001 0025         while ( !( UCSRA & (1<<UDRE)) )     // port serie dispo pour envoi ?
_0x20009:
	SBIS 0xB,5
; 0001 0026             ;                               // non alors attend
	RJMP _0x20009
; 0001 0027         UDR = tabEnvoiDmx[i];               // oui alors charge la valeur dans port serie
	RCALL SUBOPT_0x3
	LD   R30,Z
	OUT  0xC,R30
; 0001 0028     }
	SUBI R17,-1
	RJMP _0x20007
_0x20008:
; 0001 0029 }
	RJMP _0x20A0001
; .FEND
;
;void finTrameDmx( void ) {
; 0001 002B void finTrameDmx( void ) {
_finTrameDmx:
; .FSTART _finTrameDmx
; 0001 002C     UCSRB='\x00';           // arret port serie pour envoi
	LDI  R30,LOW(0)
	OUT  0xA,R30
; 0001 002D     PORTD='\x02';           // passe le bit1 a 1 pour etat repos dmx fin de trame
	LDI  R30,LOW(2)
	OUT  0x12,R30
; 0001 002E }
	RET
; .FEND
;
;void envoiDmx( void ) {     // show must go on
; 0001 0030 void envoiDmx( void ) {
_envoiDmx:
; .FSTART _envoiDmx
; 0001 0031     debutTrameDmx();
	RCALL _debutTrameDmx
; 0001 0032     initPortSerieDmx();
	RCALL _initPortSerieDmx
; 0001 0033     envoiTrameDmx();
	RCALL _envoiTrameDmx
; 0001 0034     finTrameDmx();
	RCALL _finTrameDmx
; 0001 0035 }
	RET
; .FEND
;
;void couleurDmx( char rouge, char vert, char bleu) {
; 0001 0037 void couleurDmx( char rouge, char vert, char bleu) {
_couleurDmx:
; .FSTART _couleurDmx
; 0001 0038     tabEnvoiDmx[0]='\0';    // toujours 0 pour start code dmx
	RCALL __SAVELOCR4
	MOV  R17,R26
	LDD  R16,Y+4
	LDD  R19,Y+5
;	rouge -> R19
;	vert -> R16
;	bleu -> R17
	LDI  R30,LOW(0)
	STS  _tabEnvoiDmx,R30
; 0001 0039     tabEnvoiDmx[1]=rouge;
	__PUTBMRN _tabEnvoiDmx,1,19
; 0001 003A     tabEnvoiDmx[2]=vert;
	__PUTBMRN _tabEnvoiDmx,2,16
; 0001 003B     tabEnvoiDmx[3]=bleu;
	__PUTBMRN _tabEnvoiDmx,3,17
; 0001 003C     envoiDmx();
	RCALL _envoiDmx
; 0001 003D }
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;
;void lyreDmx( char x, char y) {
; 0001 003F void lyreDmx( char x, char y) {
_lyreDmx:
; .FSTART _lyreDmx
; 0001 0040     tabEnvoiDmx[0]='\0';    // toujours 0 pour start code dmx
	RCALL __SAVELOCR2
	MOV  R17,R26
	LDD  R16,Y+2
;	x -> R16
;	y -> R17
	LDI  R30,LOW(0)
	STS  _tabEnvoiDmx,R30
; 0001 0041     tabEnvoiDmx[4]=x;
	__PUTBMRN _tabEnvoiDmx,4,16
; 0001 0042     tabEnvoiDmx[5]=y;
	__PUTBMRN _tabEnvoiDmx,5,17
; 0001 0043     envoiDmx();
	RCALL _envoiDmx
; 0001 0044 }
	RJMP _0x20A0003
; .FEND
;
;/* rc5.c                                     */
;/* fonctions pour le protocole commande rc5  */
;
;#include <mega8535.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;
;int basculeBitValeur=0;         // compteur incremente a chaque fois - sert pour le bit bascule
;
;
;void rc5Bit1L( void ) {
; 0002 000B void rc5Bit1L( void ) {

	.CSEG
_rc5Bit1L:
; .FSTART _rc5Bit1L
; 0002 000C     char i;
; 0002 000D 
; 0002 000E //  PORTB='\0';
; 0002 000F     delay_us( 889 );
	ST   -Y,R17
;	i -> R17
	RCALL SUBOPT_0x4
; 0002 0010     for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
	LDI  R17,LOW(0)
_0x40004:
	CPI  R17,32
	BRSH _0x40005
; 0002 0011           PORTB = 1;
	RCALL SUBOPT_0x5
; 0002 0012           delay_us(7);          // 7us  mesurees
; 0002 0013           PORTB = 0;
; 0002 0014           delay_us(21);         // plus 21 us mesurees
; 0002 0015     }
	SUBI R17,-1
	RJMP _0x40004
_0x40005:
; 0002 0016 }
	RJMP _0x20A0001
; .FEND
;
;void rc5Bit0L( void ) {
; 0002 0018 void rc5Bit0L( void ) {
_rc5Bit0L:
; .FSTART _rc5Bit0L
; 0002 0019     char i;
; 0002 001A 
; 0002 001B     for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0x40007:
	CPI  R17,32
	BRSH _0x40008
; 0002 001C           PORTB = 1;
	RCALL SUBOPT_0x5
; 0002 001D           delay_us(7);          // 7us  mesurees
; 0002 001E           PORTB = 0;
; 0002 001F           delay_us(21);         // plus 21 us mesurees
; 0002 0020     }
	SUBI R17,-1
	RJMP _0x40007
_0x40008:
; 0002 0021     delay_us( 889 );
	RCALL SUBOPT_0x4
; 0002 0022 }
	RJMP _0x20A0001
; .FEND
;
;void rc5BasculeBit( void ) {
; 0002 0024 void rc5BasculeBit( void ) {
_rc5BasculeBit:
; .FSTART _rc5BasculeBit
; 0002 0025     char i;
; 0002 0026 
; 0002 0027     if( basculeBitValeur%2==0 ) {   // modulo a 2 = reste de la division par 2 : soit 0 soit 1 soit 0 soit 1 etc
	ST   -Y,R17
;	i -> R17
	MOVW R26,R6
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x40009
; 0002 0028         delay_us( 889 );
	RCALL SUBOPT_0x4
; 0002 0029         for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
	LDI  R17,LOW(0)
_0x4000B:
	CPI  R17,32
	BRSH _0x4000C
; 0002 002A            PORTB = 1;
	RCALL SUBOPT_0x5
; 0002 002B            delay_us(7);             // 7us  mesurees
; 0002 002C            PORTB = 0;
; 0002 002D            delay_us(21);            // plus 21 us mesurees
; 0002 002E         }
	SUBI R17,-1
	RJMP _0x4000B
_0x4000C:
; 0002 002F     } else {
	RJMP _0x4000D
_0x40009:
; 0002 0030         for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
	LDI  R17,LOW(0)
_0x4000F:
	CPI  R17,32
	BRSH _0x40010
; 0002 0031               PORTB = 1;
	RCALL SUBOPT_0x5
; 0002 0032               delay_us(7);          // 7us  mesurees
; 0002 0033               PORTB = 0;
; 0002 0034               delay_us(21);         // plus 21 us mesurees
; 0002 0035         }
	SUBI R17,-1
	RJMP _0x4000F
_0x40010:
; 0002 0036         delay_us( 889 );
	RCALL SUBOPT_0x4
; 0002 0037     }
_0x4000D:
; 0002 0038     basculeBitValeur++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0002 0039 }
	RJMP _0x20A0001
; .FEND
;
;
;// adresse = 0x14   pour lecteur CD
;// adresse = 0x10   pour ampli
;
;
;void rc5CmdOn( void ) {
; 0002 0040 void rc5CmdOn( void ) {
_rc5CmdOn:
; .FSTART _rc5CmdOn
; 0002 0041     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 0042     rc5Bit1L();     // bit start 2sd
; 0002 0043     rc5BasculeBit();    // bit commutation
	RCALL SUBOPT_0x7
; 0002 0044     rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en décimal)
; 0002 0045     rc5Bit0L();     // adresse bit 3
; 0002 0046     rc5Bit1L();     // adresse bit 2
; 0002 0047     rc5Bit0L();     // adresse bit 1
; 0002 0048     rc5Bit0L();     // adresse bit 0
; 0002 0049     rc5Bit0L();     // commande bit 5   commande=0x0C
; 0002 004A     rc5Bit0L();     // commande bit 4
; 0002 004B     rc5Bit1L();     // commande bit 3
; 0002 004C     rc5Bit1L();     // commande bit 2
; 0002 004D     rc5Bit0L();     // commande bit 1
	RJMP _0x20A0008
; 0002 004E     rc5Bit0L();     // commande bit 0
; 0002 004F }
; .FEND
;
;void rc5CmdOn2( void ) {
; 0002 0051 void rc5CmdOn2( void ) {
; 0002 0052     rc5Bit1L();     // bit start 1er
; 0002 0053     rc5Bit1L();     // bit start 2sd
; 0002 0054     rc5BasculeBit();    // bit commutation
; 0002 0055     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 0056     rc5Bit0L();     // adresse bit 3
; 0002 0057     rc5Bit0L();     // adresse bit 2
; 0002 0058     rc5Bit0L();     // adresse bit 1
; 0002 0059     rc5Bit0L();     // adresse bit 0
; 0002 005A     rc5Bit0L();     // commande bit 5   commande=0x0C
; 0002 005B     rc5Bit0L();     // commande bit 4
; 0002 005C     rc5Bit1L();     // commande bit 3
; 0002 005D     rc5Bit1L();     // commande bit 2
; 0002 005E     rc5Bit0L();     // commande bit 1
; 0002 005F     rc5Bit0L();     // commande bit 0
; 0002 0060 }
;
;void rc5CmdOff( void ) {
; 0002 0062 void rc5CmdOff( void ) {
_rc5CmdOff:
; .FSTART _rc5CmdOff
; 0002 0063     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 0064     rc5Bit1L();     // bit start 2sd
; 0002 0065     rc5BasculeBit();    // bit commutation
	RCALL SUBOPT_0x7
; 0002 0066     rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en décimal)
; 0002 0067     rc5Bit0L();     // adresse bit 3
; 0002 0068     rc5Bit1L();     // adresse bit 2
; 0002 0069     rc5Bit0L();     // adresse bit 1
; 0002 006A     rc5Bit0L();     // adresse bit 0
; 0002 006B     rc5Bit0L();     // commande bit 5   commande=0x0C
; 0002 006C     rc5Bit0L();     // commande bit 4
; 0002 006D     rc5Bit1L();     // commande bit 3
; 0002 006E     rc5Bit1L();     // commande bit 2
; 0002 006F     rc5Bit0L();     // commande bit 1
	RJMP _0x20A0008
; 0002 0070     rc5Bit0L();     // commande bit 0
; 0002 0071 }
; .FEND
;
;void rc5CmdOff2( void ) {
; 0002 0073 void rc5CmdOff2( void ) {
; 0002 0074     rc5Bit1L();     // bit start 1er
; 0002 0075     rc5Bit1L();     // bit start 2sd
; 0002 0076     rc5BasculeBit();    // bit commutation
; 0002 0077     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 0078     rc5Bit0L();     // adresse bit 3
; 0002 0079     rc5Bit0L();     // adresse bit 2
; 0002 007A     rc5Bit0L();     // adresse bit 1
; 0002 007B     rc5Bit0L();     // adresse bit 0
; 0002 007C     rc5Bit0L();     // commande bit 5   commande=0x0C
; 0002 007D     rc5Bit0L();     // commande bit 4
; 0002 007E     rc5Bit1L();     // commande bit 3
; 0002 007F     rc5Bit1L();     // commande bit 2
; 0002 0080     rc5Bit0L();     // commande bit 1
; 0002 0081     rc5Bit0L();     // commande bit 0
; 0002 0082 }
;
;void rc5CmdMute( void ) {
; 0002 0084 void rc5CmdMute( void ) {
_rc5CmdMute:
; .FSTART _rc5CmdMute
; 0002 0085     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 0086     rc5Bit1L();     // bit start 2sd
; 0002 0087     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0x8
; 0002 0088     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 0089     rc5Bit0L();     // adresse bit 3
; 0002 008A     rc5Bit0L();     // adresse bit 2
; 0002 008B     rc5Bit0L();     // adresse bit 1
; 0002 008C     rc5Bit0L();     // adresse bit 0
; 0002 008D     rc5Bit0L();     // commande bit 5   commande=0x0D
; 0002 008E     rc5Bit0L();     // commande bit 4
; 0002 008F     rc5Bit1L();     // commande bit 3
; 0002 0090     rc5Bit1L();     // commande bit 2
; 0002 0091     rc5Bit0L();     // commande bit 1
	RJMP _0x20A0004
; 0002 0092     rc5Bit1L();     // commande bit 0
; 0002 0093 }
; .FEND
;
;void rc5CmdNomute( void ) {
; 0002 0095 void rc5CmdNomute( void ) {
_rc5CmdNomute:
; .FSTART _rc5CmdNomute
; 0002 0096     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 0097     rc5Bit1L();     // bit start 2sd
; 0002 0098     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0x8
; 0002 0099     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 009A     rc5Bit0L();     // adresse bit 3
; 0002 009B     rc5Bit0L();     // adresse bit 2
; 0002 009C     rc5Bit0L();     // adresse bit 1
; 0002 009D     rc5Bit0L();     // adresse bit 0
; 0002 009E     rc5Bit0L();     // commande bit 5   commande=0x0D
; 0002 009F     rc5Bit0L();     // commande bit 4
; 0002 00A0     rc5Bit1L();     // commande bit 3
; 0002 00A1     rc5Bit1L();     // commande bit 2
; 0002 00A2     rc5Bit0L();     // commande bit 1
	RJMP _0x20A0004
; 0002 00A3     rc5Bit1L();     // commande bit 0
; 0002 00A4 }
; .FEND
;
;void rc5CmdSoundUp( void ) {
; 0002 00A6 void rc5CmdSoundUp( void ) {
_rc5CmdSoundUp:
; .FSTART _rc5CmdSoundUp
; 0002 00A7     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00A8     rc5Bit1L();     // bit start 2sd
; 0002 00A9     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0x9
; 0002 00AA     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 00AB     rc5Bit0L();     // adresse bit 3
; 0002 00AC     rc5Bit0L();     // adresse bit 2
; 0002 00AD     rc5Bit0L();     // adresse bit 1
; 0002 00AE     rc5Bit0L();     // adresse bit 0
; 0002 00AF     rc5Bit0L();     // commande bit 5   commande=0x10
; 0002 00B0     rc5Bit1L();     // commande bit 4
; 0002 00B1     rc5Bit0L();     // commande bit 3
	RJMP _0x20A0006
; 0002 00B2     rc5Bit0L();     // commande bit 2
; 0002 00B3     rc5Bit0L();     // commande bit 1
; 0002 00B4     rc5Bit0L();     // commande bit 0
; 0002 00B5 }
; .FEND
;
;void rc5CmdSoundDown( void ) {
; 0002 00B7 void rc5CmdSoundDown( void ) {
_rc5CmdSoundDown:
; .FSTART _rc5CmdSoundDown
; 0002 00B8     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00B9     rc5Bit1L();     // bit start 2sd
; 0002 00BA     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0x9
; 0002 00BB     rc5Bit1L();     // adresse bit 4    adresse=0x10
; 0002 00BC     rc5Bit0L();     // adresse bit 3
; 0002 00BD     rc5Bit0L();     // adresse bit 2
; 0002 00BE     rc5Bit0L();     // adresse bit 1
; 0002 00BF     rc5Bit0L();     // adresse bit 0
; 0002 00C0     rc5Bit0L();     // commande bit 5   commande=0x11
; 0002 00C1     rc5Bit1L();     // commande bit 4
; 0002 00C2     rc5Bit0L();     // commande bit 3
	RJMP _0x20A0005
; 0002 00C3     rc5Bit0L();     // commande bit 2
; 0002 00C4     rc5Bit0L();     // commande bit 1
; 0002 00C5     rc5Bit1L();     // commande bit 0
; 0002 00C6 }
; .FEND
;
;void rc5CmdPlay( void ) {
; 0002 00C8 void rc5CmdPlay( void ) {
_rc5CmdPlay:
; .FSTART _rc5CmdPlay
; 0002 00C9     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00CA     rc5Bit1L();     // bit start 2sd
; 0002 00CB     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0xA
; 0002 00CC     rc5Bit1L();     // adresse bit 4    adresse=0x14
; 0002 00CD     rc5Bit0L();     // adresse bit 3
; 0002 00CE     rc5Bit1L();     // adresse bit 2
; 0002 00CF     rc5Bit0L();     // adresse bit 1
; 0002 00D0     rc5Bit0L();     // adresse bit 0
; 0002 00D1     rc5Bit1L();     // commande bit 5   commande=0x35
; 0002 00D2     rc5Bit1L();     // commande bit 4
; 0002 00D3     rc5Bit0L();     // commande bit 3
	RCALL _rc5Bit0L
; 0002 00D4     rc5Bit1L();     // commande bit 2
	RCALL _rc5Bit1L
; 0002 00D5     rc5Bit0L();     // commande bit 1
	RJMP _0x20A0004
; 0002 00D6     rc5Bit1L();     // commande bit 0
; 0002 00D7 }
; .FEND
;
;void rc5CmdStop( void ) {
; 0002 00D9 void rc5CmdStop( void ) {
_rc5CmdStop:
; .FSTART _rc5CmdStop
; 0002 00DA     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00DB     rc5Bit1L();     // bit start 2sd
; 0002 00DC     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0xA
; 0002 00DD     rc5Bit1L();     // adresse bit 4    adresse=0x14
; 0002 00DE     rc5Bit0L();     // adresse bit 3
; 0002 00DF     rc5Bit1L();     // adresse bit 2
; 0002 00E0     rc5Bit0L();     // adresse bit 1
; 0002 00E1     rc5Bit0L();     // adresse bit 0
; 0002 00E2     rc5Bit1L();     // commande bit 5   commande=0x36
; 0002 00E3     rc5Bit1L();     // commande bit 4
; 0002 00E4     rc5Bit0L();     // commande bit 3
	RCALL _rc5Bit0L
; 0002 00E5     rc5Bit1L();     // commande bit 2
	RCALL SUBOPT_0x6
; 0002 00E6     rc5Bit1L();     // commande bit 1
; 0002 00E7     rc5Bit0L();     // commande bit 0
	RJMP _0x20A0007
; 0002 00E8 }
; .FEND
;
;void rc5CmdPause( void ) {
; 0002 00EA void rc5CmdPause( void ) {
_rc5CmdPause:
; .FSTART _rc5CmdPause
; 0002 00EB     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00EC     rc5Bit1L();     // bit start 2sd
; 0002 00ED     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0xA
; 0002 00EE     rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en décimal)
; 0002 00EF     rc5Bit0L();     // adresse bit 3
; 0002 00F0     rc5Bit1L();     // adresse bit 2
; 0002 00F1     rc5Bit0L();     // adresse bit 1
; 0002 00F2     rc5Bit0L();     // adresse bit 0
; 0002 00F3     rc5Bit1L();     // commande bit 5   commande=0x30
; 0002 00F4     rc5Bit1L();     // commande bit 4
; 0002 00F5     rc5Bit0L();     // commande bit 3
	RJMP _0x20A0006
; 0002 00F6     rc5Bit0L();     // commande bit 2
; 0002 00F7     rc5Bit0L();     // commande bit 1
; 0002 00F8     rc5Bit0L();     // commande bit 0
; 0002 00F9 }
; .FEND
;
;void rc5CmdNext(void ) {
; 0002 00FB void rc5CmdNext(void ) {
_rc5CmdNext:
; .FSTART _rc5CmdNext
; 0002 00FC     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 00FD     rc5Bit1L();     // bit start 2sd
; 0002 00FE     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0xB
; 0002 00FF     rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en décimal)
; 0002 0100     rc5Bit0L();     // adresse bit 3
; 0002 0101     rc5Bit1L();     // adresse bit 2
; 0002 0102     rc5Bit0L();     // adresse bit 1
; 0002 0103     rc5Bit0L();     // adresse bit 0
; 0002 0104     rc5Bit1L();     // commande bit 5   commande=0x20
; 0002 0105     rc5Bit0L();     // commande bit 4
; 0002 0106     rc5Bit0L();     // commande bit 3
_0x20A0006:
	RCALL _rc5Bit0L
; 0002 0107     rc5Bit0L();     // commande bit 2
	RCALL _rc5Bit0L
; 0002 0108     rc5Bit0L();     // commande bit 1
_0x20A0008:
	RCALL _rc5Bit0L
; 0002 0109     rc5Bit0L();     // commande bit 0
_0x20A0007:
	RCALL _rc5Bit0L
; 0002 010A }
	RET
; .FEND
;
;void rc5CmdPrev( void ) {
; 0002 010C void rc5CmdPrev( void ) {
_rc5CmdPrev:
; .FSTART _rc5CmdPrev
; 0002 010D     rc5Bit1L();     // bit start 1er
	RCALL SUBOPT_0x6
; 0002 010E     rc5Bit1L();     // bit start 2sd
; 0002 010F     rc5BasculeBit();     // bit commutation
	RCALL SUBOPT_0xB
; 0002 0110     rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en décimal)
; 0002 0111     rc5Bit0L();     // adresse bit 3
; 0002 0112     rc5Bit1L();     // adresse bit 2
; 0002 0113     rc5Bit0L();     // adresse bit 1
; 0002 0114     rc5Bit0L();     // adresse bit 0
; 0002 0115     rc5Bit1L();     // commande bit 5   commande=0x21
; 0002 0116     rc5Bit0L();     // commande bit 4
; 0002 0117     rc5Bit0L();     // commande bit 3
_0x20A0005:
	RCALL _rc5Bit0L
; 0002 0118     rc5Bit0L();     // commande bit 2
	RCALL _rc5Bit0L
; 0002 0119     rc5Bit0L();     // commande bit 1
_0x20A0004:
	RCALL _rc5Bit0L
; 0002 011A     rc5Bit1L();     // commande bit 0
	RCALL _rc5Bit1L
; 0002 011B }
	RET
; .FEND
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	RCALL SUBOPT_0xC
	SBI  0x1B,2
	RCALL SUBOPT_0xC
	CBI  0x1B,2
	RCALL SUBOPT_0xC
	RJMP _0x20A0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	RCALL __SAVELOCR2
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R9,R16
	MOV  R8,R17
_0x20A0003:
	RCALL __LOADLOCR2
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0xD
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0xD
	LDI  R30,LOW(0)
	MOV  R8,R30
	MOV  R9,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2000005
	CP   R9,R11
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R8
	MOV  R26,R8
	RCALL _lcd_gotoxy
	CPI  R17,10
	BRNE _0x2000007
	RJMP _0x20A0001
_0x2000007:
_0x2000004:
	INC  R9
	SBI  0x1B,0
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x20A0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	RCALL __SAVELOCR4
	MOVW R18,R26
_0x2000008:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	RJMP _0x20A0002
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	RCALL __SAVELOCR4
	MOVW R18,R26
_0x200000B:
	MOVW R30,R18
	__ADDWRN 18,19,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000D
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x200000B
_0x200000D:
_0x20A0002:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	MOV  R11,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0xE
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20A0001:
	LD   R17,Y+
	RET
; .FEND

	.CSEG
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_tabCaracteresRecus:
	.BYTE 0x1E
_affValeur:
	.BYTE 0x14
_tabEnvoiDmx:
	.BYTE 0x6
__base_y_G100:
	.BYTE 0x4
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	RCALL _lcd_putsf
	__GETB2MN _tabCaracteresRecus,1
	RJMP _afficheOctet

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	RCALL _lcd_putsf
	__GETB2MN _tabCaracteresRecus,2
	RJMP _afficheOctet

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__POINTW2FN _0x0,17
	RCALL _lcd_putsf
	__GETB1MN _tabCaracteresRecus,1
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_tabEnvoiDmx)
	SBCI R31,HIGH(-_tabEnvoiDmx)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	__DELAY_USW 3556
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(1)
	OUT  0x18,R30
	__DELAY_USB 37
	LDI  R30,LOW(0)
	OUT  0x18,R30
	__DELAY_USB 112
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x6:
	RCALL _rc5Bit1L
	RJMP _rc5Bit1L

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7:
	RCALL _rc5BasculeBit
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	RCALL _rc5BasculeBit
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9:
	RCALL _rc5BasculeBit
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RJMP _rc5Bit1L

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xA:
	RCALL _rc5BasculeBit
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xB:
	RCALL _rc5BasculeBit
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit1L
	RCALL _rc5Bit0L
	RCALL _rc5Bit0L
	RCALL _rc5Bit1L
	RJMP _rc5Bit0L

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	__DELAY_USB 27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 400
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
