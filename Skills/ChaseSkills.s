ChaseEverything:
	mov		r3,r0
	add		r0,r4,#0xD90
	add		r0,r0,#0xC
	mov		r1,#0x2000000
	bl		CheckExtraState_R1
	cmp		r0,#0
	ldreqh	r0,[r3,#0x18]
	movne		r0,#0xFF
	addne		r0,#0x100
	b	ChaseEverythingEscape


DoubleChase:
	mov		r3,r0
	addne	r0,r0,r5,lsl#2
	ldrne	r2,[r0,#4]
	moveq	r1,r9
	beq	DoubleChaseExit
	ldr	r0,[sp,#0xC0]
	sub	r0,r0,#4
	mov	r1, 0x10000000
	bl	CheckExtraState_R1
	cmp r0,#0
	mov	r0,r2
	beq CheckChase
	
	mov	r1,r9
	b DoubleChaseExit
CheckChase:
	adr		r1,ChaseTag1
	ldr		r1,[r1]
	mov		r0,r7
	push	{r2}
	bl ReadSkillSubHeaders
	pop		{r2}
	cmp		r0,#0
	movne	r0,r2,lsr #1
	moveq	r0,r2
	mov	r1,r9
	b DoubleChaseExit

ChaseTag1:
	.word 0x333
.pool