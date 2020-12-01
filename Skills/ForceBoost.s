BuccForceBoostDisplay:
	ldr		r0,[r4,#0x1a0]
	mov		r1,#0x4000000
	add		r0,r0,#0xD90
	add		r0,r0,#0xC
	bl		CheckExtraState_R1
	cmp		r0,#0
	beq		LeaveForceBoostDisplay
	add		r0,r5,r5,lsl#2
	ldr		r3, =BuccForceBoostID
	add		r0,r4,r0,lsl#2
	add 	r1,r0,#0x100
	mov		r2,#0xa1 ; Change this
	STRH            R3, [R1,#0xB4]
	STR             R2, [R0,#0x1A4]
	STRH            R7, [R1,#0xB6]
	STR             R6, [R0,#0x1A8]
	STR             R6, [R0,#0x1AC]
	LDR             R1, [R4,#0x1A0]
	ADD             R5, R5, #1
	ADD             R1, R1, #0xD00
	LDRSH           R1, [R1,#0x20]
	STR             R1, [R0,#0x1B0]
LeaveForceBoostDisplay:
	pop		{r3-r11,pc}
	
BuccForceBoostID:
	.word 0x31e
.pool


ForceBoostEffect:
	ldrsb r0,[r0,#5]
	cmp r0,#0x13
	moveq r0,#2
	b 0x34a650