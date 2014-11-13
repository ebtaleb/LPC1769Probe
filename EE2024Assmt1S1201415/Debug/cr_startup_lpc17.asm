   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 1
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.file	"cr_startup_lpc17.c"
  15              		.text
  16              	.Ltext0:
  17              		.cfi_sections	.debug_frame
  18              		.global	g_pfnVectors
  19              		.section	.isr_vector,"a",%progbits
  20              		.align	2
  23              	g_pfnVectors:
  24 0000 00000000 		.word	_vStackTop
  25 0004 00000000 		.word	ResetISR
  26 0008 00000000 		.word	NMI_Handler
  27 000c 00000000 		.word	HardFault_Handler
  28 0010 00000000 		.word	MemManage_Handler
  29 0014 00000000 		.word	BusFault_Handler
  30 0018 00000000 		.word	UsageFault_Handler
  31 001c 00000000 		.word	0
  32 0020 00000000 		.word	0
  33 0024 00000000 		.word	0
  34 0028 00000000 		.word	0
  35 002c 00000000 		.word	SVCall_Handler
  36 0030 00000000 		.word	DebugMon_Handler
  37 0034 00000000 		.word	0
  38 0038 00000000 		.word	PendSV_Handler
  39 003c 00000000 		.word	SysTick_Handler
  40 0040 00000000 		.word	WDT_IRQHandler
  41 0044 00000000 		.word	TIMER0_IRQHandler
  42 0048 00000000 		.word	TIMER1_IRQHandler
  43 004c 00000000 		.word	TIMER2_IRQHandler
  44 0050 00000000 		.word	TIMER3_IRQHandler
  45 0054 00000000 		.word	UART0_IRQHandler
  46 0058 00000000 		.word	UART1_IRQHandler
  47 005c 00000000 		.word	UART2_IRQHandler
  48 0060 00000000 		.word	UART3_IRQHandler
  49 0064 00000000 		.word	PWM1_IRQHandler
  50 0068 00000000 		.word	I2C0_IRQHandler
  51 006c 00000000 		.word	I2C1_IRQHandler
  52 0070 00000000 		.word	I2C2_IRQHandler
  53 0074 00000000 		.word	SPI_IRQHandler
  54 0078 00000000 		.word	SSP0_IRQHandler
  55 007c 00000000 		.word	SSP1_IRQHandler
  56 0080 00000000 		.word	PLL0_IRQHandler
  57 0084 00000000 		.word	RTC_IRQHandler
  58 0088 00000000 		.word	EINT0_IRQHandler
  59 008c 00000000 		.word	EINT1_IRQHandler
  60 0090 00000000 		.word	EINT2_IRQHandler
  61 0094 00000000 		.word	EINT3_IRQHandler
  62 0098 00000000 		.word	ADC_IRQHandler
  63 009c 00000000 		.word	BOD_IRQHandler
  64 00a0 00000000 		.word	USB_IRQHandler
  65 00a4 00000000 		.word	CAN_IRQHandler
  66 00a8 00000000 		.word	DMA_IRQHandler
  67 00ac 00000000 		.word	I2S_IRQHandler
  68 00b0 00000000 		.word	ENET_IRQHandler
  69 00b4 00000000 		.word	RIT_IRQHandler
  70 00b8 00000000 		.word	MCPWM_IRQHandler
  71 00bc 00000000 		.word	QEI_IRQHandler
  72 00c0 00000000 		.word	PLL1_IRQHandler
  73 00c4 00000000 		.word	USBActivity_IRQHandler
  74 00c8 00000000 		.word	CANActivity_IRQHandler
  75              		.section	.text.ResetISR,"ax",%progbits
  76              		.align	2
  77              		.global	ResetISR
  78              		.thumb
  79              		.thumb_func
  81              	ResetISR:
  82              	.LFB0:
  83              		.file 1 "../src/cr_startup_lpc17.c"
   1:../src/cr_startup_lpc17.c **** //*****************************************************************************
   2:../src/cr_startup_lpc17.c **** //   +--+       
   3:../src/cr_startup_lpc17.c **** //   | ++----+   
   4:../src/cr_startup_lpc17.c **** //   +-++    |  
   5:../src/cr_startup_lpc17.c **** //     |     |  
   6:../src/cr_startup_lpc17.c **** //   +-+--+  |   
   7:../src/cr_startup_lpc17.c **** //   | +--+--+  
   8:../src/cr_startup_lpc17.c **** //   +----+    Copyright (c) 2009-10 Code Red Technologies Ltd.
   9:../src/cr_startup_lpc17.c **** //
  10:../src/cr_startup_lpc17.c **** // Microcontroller Startup code for use with Red Suite
  11:../src/cr_startup_lpc17.c **** //
  12:../src/cr_startup_lpc17.c **** // Software License Agreement
  13:../src/cr_startup_lpc17.c **** // 
  14:../src/cr_startup_lpc17.c **** // The software is owned by Code Red Technologies and/or its suppliers, and is 
  15:../src/cr_startup_lpc17.c **** // protected under applicable copyright laws.  All rights are reserved.  Any 
  16:../src/cr_startup_lpc17.c **** // use in violation of the foregoing restrictions may subject the user to criminal 
  17:../src/cr_startup_lpc17.c **** // sanctions under applicable laws, as well as to civil liability for the breach 
  18:../src/cr_startup_lpc17.c **** // of the terms and conditions of this license.
  19:../src/cr_startup_lpc17.c **** // 
  20:../src/cr_startup_lpc17.c **** // THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
  21:../src/cr_startup_lpc17.c **** // OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
  22:../src/cr_startup_lpc17.c **** // MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
  23:../src/cr_startup_lpc17.c **** // USE OF THIS SOFTWARE FOR COMMERCIAL DEVELOPMENT AND/OR EDUCATION IS SUBJECT
  24:../src/cr_startup_lpc17.c **** // TO A CURRENT END USER LICENSE AGREEMENT (COMMERCIAL OR EDUCATIONAL) WITH
  25:../src/cr_startup_lpc17.c **** // CODE RED TECHNOLOGIES LTD. 
  26:../src/cr_startup_lpc17.c **** //
  27:../src/cr_startup_lpc17.c **** //*****************************************************************************
  28:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
  29:../src/cr_startup_lpc17.c **** #ifdef __REDLIB__
  30:../src/cr_startup_lpc17.c **** #error Redlib does not support C++
  31:../src/cr_startup_lpc17.c **** #else
  32:../src/cr_startup_lpc17.c **** //*****************************************************************************
  33:../src/cr_startup_lpc17.c **** //
  34:../src/cr_startup_lpc17.c **** // The entry point for the C++ library startup
  35:../src/cr_startup_lpc17.c **** //
  36:../src/cr_startup_lpc17.c **** //*****************************************************************************
  37:../src/cr_startup_lpc17.c **** extern "C" {
  38:../src/cr_startup_lpc17.c **** 	extern void __libc_init_array(void);
  39:../src/cr_startup_lpc17.c **** }
  40:../src/cr_startup_lpc17.c **** #endif
  41:../src/cr_startup_lpc17.c **** #endif
  42:../src/cr_startup_lpc17.c **** 
  43:../src/cr_startup_lpc17.c **** #define WEAK __attribute__ ((weak))
  44:../src/cr_startup_lpc17.c **** #define ALIAS(f) __attribute__ ((weak, alias (#f)))
  45:../src/cr_startup_lpc17.c **** 
  46:../src/cr_startup_lpc17.c **** // Code Red - if CMSIS is being used, then SystemInit() routine
  47:../src/cr_startup_lpc17.c **** // will be called by startup code rather than in application's main()
  48:../src/cr_startup_lpc17.c **** #if defined (__USE_CMSIS)
  49:../src/cr_startup_lpc17.c **** #include "system_LPC17xx.h"
  50:../src/cr_startup_lpc17.c **** #endif
  51:../src/cr_startup_lpc17.c **** 
  52:../src/cr_startup_lpc17.c **** //*****************************************************************************
  53:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
  54:../src/cr_startup_lpc17.c **** extern "C" {
  55:../src/cr_startup_lpc17.c **** #endif
  56:../src/cr_startup_lpc17.c **** 
  57:../src/cr_startup_lpc17.c **** //*****************************************************************************
  58:../src/cr_startup_lpc17.c **** //
  59:../src/cr_startup_lpc17.c **** // Forward declaration of the default handlers. These are aliased.
  60:../src/cr_startup_lpc17.c **** // When the application defines a handler (with the same name), this will 
  61:../src/cr_startup_lpc17.c **** // automatically take precedence over these weak definitions
  62:../src/cr_startup_lpc17.c **** //
  63:../src/cr_startup_lpc17.c **** //*****************************************************************************
  64:../src/cr_startup_lpc17.c ****      void ResetISR(void);
  65:../src/cr_startup_lpc17.c **** WEAK void NMI_Handler(void);
  66:../src/cr_startup_lpc17.c **** WEAK void HardFault_Handler(void);
  67:../src/cr_startup_lpc17.c **** WEAK void MemManage_Handler(void);
  68:../src/cr_startup_lpc17.c **** WEAK void BusFault_Handler(void);
  69:../src/cr_startup_lpc17.c **** WEAK void UsageFault_Handler(void);
  70:../src/cr_startup_lpc17.c **** WEAK void SVCall_Handler(void);
  71:../src/cr_startup_lpc17.c **** WEAK void DebugMon_Handler(void);
  72:../src/cr_startup_lpc17.c **** WEAK void PendSV_Handler(void);
  73:../src/cr_startup_lpc17.c **** WEAK void SysTick_Handler(void);
  74:../src/cr_startup_lpc17.c **** WEAK void IntDefaultHandler(void);
  75:../src/cr_startup_lpc17.c **** 
  76:../src/cr_startup_lpc17.c **** //*****************************************************************************
  77:../src/cr_startup_lpc17.c **** //
  78:../src/cr_startup_lpc17.c **** // Forward declaration of the specific IRQ handlers. These are aliased
  79:../src/cr_startup_lpc17.c **** // to the IntDefaultHandler, which is a 'forever' loop. When the application
  80:../src/cr_startup_lpc17.c **** // defines a handler (with the same name), this will automatically take 
  81:../src/cr_startup_lpc17.c **** // precedence over these weak definitions
  82:../src/cr_startup_lpc17.c **** //
  83:../src/cr_startup_lpc17.c **** //*****************************************************************************
  84:../src/cr_startup_lpc17.c **** void WDT_IRQHandler(void) ALIAS(IntDefaultHandler);
  85:../src/cr_startup_lpc17.c **** void TIMER0_IRQHandler(void) ALIAS(IntDefaultHandler);
  86:../src/cr_startup_lpc17.c **** void TIMER1_IRQHandler(void) ALIAS(IntDefaultHandler);
  87:../src/cr_startup_lpc17.c **** void TIMER2_IRQHandler(void) ALIAS(IntDefaultHandler);
  88:../src/cr_startup_lpc17.c **** void TIMER3_IRQHandler(void) ALIAS(IntDefaultHandler);
  89:../src/cr_startup_lpc17.c **** void UART0_IRQHandler(void) ALIAS(IntDefaultHandler);
  90:../src/cr_startup_lpc17.c **** void UART1_IRQHandler(void) ALIAS(IntDefaultHandler);
  91:../src/cr_startup_lpc17.c **** void UART2_IRQHandler(void) ALIAS(IntDefaultHandler);
  92:../src/cr_startup_lpc17.c **** void UART3_IRQHandler(void) ALIAS(IntDefaultHandler);
  93:../src/cr_startup_lpc17.c **** void PWM1_IRQHandler(void) ALIAS(IntDefaultHandler);
  94:../src/cr_startup_lpc17.c **** void I2C0_IRQHandler(void) ALIAS(IntDefaultHandler);
  95:../src/cr_startup_lpc17.c **** void I2C1_IRQHandler(void) ALIAS(IntDefaultHandler);
  96:../src/cr_startup_lpc17.c **** void I2C2_IRQHandler(void) ALIAS(IntDefaultHandler);
  97:../src/cr_startup_lpc17.c **** void SPI_IRQHandler(void) ALIAS(IntDefaultHandler);
  98:../src/cr_startup_lpc17.c **** void SSP0_IRQHandler(void) ALIAS(IntDefaultHandler);
  99:../src/cr_startup_lpc17.c **** void SSP1_IRQHandler(void) ALIAS(IntDefaultHandler);
 100:../src/cr_startup_lpc17.c **** void PLL0_IRQHandler(void) ALIAS(IntDefaultHandler);
 101:../src/cr_startup_lpc17.c **** void RTC_IRQHandler(void) ALIAS(IntDefaultHandler);
 102:../src/cr_startup_lpc17.c **** void EINT0_IRQHandler(void) ALIAS(IntDefaultHandler);
 103:../src/cr_startup_lpc17.c **** void EINT1_IRQHandler(void) ALIAS(IntDefaultHandler);
 104:../src/cr_startup_lpc17.c **** void EINT2_IRQHandler(void) ALIAS(IntDefaultHandler);
 105:../src/cr_startup_lpc17.c **** void EINT3_IRQHandler(void) ALIAS(IntDefaultHandler);
 106:../src/cr_startup_lpc17.c **** void ADC_IRQHandler(void) ALIAS(IntDefaultHandler);
 107:../src/cr_startup_lpc17.c **** void BOD_IRQHandler(void) ALIAS(IntDefaultHandler);
 108:../src/cr_startup_lpc17.c **** void USB_IRQHandler(void) ALIAS(IntDefaultHandler);
 109:../src/cr_startup_lpc17.c **** void CAN_IRQHandler(void) ALIAS(IntDefaultHandler);
 110:../src/cr_startup_lpc17.c **** void DMA_IRQHandler(void) ALIAS(IntDefaultHandler);
 111:../src/cr_startup_lpc17.c **** void I2S_IRQHandler(void) ALIAS(IntDefaultHandler);
 112:../src/cr_startup_lpc17.c **** void ENET_IRQHandler(void) ALIAS(IntDefaultHandler);
 113:../src/cr_startup_lpc17.c **** void RIT_IRQHandler(void) ALIAS(IntDefaultHandler);
 114:../src/cr_startup_lpc17.c **** void MCPWM_IRQHandler(void) ALIAS(IntDefaultHandler);
 115:../src/cr_startup_lpc17.c **** void QEI_IRQHandler(void) ALIAS(IntDefaultHandler);
 116:../src/cr_startup_lpc17.c **** void PLL1_IRQHandler(void) ALIAS(IntDefaultHandler);
 117:../src/cr_startup_lpc17.c **** void USBActivity_IRQHandler(void) ALIAS(IntDefaultHandler);
 118:../src/cr_startup_lpc17.c **** void CANActivity_IRQHandler(void) ALIAS(IntDefaultHandler);
 119:../src/cr_startup_lpc17.c **** 
 120:../src/cr_startup_lpc17.c **** //*****************************************************************************
 121:../src/cr_startup_lpc17.c **** //
 122:../src/cr_startup_lpc17.c **** // The entry point for the application.
 123:../src/cr_startup_lpc17.c **** // __main() is the entry point for Redlib based applications
 124:../src/cr_startup_lpc17.c **** // main() is the entry point for Newlib based applications
 125:../src/cr_startup_lpc17.c **** //
 126:../src/cr_startup_lpc17.c **** //*****************************************************************************
 127:../src/cr_startup_lpc17.c **** #if defined (__REDLIB__)
 128:../src/cr_startup_lpc17.c **** extern void __main(void);
 129:../src/cr_startup_lpc17.c **** #endif
 130:../src/cr_startup_lpc17.c **** extern int main(void);
 131:../src/cr_startup_lpc17.c **** //*****************************************************************************
 132:../src/cr_startup_lpc17.c **** //
 133:../src/cr_startup_lpc17.c **** // External declaration for the pointer to the stack top from the Linker Script
 134:../src/cr_startup_lpc17.c **** //
 135:../src/cr_startup_lpc17.c **** //*****************************************************************************
 136:../src/cr_startup_lpc17.c **** extern void _vStackTop(void);
 137:../src/cr_startup_lpc17.c **** 
 138:../src/cr_startup_lpc17.c **** //*****************************************************************************
 139:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
 140:../src/cr_startup_lpc17.c **** } // extern "C"
 141:../src/cr_startup_lpc17.c **** #endif
 142:../src/cr_startup_lpc17.c **** //*****************************************************************************
 143:../src/cr_startup_lpc17.c **** //
 144:../src/cr_startup_lpc17.c **** // The vector table.
 145:../src/cr_startup_lpc17.c **** // This relies on the linker script to place at correct location in memory.
 146:../src/cr_startup_lpc17.c **** //
 147:../src/cr_startup_lpc17.c **** //*****************************************************************************
 148:../src/cr_startup_lpc17.c **** extern void (* const g_pfnVectors[])(void);
 149:../src/cr_startup_lpc17.c **** __attribute__ ((section(".isr_vector")))
 150:../src/cr_startup_lpc17.c **** void (* const g_pfnVectors[])(void) = {
 151:../src/cr_startup_lpc17.c **** 	// Core Level - CM3
 152:../src/cr_startup_lpc17.c **** 	&_vStackTop, // The initial stack pointer
 153:../src/cr_startup_lpc17.c **** 	ResetISR,								// The reset handler
 154:../src/cr_startup_lpc17.c **** 	NMI_Handler,							// The NMI handler
 155:../src/cr_startup_lpc17.c **** 	HardFault_Handler,						// The hard fault handler
 156:../src/cr_startup_lpc17.c **** 	MemManage_Handler,						// The MPU fault handler
 157:../src/cr_startup_lpc17.c **** 	BusFault_Handler,						// The bus fault handler
 158:../src/cr_startup_lpc17.c **** 	UsageFault_Handler,						// The usage fault handler
 159:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 160:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 161:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 162:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 163:../src/cr_startup_lpc17.c **** 	SVCall_Handler,							// SVCall handler
 164:../src/cr_startup_lpc17.c **** 	DebugMon_Handler,						// Debug monitor handler
 165:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 166:../src/cr_startup_lpc17.c **** 	PendSV_Handler,							// The PendSV handler
 167:../src/cr_startup_lpc17.c **** 	SysTick_Handler,						// The SysTick handler
 168:../src/cr_startup_lpc17.c **** 
 169:../src/cr_startup_lpc17.c **** 	// Chip Level - LPC17
 170:../src/cr_startup_lpc17.c **** 	WDT_IRQHandler,							// 16, 0x40 - WDT
 171:../src/cr_startup_lpc17.c **** 	TIMER0_IRQHandler,						// 17, 0x44 - TIMER0
 172:../src/cr_startup_lpc17.c **** 	TIMER1_IRQHandler,						// 18, 0x48 - TIMER1
 173:../src/cr_startup_lpc17.c **** 	TIMER2_IRQHandler,						// 19, 0x4c - TIMER2
 174:../src/cr_startup_lpc17.c **** 	TIMER3_IRQHandler,						// 20, 0x50 - TIMER3
 175:../src/cr_startup_lpc17.c **** 	UART0_IRQHandler,						// 21, 0x54 - UART0
 176:../src/cr_startup_lpc17.c **** 	UART1_IRQHandler,						// 22, 0x58 - UART1
 177:../src/cr_startup_lpc17.c **** 	UART2_IRQHandler,						// 23, 0x5c - UART2
 178:../src/cr_startup_lpc17.c **** 	UART3_IRQHandler,						// 24, 0x60 - UART3
 179:../src/cr_startup_lpc17.c **** 	PWM1_IRQHandler,						// 25, 0x64 - PWM1
 180:../src/cr_startup_lpc17.c **** 	I2C0_IRQHandler,						// 26, 0x68 - I2C0
 181:../src/cr_startup_lpc17.c **** 	I2C1_IRQHandler,						// 27, 0x6c - I2C1
 182:../src/cr_startup_lpc17.c **** 	I2C2_IRQHandler,						// 28, 0x70 - I2C2
 183:../src/cr_startup_lpc17.c **** 	SPI_IRQHandler,							// 29, 0x74 - SPI
 184:../src/cr_startup_lpc17.c **** 	SSP0_IRQHandler,						// 30, 0x78 - SSP0
 185:../src/cr_startup_lpc17.c **** 	SSP1_IRQHandler,						// 31, 0x7c - SSP1
 186:../src/cr_startup_lpc17.c **** 	PLL0_IRQHandler,						// 32, 0x80 - PLL0 (Main PLL)
 187:../src/cr_startup_lpc17.c **** 	RTC_IRQHandler,							// 33, 0x84 - RTC
 188:../src/cr_startup_lpc17.c **** 	EINT0_IRQHandler,						// 34, 0x88 - EINT0
 189:../src/cr_startup_lpc17.c **** 	EINT1_IRQHandler,						// 35, 0x8c - EINT1
 190:../src/cr_startup_lpc17.c **** 	EINT2_IRQHandler,						// 36, 0x90 - EINT2
 191:../src/cr_startup_lpc17.c **** 	EINT3_IRQHandler,						// 37, 0x94 - EINT3
 192:../src/cr_startup_lpc17.c **** 	ADC_IRQHandler,							// 38, 0x98 - ADC
 193:../src/cr_startup_lpc17.c **** 	BOD_IRQHandler,							// 39, 0x9c - BOD
 194:../src/cr_startup_lpc17.c **** 	USB_IRQHandler,							// 40, 0xA0 - USB
 195:../src/cr_startup_lpc17.c **** 	CAN_IRQHandler,							// 41, 0xa4 - CAN
 196:../src/cr_startup_lpc17.c **** 	DMA_IRQHandler,							// 42, 0xa8 - GP DMA
 197:../src/cr_startup_lpc17.c **** 	I2S_IRQHandler,							// 43, 0xac - I2S
 198:../src/cr_startup_lpc17.c **** 	ENET_IRQHandler,						// 44, 0xb0 - Ethernet
 199:../src/cr_startup_lpc17.c **** 	RIT_IRQHandler,							// 45, 0xb4 - RITINT
 200:../src/cr_startup_lpc17.c **** 	MCPWM_IRQHandler,						// 46, 0xb8 - Motor Control PWM
 201:../src/cr_startup_lpc17.c **** 	QEI_IRQHandler,							// 47, 0xbc - Quadrature Encoder
 202:../src/cr_startup_lpc17.c **** 	PLL1_IRQHandler,						// 48, 0xc0 - PLL1 (USB PLL)
 203:../src/cr_startup_lpc17.c **** 	USBActivity_IRQHandler,					// 49, 0xc4 - USB Activity interrupt to wakeup
 204:../src/cr_startup_lpc17.c **** 	CANActivity_IRQHandler, 				// 50, 0xc8 - CAN Activity interrupt to wakeup
 205:../src/cr_startup_lpc17.c **** };
 206:../src/cr_startup_lpc17.c **** 
 207:../src/cr_startup_lpc17.c **** //*****************************************************************************
 208:../src/cr_startup_lpc17.c **** //
 209:../src/cr_startup_lpc17.c **** // The following are constructs created by the linker, indicating where the
 210:../src/cr_startup_lpc17.c **** // the "data" and "bss" segments reside in memory.  The initializers for the
 211:../src/cr_startup_lpc17.c **** // for the "data" segment resides immediately following the "text" segment.
 212:../src/cr_startup_lpc17.c **** //
 213:../src/cr_startup_lpc17.c **** //*****************************************************************************
 214:../src/cr_startup_lpc17.c **** extern unsigned long _etext;
 215:../src/cr_startup_lpc17.c **** extern unsigned long _data;
 216:../src/cr_startup_lpc17.c **** extern unsigned long _edata;
 217:../src/cr_startup_lpc17.c **** extern unsigned long _bss;
 218:../src/cr_startup_lpc17.c **** extern unsigned long _ebss;
 219:../src/cr_startup_lpc17.c **** 
 220:../src/cr_startup_lpc17.c **** //*****************************************************************************
 221:../src/cr_startup_lpc17.c **** // Reset entry point for your code.
 222:../src/cr_startup_lpc17.c **** // Sets up a simple runtime environment and initializes the C/C++
 223:../src/cr_startup_lpc17.c **** // library.
 224:../src/cr_startup_lpc17.c **** //
 225:../src/cr_startup_lpc17.c **** //*****************************************************************************
 226:../src/cr_startup_lpc17.c **** void
 227:../src/cr_startup_lpc17.c **** ResetISR(void) {
  84              		.loc 1 227 0
  85              		.cfi_startproc
  86              		@ args = 0, pretend = 0, frame = 8
  87              		@ frame_needed = 1, uses_anonymous_args = 0
  88 0000 80B5     		push	{r7, lr}
  89              		.cfi_def_cfa_offset 8
  90              		.cfi_offset 7, -8
  91              		.cfi_offset 14, -4
  92 0002 82B0     		sub	sp, sp, #8
  93              		.cfi_def_cfa_offset 16
  94 0004 00AF     		add	r7, sp, #0
  95              		.cfi_def_cfa_register 7
 228:../src/cr_startup_lpc17.c ****     unsigned long *pulSrc, *pulDest;
 229:../src/cr_startup_lpc17.c **** 
 230:../src/cr_startup_lpc17.c ****     //
 231:../src/cr_startup_lpc17.c ****     // Copy the data segment initializers from flash to SRAM.
 232:../src/cr_startup_lpc17.c ****     //
 233:../src/cr_startup_lpc17.c ****     pulSrc = &_etext;
  96              		.loc 1 233 0
  97 0006 104B     		ldr	r3, .L5
  98 0008 7B60     		str	r3, [r7, #4]
 234:../src/cr_startup_lpc17.c ****     for(pulDest = &_data; pulDest < &_edata; )
  99              		.loc 1 234 0
 100 000a 104B     		ldr	r3, .L5+4
 101 000c 3B60     		str	r3, [r7]
 102 000e 07E0     		b	.L2
 103              	.L3:
 235:../src/cr_startup_lpc17.c ****     {
 236:../src/cr_startup_lpc17.c ****         *pulDest++ = *pulSrc++;
 104              		.loc 1 236 0
 105 0010 3B68     		ldr	r3, [r7]
 106 0012 1A1D     		adds	r2, r3, #4
 107 0014 3A60     		str	r2, [r7]
 108 0016 7A68     		ldr	r2, [r7, #4]
 109 0018 111D     		adds	r1, r2, #4
 110 001a 7960     		str	r1, [r7, #4]
 111 001c 1268     		ldr	r2, [r2]
 112 001e 1A60     		str	r2, [r3]
 113              	.L2:
 234:../src/cr_startup_lpc17.c ****     for(pulDest = &_data; pulDest < &_edata; )
 114              		.loc 1 234 0 discriminator 1
 115 0020 3A68     		ldr	r2, [r7]
 116 0022 0B4B     		ldr	r3, .L5+8
 117 0024 9A42     		cmp	r2, r3
 118 0026 F3D3     		bcc	.L3
 237:../src/cr_startup_lpc17.c ****     }
 238:../src/cr_startup_lpc17.c **** 
 239:../src/cr_startup_lpc17.c ****     //
 240:../src/cr_startup_lpc17.c ****     // Zero fill the bss segment.  This is done with inline assembly since this
 241:../src/cr_startup_lpc17.c ****     // will clear the value of pulDest if it is not kept in a register.
 242:../src/cr_startup_lpc17.c ****     //
 243:../src/cr_startup_lpc17.c ****     __asm("    ldr     r0, =_bss\n"
 119              		.loc 1 243 0
 120              	@ 243 "../src/cr_startup_lpc17.c" 1
 121 0028 0A48     		    ldr     r0, =_bss
 122 002a 0B49     	    ldr     r1, =_ebss
 123 002c 4FF00002 	    mov     r2, #0
 124              	    .thumb_func
 125              	zero_loop:
 126 0030 8842     	        cmp     r0, r1
 127 0032 B8BF     	        it      lt
 128 0034 40F8042B 	        strlt   r2, [r0], #4
 129 0038 FFF6FAAF 	        blt     zero_loop
 130              	@ 0 "" 2
 244:../src/cr_startup_lpc17.c ****           "    ldr     r1, =_ebss\n"
 245:../src/cr_startup_lpc17.c ****           "    mov     r2, #0\n"
 246:../src/cr_startup_lpc17.c ****           "    .thumb_func\n"
 247:../src/cr_startup_lpc17.c ****           "zero_loop:\n"
 248:../src/cr_startup_lpc17.c ****           "        cmp     r0, r1\n"
 249:../src/cr_startup_lpc17.c ****           "        it      lt\n"
 250:../src/cr_startup_lpc17.c ****           "        strlt   r2, [r0], #4\n"
 251:../src/cr_startup_lpc17.c ****           "        blt     zero_loop");
 252:../src/cr_startup_lpc17.c **** 
 253:../src/cr_startup_lpc17.c **** #ifdef __USE_CMSIS
 254:../src/cr_startup_lpc17.c **** 	SystemInit();
 131              		.loc 1 254 0
 132              		.thumb
 133 003c FFF7FEFF 		bl	SystemInit
 255:../src/cr_startup_lpc17.c **** #endif
 256:../src/cr_startup_lpc17.c **** 
 257:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
 258:../src/cr_startup_lpc17.c **** 	//
 259:../src/cr_startup_lpc17.c **** 	// Call C++ library initialisation
 260:../src/cr_startup_lpc17.c **** 	//
 261:../src/cr_startup_lpc17.c **** 	__libc_init_array();
 262:../src/cr_startup_lpc17.c **** #endif
 263:../src/cr_startup_lpc17.c **** 
 264:../src/cr_startup_lpc17.c **** #if defined (__REDLIB__)
 265:../src/cr_startup_lpc17.c **** 	// Call the Redlib library, which in turn calls main()
 266:../src/cr_startup_lpc17.c **** 	__main() ;
 134              		.loc 1 266 0
 135 0040 FFF7FEFF 		bl	__main
 136              	.L4:
 267:../src/cr_startup_lpc17.c **** #else
 268:../src/cr_startup_lpc17.c **** 	main();
 269:../src/cr_startup_lpc17.c **** #endif
 270:../src/cr_startup_lpc17.c **** 
 271:../src/cr_startup_lpc17.c **** 	//
 272:../src/cr_startup_lpc17.c **** 	// main() shouldn't return, but if it does, we'll just enter an infinite loop 
 273:../src/cr_startup_lpc17.c **** 	//
 274:../src/cr_startup_lpc17.c **** 	while (1) {
 275:../src/cr_startup_lpc17.c **** 		;
 276:../src/cr_startup_lpc17.c **** 	}
 137              		.loc 1 276 0 discriminator 1
 138 0044 FEE7     		b	.L4
 139              	.L6:
 140 0046 00BF     		.align	2
 141              	.L5:
 142 0048 00000000 		.word	_etext
 143 004c 00000000 		.word	_data
 144 0050 00000000 		.word	_edata
 145              		.cfi_endproc
 146              	.LFE0:
 148              		.section	.text.NMI_Handler,"ax",%progbits
 149              		.align	2
 150              		.weak	NMI_Handler
 151              		.thumb
 152              		.thumb_func
 154              	NMI_Handler:
 155              	.LFB1:
 277:../src/cr_startup_lpc17.c **** }
 278:../src/cr_startup_lpc17.c **** 
 279:../src/cr_startup_lpc17.c **** //*****************************************************************************
 280:../src/cr_startup_lpc17.c **** //
 281:../src/cr_startup_lpc17.c **** // This is the code that gets called when the processor receives a NMI.  This
 282:../src/cr_startup_lpc17.c **** // simply enters an infinite loop, preserving the system state for examination
 283:../src/cr_startup_lpc17.c **** // by a debugger.
 284:../src/cr_startup_lpc17.c **** //
 285:../src/cr_startup_lpc17.c **** //*****************************************************************************
 286:../src/cr_startup_lpc17.c **** void NMI_Handler(void)
 287:../src/cr_startup_lpc17.c **** {
 156              		.loc 1 287 0
 157              		.cfi_startproc
 158              		@ args = 0, pretend = 0, frame = 0
 159              		@ frame_needed = 1, uses_anonymous_args = 0
 160              		@ link register save eliminated.
 161 0000 80B4     		push	{r7}
 162              		.cfi_def_cfa_offset 4
 163              		.cfi_offset 7, -4
 164 0002 00AF     		add	r7, sp, #0
 165              		.cfi_def_cfa_register 7
 166              	.L8:
 288:../src/cr_startup_lpc17.c ****     while(1)
 289:../src/cr_startup_lpc17.c ****     {
 290:../src/cr_startup_lpc17.c ****     }
 167              		.loc 1 290 0 discriminator 1
 168 0004 FEE7     		b	.L8
 169              		.cfi_endproc
 170              	.LFE1:
 172 0006 00BF     		.section	.text.HardFault_Handler,"ax",%progbits
 173              		.align	2
 174              		.weak	HardFault_Handler
 175              		.thumb
 176              		.thumb_func
 178              	HardFault_Handler:
 179              	.LFB2:
 291:../src/cr_startup_lpc17.c **** }
 292:../src/cr_startup_lpc17.c **** 
 293:../src/cr_startup_lpc17.c **** void HardFault_Handler(void)
 294:../src/cr_startup_lpc17.c **** {
 180              		.loc 1 294 0
 181              		.cfi_startproc
 182              		@ args = 0, pretend = 0, frame = 0
 183              		@ frame_needed = 1, uses_anonymous_args = 0
 184              		@ link register save eliminated.
 185 0000 80B4     		push	{r7}
 186              		.cfi_def_cfa_offset 4
 187              		.cfi_offset 7, -4
 188 0002 00AF     		add	r7, sp, #0
 189              		.cfi_def_cfa_register 7
 190              	.L10:
 295:../src/cr_startup_lpc17.c ****     while(1)
 296:../src/cr_startup_lpc17.c ****     {
 297:../src/cr_startup_lpc17.c ****     }
 191              		.loc 1 297 0 discriminator 1
 192 0004 FEE7     		b	.L10
 193              		.cfi_endproc
 194              	.LFE2:
 196 0006 00BF     		.section	.text.MemManage_Handler,"ax",%progbits
 197              		.align	2
 198              		.weak	MemManage_Handler
 199              		.thumb
 200              		.thumb_func
 202              	MemManage_Handler:
 203              	.LFB3:
 298:../src/cr_startup_lpc17.c **** }
 299:../src/cr_startup_lpc17.c **** 
 300:../src/cr_startup_lpc17.c **** void MemManage_Handler(void)
 301:../src/cr_startup_lpc17.c **** {
 204              		.loc 1 301 0
 205              		.cfi_startproc
 206              		@ args = 0, pretend = 0, frame = 0
 207              		@ frame_needed = 1, uses_anonymous_args = 0
 208              		@ link register save eliminated.
 209 0000 80B4     		push	{r7}
 210              		.cfi_def_cfa_offset 4
 211              		.cfi_offset 7, -4
 212 0002 00AF     		add	r7, sp, #0
 213              		.cfi_def_cfa_register 7
 214              	.L12:
 302:../src/cr_startup_lpc17.c ****     while(1)
 303:../src/cr_startup_lpc17.c ****     {
 304:../src/cr_startup_lpc17.c ****     }
 215              		.loc 1 304 0 discriminator 1
 216 0004 FEE7     		b	.L12
 217              		.cfi_endproc
 218              	.LFE3:
 220 0006 00BF     		.section	.text.BusFault_Handler,"ax",%progbits
 221              		.align	2
 222              		.weak	BusFault_Handler
 223              		.thumb
 224              		.thumb_func
 226              	BusFault_Handler:
 227              	.LFB4:
 305:../src/cr_startup_lpc17.c **** }
 306:../src/cr_startup_lpc17.c **** 
 307:../src/cr_startup_lpc17.c **** void BusFault_Handler(void)
 308:../src/cr_startup_lpc17.c **** {
 228              		.loc 1 308 0
 229              		.cfi_startproc
 230              		@ args = 0, pretend = 0, frame = 0
 231              		@ frame_needed = 1, uses_anonymous_args = 0
 232              		@ link register save eliminated.
 233 0000 80B4     		push	{r7}
 234              		.cfi_def_cfa_offset 4
 235              		.cfi_offset 7, -4
 236 0002 00AF     		add	r7, sp, #0
 237              		.cfi_def_cfa_register 7
 238              	.L14:
 309:../src/cr_startup_lpc17.c ****     while(1)
 310:../src/cr_startup_lpc17.c ****     {
 311:../src/cr_startup_lpc17.c ****     }
 239              		.loc 1 311 0 discriminator 1
 240 0004 FEE7     		b	.L14
 241              		.cfi_endproc
 242              	.LFE4:
 244 0006 00BF     		.section	.text.UsageFault_Handler,"ax",%progbits
 245              		.align	2
 246              		.weak	UsageFault_Handler
 247              		.thumb
 248              		.thumb_func
 250              	UsageFault_Handler:
 251              	.LFB5:
 312:../src/cr_startup_lpc17.c **** }
 313:../src/cr_startup_lpc17.c **** 
 314:../src/cr_startup_lpc17.c **** void UsageFault_Handler(void)
 315:../src/cr_startup_lpc17.c **** {
 252              		.loc 1 315 0
 253              		.cfi_startproc
 254              		@ args = 0, pretend = 0, frame = 0
 255              		@ frame_needed = 1, uses_anonymous_args = 0
 256              		@ link register save eliminated.
 257 0000 80B4     		push	{r7}
 258              		.cfi_def_cfa_offset 4
 259              		.cfi_offset 7, -4
 260 0002 00AF     		add	r7, sp, #0
 261              		.cfi_def_cfa_register 7
 262              	.L16:
 316:../src/cr_startup_lpc17.c ****     while(1)
 317:../src/cr_startup_lpc17.c ****     {
 318:../src/cr_startup_lpc17.c ****     }
 263              		.loc 1 318 0 discriminator 1
 264 0004 FEE7     		b	.L16
 265              		.cfi_endproc
 266              	.LFE5:
 268 0006 00BF     		.section	.text.SVCall_Handler,"ax",%progbits
 269              		.align	2
 270              		.weak	SVCall_Handler
 271              		.thumb
 272              		.thumb_func
 274              	SVCall_Handler:
 275              	.LFB6:
 319:../src/cr_startup_lpc17.c **** }
 320:../src/cr_startup_lpc17.c **** 
 321:../src/cr_startup_lpc17.c **** void SVCall_Handler(void)
 322:../src/cr_startup_lpc17.c **** {
 276              		.loc 1 322 0
 277              		.cfi_startproc
 278              		@ args = 0, pretend = 0, frame = 0
 279              		@ frame_needed = 1, uses_anonymous_args = 0
 280              		@ link register save eliminated.
 281 0000 80B4     		push	{r7}
 282              		.cfi_def_cfa_offset 4
 283              		.cfi_offset 7, -4
 284 0002 00AF     		add	r7, sp, #0
 285              		.cfi_def_cfa_register 7
 286              	.L18:
 323:../src/cr_startup_lpc17.c ****     while(1)
 324:../src/cr_startup_lpc17.c ****     {
 325:../src/cr_startup_lpc17.c ****     }
 287              		.loc 1 325 0 discriminator 1
 288 0004 FEE7     		b	.L18
 289              		.cfi_endproc
 290              	.LFE6:
 292 0006 00BF     		.section	.text.DebugMon_Handler,"ax",%progbits
 293              		.align	2
 294              		.weak	DebugMon_Handler
 295              		.thumb
 296              		.thumb_func
 298              	DebugMon_Handler:
 299              	.LFB7:
 326:../src/cr_startup_lpc17.c **** }
 327:../src/cr_startup_lpc17.c **** 
 328:../src/cr_startup_lpc17.c **** void DebugMon_Handler(void)
 329:../src/cr_startup_lpc17.c **** {
 300              		.loc 1 329 0
 301              		.cfi_startproc
 302              		@ args = 0, pretend = 0, frame = 0
 303              		@ frame_needed = 1, uses_anonymous_args = 0
 304              		@ link register save eliminated.
 305 0000 80B4     		push	{r7}
 306              		.cfi_def_cfa_offset 4
 307              		.cfi_offset 7, -4
 308 0002 00AF     		add	r7, sp, #0
 309              		.cfi_def_cfa_register 7
 310              	.L20:
 330:../src/cr_startup_lpc17.c ****     while(1)
 331:../src/cr_startup_lpc17.c ****     {
 332:../src/cr_startup_lpc17.c ****     }
 311              		.loc 1 332 0 discriminator 1
 312 0004 FEE7     		b	.L20
 313              		.cfi_endproc
 314              	.LFE7:
 316 0006 00BF     		.section	.text.PendSV_Handler,"ax",%progbits
 317              		.align	2
 318              		.weak	PendSV_Handler
 319              		.thumb
 320              		.thumb_func
 322              	PendSV_Handler:
 323              	.LFB8:
 333:../src/cr_startup_lpc17.c **** }
 334:../src/cr_startup_lpc17.c **** 
 335:../src/cr_startup_lpc17.c **** void PendSV_Handler(void)
 336:../src/cr_startup_lpc17.c **** {
 324              		.loc 1 336 0
 325              		.cfi_startproc
 326              		@ args = 0, pretend = 0, frame = 0
 327              		@ frame_needed = 1, uses_anonymous_args = 0
 328              		@ link register save eliminated.
 329 0000 80B4     		push	{r7}
 330              		.cfi_def_cfa_offset 4
 331              		.cfi_offset 7, -4
 332 0002 00AF     		add	r7, sp, #0
 333              		.cfi_def_cfa_register 7
 334              	.L22:
 337:../src/cr_startup_lpc17.c ****     while(1)
 338:../src/cr_startup_lpc17.c ****     {
 339:../src/cr_startup_lpc17.c ****     }
 335              		.loc 1 339 0 discriminator 1
 336 0004 FEE7     		b	.L22
 337              		.cfi_endproc
 338              	.LFE8:
 340 0006 00BF     		.section	.text.SysTick_Handler,"ax",%progbits
 341              		.align	2
 342              		.weak	SysTick_Handler
 343              		.thumb
 344              		.thumb_func
 346              	SysTick_Handler:
 347              	.LFB9:
 340:../src/cr_startup_lpc17.c **** }
 341:../src/cr_startup_lpc17.c **** 
 342:../src/cr_startup_lpc17.c **** void SysTick_Handler(void) 
 343:../src/cr_startup_lpc17.c **** {
 348              		.loc 1 343 0
 349              		.cfi_startproc
 350              		@ args = 0, pretend = 0, frame = 0
 351              		@ frame_needed = 1, uses_anonymous_args = 0
 352              		@ link register save eliminated.
 353 0000 80B4     		push	{r7}
 354              		.cfi_def_cfa_offset 4
 355              		.cfi_offset 7, -4
 356 0002 00AF     		add	r7, sp, #0
 357              		.cfi_def_cfa_register 7
 358              	.L24:
 344:../src/cr_startup_lpc17.c ****     while(1)
 345:../src/cr_startup_lpc17.c ****     {
 346:../src/cr_startup_lpc17.c ****     }
 359              		.loc 1 346 0 discriminator 1
 360 0004 FEE7     		b	.L24
 361              		.cfi_endproc
 362              	.LFE9:
 364 0006 00BF     		.section	.text.IntDefaultHandler,"ax",%progbits
 365              		.align	2
 366              		.weak	IntDefaultHandler
 367              		.thumb
 368              		.thumb_func
 370              	IntDefaultHandler:
 371              	.LFB10:
 347:../src/cr_startup_lpc17.c **** }
 348:../src/cr_startup_lpc17.c **** 
 349:../src/cr_startup_lpc17.c **** 
 350:../src/cr_startup_lpc17.c **** //*****************************************************************************
 351:../src/cr_startup_lpc17.c **** //
 352:../src/cr_startup_lpc17.c **** // Processor ends up here if an unexpected interrupt occurs or a handler
 353:../src/cr_startup_lpc17.c **** // is not present in the application code.
 354:../src/cr_startup_lpc17.c **** //
 355:../src/cr_startup_lpc17.c **** //*****************************************************************************
 356:../src/cr_startup_lpc17.c **** void IntDefaultHandler(void)
 357:../src/cr_startup_lpc17.c **** {
 372              		.loc 1 357 0
 373              		.cfi_startproc
 374              		@ args = 0, pretend = 0, frame = 0
 375              		@ frame_needed = 1, uses_anonymous_args = 0
 376              		@ link register save eliminated.
 377 0000 80B4     		push	{r7}
 378              		.cfi_def_cfa_offset 4
 379              		.cfi_offset 7, -4
 380 0002 00AF     		add	r7, sp, #0
 381              		.cfi_def_cfa_register 7
 382              	.L26:
 358:../src/cr_startup_lpc17.c ****     //
 359:../src/cr_startup_lpc17.c ****     // Go into an infinite loop.
 360:../src/cr_startup_lpc17.c ****     //
 361:../src/cr_startup_lpc17.c ****     while(1)
 362:../src/cr_startup_lpc17.c ****     {
 363:../src/cr_startup_lpc17.c ****     }
 383              		.loc 1 363 0 discriminator 1
 384 0004 FEE7     		b	.L26
 385              		.cfi_endproc
 386              	.LFE10:
 388              		.weak	WDT_IRQHandler
 389              		.thumb_set WDT_IRQHandler,IntDefaultHandler
 390              		.weak	TIMER0_IRQHandler
 391              		.thumb_set TIMER0_IRQHandler,IntDefaultHandler
 392              		.weak	TIMER1_IRQHandler
 393              		.thumb_set TIMER1_IRQHandler,IntDefaultHandler
 394              		.weak	TIMER2_IRQHandler
 395              		.thumb_set TIMER2_IRQHandler,IntDefaultHandler
 396              		.weak	TIMER3_IRQHandler
 397              		.thumb_set TIMER3_IRQHandler,IntDefaultHandler
 398              		.weak	UART0_IRQHandler
 399              		.thumb_set UART0_IRQHandler,IntDefaultHandler
 400              		.weak	UART1_IRQHandler
 401              		.thumb_set UART1_IRQHandler,IntDefaultHandler
 402              		.weak	UART2_IRQHandler
 403              		.thumb_set UART2_IRQHandler,IntDefaultHandler
 404              		.weak	UART3_IRQHandler
 405              		.thumb_set UART3_IRQHandler,IntDefaultHandler
 406              		.weak	PWM1_IRQHandler
 407              		.thumb_set PWM1_IRQHandler,IntDefaultHandler
 408              		.weak	I2C0_IRQHandler
 409              		.thumb_set I2C0_IRQHandler,IntDefaultHandler
 410              		.weak	I2C1_IRQHandler
 411              		.thumb_set I2C1_IRQHandler,IntDefaultHandler
 412              		.weak	I2C2_IRQHandler
 413              		.thumb_set I2C2_IRQHandler,IntDefaultHandler
 414              		.weak	SPI_IRQHandler
 415              		.thumb_set SPI_IRQHandler,IntDefaultHandler
 416              		.weak	SSP0_IRQHandler
 417              		.thumb_set SSP0_IRQHandler,IntDefaultHandler
 418              		.weak	SSP1_IRQHandler
 419              		.thumb_set SSP1_IRQHandler,IntDefaultHandler
 420              		.weak	PLL0_IRQHandler
 421              		.thumb_set PLL0_IRQHandler,IntDefaultHandler
 422              		.weak	RTC_IRQHandler
 423              		.thumb_set RTC_IRQHandler,IntDefaultHandler
 424              		.weak	EINT0_IRQHandler
 425              		.thumb_set EINT0_IRQHandler,IntDefaultHandler
 426              		.weak	EINT1_IRQHandler
 427              		.thumb_set EINT1_IRQHandler,IntDefaultHandler
 428              		.weak	EINT2_IRQHandler
 429              		.thumb_set EINT2_IRQHandler,IntDefaultHandler
 430              		.weak	EINT3_IRQHandler
 431              		.thumb_set EINT3_IRQHandler,IntDefaultHandler
 432              		.weak	ADC_IRQHandler
 433              		.thumb_set ADC_IRQHandler,IntDefaultHandler
 434              		.weak	BOD_IRQHandler
 435              		.thumb_set BOD_IRQHandler,IntDefaultHandler
 436              		.weak	USB_IRQHandler
 437              		.thumb_set USB_IRQHandler,IntDefaultHandler
 438              		.weak	CAN_IRQHandler
 439              		.thumb_set CAN_IRQHandler,IntDefaultHandler
 440              		.weak	DMA_IRQHandler
 441              		.thumb_set DMA_IRQHandler,IntDefaultHandler
 442              		.weak	I2S_IRQHandler
 443              		.thumb_set I2S_IRQHandler,IntDefaultHandler
 444              		.weak	ENET_IRQHandler
 445              		.thumb_set ENET_IRQHandler,IntDefaultHandler
 446              		.weak	RIT_IRQHandler
 447              		.thumb_set RIT_IRQHandler,IntDefaultHandler
 448              		.weak	MCPWM_IRQHandler
 449              		.thumb_set MCPWM_IRQHandler,IntDefaultHandler
 450              		.weak	QEI_IRQHandler
 451              		.thumb_set QEI_IRQHandler,IntDefaultHandler
 452              		.weak	PLL1_IRQHandler
 453              		.thumb_set PLL1_IRQHandler,IntDefaultHandler
 454              		.weak	USBActivity_IRQHandler
 455              		.thumb_set USBActivity_IRQHandler,IntDefaultHandler
 456              		.weak	CANActivity_IRQHandler
 457              		.thumb_set CANActivity_IRQHandler,IntDefaultHandler
 458 0006 00BF     		.text
 459              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 cr_startup_lpc17.c
     /tmp/ccMyvXfg.s:23     .isr_vector:00000000 g_pfnVectors
     /tmp/ccMyvXfg.s:20     .isr_vector:00000000 $d
     /tmp/ccMyvXfg.s:81     .text.ResetISR:00000000 ResetISR
     /tmp/ccMyvXfg.s:154    .text.NMI_Handler:00000000 NMI_Handler
     /tmp/ccMyvXfg.s:178    .text.HardFault_Handler:00000000 HardFault_Handler
     /tmp/ccMyvXfg.s:202    .text.MemManage_Handler:00000000 MemManage_Handler
     /tmp/ccMyvXfg.s:226    .text.BusFault_Handler:00000000 BusFault_Handler
     /tmp/ccMyvXfg.s:250    .text.UsageFault_Handler:00000000 UsageFault_Handler
     /tmp/ccMyvXfg.s:274    .text.SVCall_Handler:00000000 SVCall_Handler
     /tmp/ccMyvXfg.s:298    .text.DebugMon_Handler:00000000 DebugMon_Handler
     /tmp/ccMyvXfg.s:322    .text.PendSV_Handler:00000000 PendSV_Handler
     /tmp/ccMyvXfg.s:346    .text.SysTick_Handler:00000000 SysTick_Handler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 WDT_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 TIMER0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 TIMER1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 TIMER2_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 TIMER3_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 UART0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 UART1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 UART2_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 UART3_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 PWM1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 I2C0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 I2C1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 I2C2_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 SPI_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 SSP0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 SSP1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 PLL0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 RTC_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 EINT0_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 EINT1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 EINT2_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 EINT3_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 ADC_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 BOD_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 USB_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 CAN_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 DMA_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 I2S_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 ENET_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 RIT_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 MCPWM_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 QEI_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 PLL1_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 USBActivity_IRQHandler
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 CANActivity_IRQHandler
     /tmp/ccMyvXfg.s:76     .text.ResetISR:00000000 $t
     /tmp/ccMyvXfg.s:125    .text.ResetISR:00000030 zero_loop
     /tmp/ccMyvXfg.s:142    .text.ResetISR:00000048 $d
     /tmp/ccMyvXfg.s:149    .text.NMI_Handler:00000000 $t
     /tmp/ccMyvXfg.s:173    .text.HardFault_Handler:00000000 $t
     /tmp/ccMyvXfg.s:197    .text.MemManage_Handler:00000000 $t
     /tmp/ccMyvXfg.s:221    .text.BusFault_Handler:00000000 $t
     /tmp/ccMyvXfg.s:245    .text.UsageFault_Handler:00000000 $t
     /tmp/ccMyvXfg.s:269    .text.SVCall_Handler:00000000 $t
     /tmp/ccMyvXfg.s:293    .text.DebugMon_Handler:00000000 $t
     /tmp/ccMyvXfg.s:317    .text.PendSV_Handler:00000000 $t
     /tmp/ccMyvXfg.s:341    .text.SysTick_Handler:00000000 $t
     /tmp/ccMyvXfg.s:365    .text.IntDefaultHandler:00000000 $t
     /tmp/ccMyvXfg.s:370    .text.IntDefaultHandler:00000000 IntDefaultHandler
                     .debug_frame:00000010 $d
                           .group:00000000 wm4.0.297982dace35b2122e2a403f5ae4c332
                           .group:00000000 wm4.redlib_version.h.14.62abddb5b4efb2dd619a7dca5647eb78
                           .group:00000000 wm4.libconfigarm.h.27.cb268252f36cdcf4924e7de9a2ad2cc2
                           .group:00000000 wm4.stdint.h.39.1f30db482443e74da433dd8a7da42c13

UNDEFINED SYMBOLS
_vStackTop
_bss
_ebss
SystemInit
__main
_etext
_data
_edata
