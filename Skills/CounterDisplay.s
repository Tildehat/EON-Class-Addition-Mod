ResonanceCounterDisplay:
	cmp r1,#2
	cmpne r1,#0x1a4
	b ResonanceCounterDisplayLeave
	
	
EhnacedChaseCounterDisplay:
	cmp	r9,#0x310
	beq	EnhanceChaseCheck
	;r1 = r9 - 0x175
	cmp r1,#0x1ac ; fire palm
	beq FirePalmCheck
	sub r0,r1,#1
	cmp r0,#0x1ac ; Ice palm
	beq IcePalmCheck
	sub r0,r1,#2
	cmp r0,#0x1ac ; Volt palm
	beq VoltPalmCheck
	sub r0,r1,#6
	cmp r0,#0x1AC ; Venom Formula
	beq VenomCheck
	b 0x26b3ec
	
	
EnhanceChaseCheck:
	add		r0,r5, #0x40
	mov		r1,#0x20000
	bl		CheckExtraState_R1
	cmp		r0,#0
	bne		loc_26b53c
CounterLeave:
	pop		{r3-r11,pc}
	
FirePalmCheck:
	add		r0,r5, #0x2c
	mov		r1,#0x400000
	bl		CheckExtraState_R1
	cmp		r0,#0
	beq		CounterLeave
	add		r0,r5,#0x1700
	ldrh	r1,[r0,#0x7c] ; gets element of palm 
	tst		r1,#8
	bne		PalmTurnCheck
	pop		{r3-r11,pc}
	
IcePalmCheck:
	add		r0,r5, #0x2c
	mov		r1,#0x400000
	bl		CheckExtraState_R1
	cmp		r0,#0
	beq		CounterLeave
	add		r0,r5,#0x1700
	ldrh	r1,[r0,#0x7c] ; gets element of palm 
	tst		r1,#0x10
	bne		PalmTurnCheck
	pop		{r3-r11,pc}
	
VoltPalmCheck:
	add		r0,r5, #0x2c
	mov		r1,#0x400000
	bl		CheckExtraState_R1
	cmp		r0,#0
	beq		CounterLeave
	add		r0,r5,#0x1700
	ldrh	r1,[r0,#0x7c] ; gets element of palm 
	tst		r1,#0x20
	bne		PalmTurnCheck
	pop		{r3-r11,pc}
	
	
VenomCheck:
	ldr	r1,=TagThing
	ldr	r1,[r1]
	str	r1,[r4,#0x10]
	ldrh r0,[r8,#0x30] ; weakness count
	b	0x26b49c
	
PalmTurnCheck:
	ldr	r1,=TagThing
	ldr	r1,[r1]
	str	r1,[r4,#0x10]
	ldrh	r0,[r0,#0x68] ; get counter
	add		r0,r0,#1
	b	0x26b49c
	
TagThing:
.word 0x4ea3
.pool
	