PincushionDamage:
	;mov		r1,#0xD6
	;mov		r0,r7
	;bl		ReadSkillSubHeaders
	ldrb	r2,[r7,#3] ; grab the bitfield that will contain - 1 = agl stat for offense, 2 = agl stat for enemy defense
	and		r2,r2,#1
	cmp 	r2,#1
	movne	r2,#2
	moveq	r2,#4
	;mov		r1,#7
	b		DamageExit
	
AglDefenseDamage:
	ldrb	r2,[r7,#3] ; grab the bitfield that will contain - 1 = agl stat for offense, 2 = agl stat for enemy defense
	and		r2,r2,#2
	cmp		r2,#2
	movne	r2,#3
	moveq	r2,#4
	b		AglDefenseDamageExit
	
	
AglBuff:
	ldr r0,[sp,#4] ; get location of skill
	ldrb r0,[r0,#2]
	cmp r0,#1 ; agl buff
	ldrneb r0,[r8,#3]
	bne continueBuff
	ldr r1,[sp,#0x30]
	ldrb r1,[r1,#3]
	tst r1,#1
	beq exitBuff
	ldrb r0,[r8,#3]
	b continueBuff

AglDebuff:
	ldr r0,[sp,#4] ; get location of skill
	ldrb r0,[r0,#2]
	cmp r0,#1 ; agl buff
	movne r0,#1
	bne continueDebuff
	ldr r1,[sp,#0x30]
	ldrb r1,[r1,#3]
	tst r1,#2
	beq exitDebuff
	mov r0,#1
	b continueDebuff