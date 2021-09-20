	
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
		
		
PalmElementAndCharge:
	strh r1,[r2,#0x7c] ; store element
	strh r0,[r2,#0x7e] ; store charge
	mov r3,#0
	mov r2,r3
	ldr r1,=GauntletMemoryTag
	ldr r1,[r1]
	mov r0,r10
	bl GetValueofSubheader
	add r2,r10,#0x1700
	add r0,r0,#1
	strb r0,[r2,#0x69]
	ldr r0,[sp,#0x1b4] ; Gets thing for flag
	mov r1,#0x400000 ; palm flag
	bl SetState_R1
	mov r1,#0x800000
	bl ClearState_R1
	b 0x35340c ; exit
	
GauntletMemoryTag:
	.word 0x711
.pool

GauntletMemory:
	mov r0,r4
	add r0,#0x1700
	ldrb r1,[r0,#0x69]
	sub r1,r1,#1
	cmp r1,#0
	strgeb r1,[r0,#0x69]
	bgt 0x24f028
	mov r6,#0x800000
	b 0x24efcc