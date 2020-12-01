EnhanceChaseCheck:
	add		r0,r2, #0x14
	mov		r1,#0x20000
	bl		CheckExtraState_R1
	cmp		r0,#0
	bne		loc_26b53c
	pop		{r3-r11,pc}
	
	
EnhanceChase:
	ldr		r1,[sp,#0x5C]
	adr		r2, ChaseTag
	ldr		r2,[r2]
	mov		r0,r6
	bl		SkillSubheaderCheckR2
	cmp		r0,#0
	beq		EscapeChargeCheck
	bne		ChargeChase
	
ChaseTag:
		.word 0x333