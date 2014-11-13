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
  14              		.file	"main.c"
  15              		.text
  16              	.Ltext0:
  17              		.cfi_sections	.debug_frame
  18              		.section	.rodata
  19              		.align	2
  20              	.LC1:
  21 0000 76617269 		.ascii	"variance: %d\012\000"
  21      616E6365 
  21      3A202564 
  21      0A00
  22 000e 0000     		.align	2
  23              	.LC2:
  24 0010 52455345 		.ascii	"RESET\012\000"
  24      540A00
  25 0017 00       		.align	2
  26              	.LC0:
  27 0018 00000000 		.word	0
  28 001c 01000000 		.word	1
  29 0020 02000000 		.word	2
  30 0024 03000000 		.word	3
  31 0028 04000000 		.word	4
  32 002c 05000000 		.word	5
  33 0030 06000000 		.word	6
  34 0034 07000000 		.word	7
  35 0038 08000000 		.word	8
  36 003c 09000000 		.word	9
  37 0040 0A000000 		.word	10
  38 0044 0B000000 		.word	11
  39              		.section	.text.main,"ax",%progbits
  40              		.align	2
  41              		.global	main
  42              		.thumb
  43              		.thumb_func
  45              	main:
  46              	.LFB29:
  47              		.file 1 "../src/main.c"
   1:../src/main.c **** #include "LPC17xx.h"
   2:../src/main.c **** #include "stdio.h"
   3:../src/main.c **** 
   4:../src/main.c **** extern int asm_variance(int x, int mean, int reset);
   5:../src/main.c **** 
   6:../src/main.c **** int main(void)
   7:../src/main.c **** {
  48              		.loc 1 7 0
  49              		.cfi_startproc
  50              		@ args = 0, pretend = 0, frame = 56
  51              		@ frame_needed = 1, uses_anonymous_args = 0
  52 0000 B0B5     		push	{r4, r5, r7, lr}
  53              		.cfi_def_cfa_offset 16
  54              		.cfi_offset 4, -16
  55              		.cfi_offset 5, -12
  56              		.cfi_offset 7, -8
  57              		.cfi_offset 14, -4
  58 0002 8EB0     		sub	sp, sp, #56
  59              		.cfi_def_cfa_offset 72
  60 0004 00AF     		add	r7, sp, #0
  61              		.cfi_def_cfa_register 7
   8:../src/main.c **** 	// Variable definitions
   9:../src/main.c **** 	int i;
  10:../src/main.c **** 	int x[12]={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
  62              		.loc 1 10 0
  63 0006 424B     		ldr	r3, .L13
  64 0008 3C1D     		adds	r4, r7, #4
  65 000a 1D46     		mov	r5, r3
  66 000c 0FCD     		ldmia	r5!, {r0, r1, r2, r3}
  67 000e 0FC4     		stmia	r4!, {r0, r1, r2, r3}
  68 0010 0FCD     		ldmia	r5!, {r0, r1, r2, r3}
  69 0012 0FC4     		stmia	r4!, {r0, r1, r2, r3}
  70 0014 95E80F00 		ldmia	r5, {r0, r1, r2, r3}
  71 0018 84E80F00 		stmia	r4, {r0, r1, r2, r3}
  11:../src/main.c **** 
  12:../src/main.c **** 	// Call asm function with mean 3
  13:../src/main.c **** 	for (i=0;i<12;i++)
  72              		.loc 1 13 0
  73 001c 0023     		movs	r3, #0
  74 001e 7B63     		str	r3, [r7, #52]
  75 0020 28E0     		b	.L2
  76              	.L5:
  14:../src/main.c **** 		if (i==0)
  77              		.loc 1 14 0
  78 0022 7B6B     		ldr	r3, [r7, #52]
  79 0024 002B     		cmp	r3, #0
  80 0026 11D1     		bne	.L3
  15:../src/main.c **** 			printf("variance: %d\n", asm_variance(x[i],3,1));
  81              		.loc 1 15 0
  82 0028 7B6B     		ldr	r3, [r7, #52]
  83 002a 9B00     		lsls	r3, r3, #2
  84 002c 07F13801 		add	r1, r7, #56
  85 0030 0B44     		add	r3, r3, r1
  86 0032 53F8343C 		ldr	r3, [r3, #-52]
  87 0036 1846     		mov	r0, r3
  88 0038 0321     		movs	r1, #3
  89 003a 0122     		movs	r2, #1
  90 003c FFF7FEFF 		bl	asm_variance
  91 0040 0346     		mov	r3, r0
  92 0042 3448     		ldr	r0, .L13+4
  93 0044 1946     		mov	r1, r3
  94 0046 FFF7FEFF 		bl	printf
  95 004a 10E0     		b	.L4
  96              	.L3:
  16:../src/main.c **** 		else
  17:../src/main.c **** 			printf("variance: %d\n", asm_variance(x[i],3,0));
  97              		.loc 1 17 0
  98 004c 7B6B     		ldr	r3, [r7, #52]
  99 004e 9B00     		lsls	r3, r3, #2
 100 0050 07F13802 		add	r2, r7, #56
 101 0054 1344     		add	r3, r3, r2
 102 0056 53F8343C 		ldr	r3, [r3, #-52]
 103 005a 1846     		mov	r0, r3
 104 005c 0321     		movs	r1, #3
 105 005e 0022     		movs	r2, #0
 106 0060 FFF7FEFF 		bl	asm_variance
 107 0064 0346     		mov	r3, r0
 108 0066 2B48     		ldr	r0, .L13+4
 109 0068 1946     		mov	r1, r3
 110 006a FFF7FEFF 		bl	printf
 111              	.L4:
  13:../src/main.c **** 	for (i=0;i<12;i++)
 112              		.loc 1 13 0
 113 006e 7B6B     		ldr	r3, [r7, #52]
 114 0070 0133     		adds	r3, r3, #1
 115 0072 7B63     		str	r3, [r7, #52]
 116              	.L2:
  13:../src/main.c **** 	for (i=0;i<12;i++)
 117              		.loc 1 13 0 is_stmt 0 discriminator 1
 118 0074 7B6B     		ldr	r3, [r7, #52]
 119 0076 0B2B     		cmp	r3, #11
 120 0078 D3DD     		ble	.L5
  18:../src/main.c **** 
  19:../src/main.c **** 	// Reverse the order of x values
  20:../src/main.c **** 	for (i=0;i<12;i++)
 121              		.loc 1 20 0 is_stmt 1
 122 007a 0023     		movs	r3, #0
 123 007c 7B63     		str	r3, [r7, #52]
 124 007e 0CE0     		b	.L6
 125              	.L7:
  21:../src/main.c **** 		x[i] = 11-i;
 126              		.loc 1 21 0 discriminator 2
 127 0080 7B6B     		ldr	r3, [r7, #52]
 128 0082 C3F10B02 		rsb	r2, r3, #11
 129 0086 7B6B     		ldr	r3, [r7, #52]
 130 0088 9B00     		lsls	r3, r3, #2
 131 008a 07F13801 		add	r1, r7, #56
 132 008e 0B44     		add	r3, r3, r1
 133 0090 43F8342C 		str	r2, [r3, #-52]
  20:../src/main.c **** 	for (i=0;i<12;i++)
 134              		.loc 1 20 0 discriminator 2
 135 0094 7B6B     		ldr	r3, [r7, #52]
 136 0096 0133     		adds	r3, r3, #1
 137 0098 7B63     		str	r3, [r7, #52]
 138              	.L6:
  20:../src/main.c **** 	for (i=0;i<12;i++)
 139              		.loc 1 20 0 is_stmt 0 discriminator 1
 140 009a 7B6B     		ldr	r3, [r7, #52]
 141 009c 0B2B     		cmp	r3, #11
 142 009e EFDD     		ble	.L7
  22:../src/main.c **** 
  23:../src/main.c **** 	// Reset and call asm function with mean 3
  24:../src/main.c **** 	printf("RESET\n");
 143              		.loc 1 24 0 is_stmt 1
 144 00a0 1D48     		ldr	r0, .L13+8
 145 00a2 FFF7FEFF 		bl	printf
  25:../src/main.c **** 
  26:../src/main.c **** 	for (i=0;i<12;i++)
 146              		.loc 1 26 0
 147 00a6 0023     		movs	r3, #0
 148 00a8 7B63     		str	r3, [r7, #52]
 149 00aa 28E0     		b	.L8
 150              	.L11:
  27:../src/main.c **** 		if (i==0)
 151              		.loc 1 27 0
 152 00ac 7B6B     		ldr	r3, [r7, #52]
 153 00ae 002B     		cmp	r3, #0
 154 00b0 11D1     		bne	.L9
  28:../src/main.c **** 			printf("variance: %d\n", asm_variance(x[i],3,1));
 155              		.loc 1 28 0
 156 00b2 7B6B     		ldr	r3, [r7, #52]
 157 00b4 9B00     		lsls	r3, r3, #2
 158 00b6 07F13802 		add	r2, r7, #56
 159 00ba 1344     		add	r3, r3, r2
 160 00bc 53F8343C 		ldr	r3, [r3, #-52]
 161 00c0 1846     		mov	r0, r3
 162 00c2 0321     		movs	r1, #3
 163 00c4 0122     		movs	r2, #1
 164 00c6 FFF7FEFF 		bl	asm_variance
 165 00ca 0346     		mov	r3, r0
 166 00cc 1148     		ldr	r0, .L13+4
 167 00ce 1946     		mov	r1, r3
 168 00d0 FFF7FEFF 		bl	printf
 169 00d4 10E0     		b	.L10
 170              	.L9:
  29:../src/main.c **** 		else
  30:../src/main.c **** 			printf("variance: %d\n", asm_variance(x[i],3,0));
 171              		.loc 1 30 0
 172 00d6 7B6B     		ldr	r3, [r7, #52]
 173 00d8 9B00     		lsls	r3, r3, #2
 174 00da 07F13801 		add	r1, r7, #56
 175 00de 0B44     		add	r3, r3, r1
 176 00e0 53F8343C 		ldr	r3, [r3, #-52]
 177 00e4 1846     		mov	r0, r3
 178 00e6 0321     		movs	r1, #3
 179 00e8 0022     		movs	r2, #0
 180 00ea FFF7FEFF 		bl	asm_variance
 181 00ee 0346     		mov	r3, r0
 182 00f0 0848     		ldr	r0, .L13+4
 183 00f2 1946     		mov	r1, r3
 184 00f4 FFF7FEFF 		bl	printf
 185              	.L10:
  26:../src/main.c **** 	for (i=0;i<12;i++)
 186              		.loc 1 26 0
 187 00f8 7B6B     		ldr	r3, [r7, #52]
 188 00fa 0133     		adds	r3, r3, #1
 189 00fc 7B63     		str	r3, [r7, #52]
 190              	.L8:
  26:../src/main.c **** 	for (i=0;i<12;i++)
 191              		.loc 1 26 0 is_stmt 0 discriminator 1
 192 00fe 7B6B     		ldr	r3, [r7, #52]
 193 0100 0B2B     		cmp	r3, #11
 194 0102 D3DD     		ble	.L11
 195              	.L12:
  31:../src/main.c **** 
  32:../src/main.c **** 	// Enter an infinite loop, just incrementing a counter
  33:../src/main.c **** 	volatile static int loop = 0;
  34:../src/main.c **** 	while (1) {
  35:../src/main.c **** 		loop++;
 196              		.loc 1 35 0 is_stmt 1 discriminator 1
 197 0104 054B     		ldr	r3, .L13+12
 198 0106 1B68     		ldr	r3, [r3]
 199 0108 5A1C     		adds	r2, r3, #1
 200 010a 044B     		ldr	r3, .L13+12
 201 010c 1A60     		str	r2, [r3]
  36:../src/main.c **** 	}
 202              		.loc 1 36 0 discriminator 1
 203 010e F9E7     		b	.L12
 204              	.L14:
 205              		.align	2
 206              	.L13:
 207 0110 18000000 		.word	.LC0
 208 0114 00000000 		.word	.LC1
 209 0118 10000000 		.word	.LC2
 210 011c 00000000 		.word	loop.4984
 211              		.cfi_endproc
 212              	.LFE29:
 214              		.bss
 215              		.align	2
 216              	loop.4984:
 217 0000 00000000 		.space	4
 218              		.text
 219              	.Letext0:
 220              		.file 2 "/home/jmbto/workspace/Lib_CMSISv1p30_LPC17xx/inc/core_cm3.h"
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
     /tmp/cc2Zkahc.s:19     .rodata:00000000 $d
     /tmp/cc2Zkahc.s:40     .text.main:00000000 $t
     /tmp/cc2Zkahc.s:45     .text.main:00000000 main
     /tmp/cc2Zkahc.s:207    .text.main:00000110 $d
     /tmp/cc2Zkahc.s:216    .bss:00000000 loop.4984
     /tmp/cc2Zkahc.s:215    .bss:00000000 $d
                     .debug_frame:00000010 $d
                           .group:00000000 wm4.0.297982dace35b2122e2a403f5ae4c332
                           .group:00000000 wm4.LPC17xx.h.27.1faa00ce46dcb8f4b6c3bd1994166236
                           .group:00000000 wm4.core_cm3.h.25.d35e9a9b04ec4aaebae9bf79fff061f9
                           .group:00000000 wm4.redlib_version.h.14.62abddb5b4efb2dd619a7dca5647eb78
                           .group:00000000 wm4.libconfigarm.h.27.cb268252f36cdcf4924e7de9a2ad2cc2
                           .group:00000000 wm4.stdint.h.39.1f30db482443e74da433dd8a7da42c13
                           .group:00000000 wm4.core_cm3.h.113.418486a6827cd861c086288012ae5e2b
                           .group:00000000 wm4.LPC17xx.h.913.41dbcd8dbbac2c8a2ad77c79813d6199
                           .group:00000000 wm4.stdio.h.59.a25a4419a004f2fbdb3c49f1a3193d3d

UNDEFINED SYMBOLS
asm_variance
printf
