  	.syntax unified
 	.cpu cortex-m3
 	.thumb
 	.align 2
 	.global	asm_variance
 	.thumb_func

	@.equ N, 6
	#include "share.h"
	.equ N, N_SAMPLE

	.lcomm CB N*4
	.lcomm CB_curr_ptr 4
	.lcomm CB_prev_ptr 4
	.lcomm CB_ctr 4

asm_variance:
	@ args : int x (r0), int mean (r1), int reset (r2)
    @ temp(r3), accu(r4), &CB_curr_ptr(r5), &CB_ctr(r6), temp2(r7), local_ctr(r8), N(r9), ptr(r10), i(r12)

	PUSH {R3-R10}

    @ if reset == 1
	MOV R3, #1
	CMP R2, R3
	BNE NEXT
RESET:
    @ CB_ctr = 0
    LDR R6, =CB_ctr
    LDR R3, [R6]
    MOV R3, #0
    STR R3, [R6]

    @ CB_curr_ptr = &CB[0];
    LDR R3, =CB
	LDR R5, =CB_curr_ptr
    STR R3, [R5]

    @ for (i = 0; i < N; i++) { CB[i] = 0; }
    MOV R9, #0
    MOV R3, #0
    LDR R10, =CB
CLEAR:
    STR R3, [R10]
    ADD R10, R10, #4
    ADD R9, R9, #1
    CMP R9, N
    BNE CLEAR

    @ CB_prev_ptr = CB_curr_ptr
    LDR R10, =CB_prev_ptr
    LDR R3, =CB
    STR R3, [R10]

NEXT:
    @ if CB_ctr % N == 0
    LDR R6, =CB_ctr
    LDR R8, [R6]
    MOV R9, N
    UDIV R2, R8, R9
    MLS R8, R9, R2, R8
	MOVS R3, #0
    CMP R3, R8
    BNE NEXT2
CB_ptr_reset:
    @ CB_curr_ptr = &CB[0]
    LDR R3, =CB
	LDR R5, =CB_curr_ptr
    STR R3, [R5]

NEXT2:
    @ *CB_curr_ptr = x;
    LDR R5, =CB_curr_ptr
    LDR R5, [R5]
    STR R0, [R5]

    @ CB_ctr++
    LDR R6, =CB_ctr
    LDR R3, [R6]
    ADD R3, R3, #1
    STR R3, [R6]

NEXT3:
	@ CB_prev_ptr = CB_curr_ptr; CB_curr_ptr = &CB[CB_ctr%N]
	LDR R5, =CB_curr_ptr
	LDR R10, =CB_prev_ptr

	@ r8 = CB_ctr % N
	LDR R6, =CB_ctr
    LDR R8, [R6]
    MOV R9, N
    UDIV R2, R8, R9
    MLS R8, R9, R2, R8
    LSL R8, R8, 2

    LDR R3, [R5]
	STR R3, [R10]

	LDR R3, =CB
	ADD R3, R3, R8
	STR R3, [R5]

	@ if CB_ctr >= N { CB_prev_ptr = &CB[N-1] }
    LDR R6, =CB_ctr
    LDR R3, [R6]
    CMP R3, N
    BLT NEXT4
    LDR R3, =CB
    MOV R7, N
    SUB R7, R7, #1
    LSL R7, R7, 2
    ADD R3, R3, R7
    STR R3, [R10]

NEXT4:
	@ if CB_ctr < N
    LDR R6, =CB_ctr
    LDR R3, [R6]
    CMP R3, N
    BLT NEXT5

	@ else i = N
    MOV R12, N
    BPL NEXT6
NEXT5:
    @ then i = CB_ctr
    LDR R6, =CB_ctr
    LDR R8, [R6]

    MOV R12, R8

NEXT6:
    @accu = 0
    MOV R4, #0

    LDR R11, [R10]

ACCUM:

    @ temp2 = **(CB_prev_ptr)
    LDR R7, [R11]

    @ temp2 = x - mean
    SUBS R7, R7, R1

    @ temp = (x - mean)^2
    MOV R3, R7
    MUL R3, R3, R7

    @ accu += temp
    ADD R4, R4, R3

    @CB_prev_ptr -= 4
    SUB R11, R11, #4

    SUB R12, R12, #1
    CMP R12, #0
    BNE ACCUM

	@ if CB_ctr < N
	@ then return accu / CB_ctr
	@ else return accu / N
    LDR R6, =CB_ctr
    LDR R3, [R6]
    CMP R3, N
    BLT NEXT7

	MOV R3, N
NEXT7:
    @ variance = accu / CB_ctr
    UDIV R0, R4, R3

    @return variance
	POP {R3-R10}
 	BX	LR
