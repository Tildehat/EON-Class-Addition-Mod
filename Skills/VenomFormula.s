VenomFormulaWeaknessCheck:
	strh r0,[r10,#0x48]
	mov r3,#0
	ldr r2,[sp,#0x18c];skill ID
	sub r0,r10,#0x600 ; attacker
	mov r1,r4 ; target
	bl check_Elemental_Resistance
	ldr r1,=Float100
	ldr r1,[r1]
	.word 0xEE100A10 ; Vmov r0,S0
	cmp r0,r1
	ble VenomLeave
	ldrh r1,[r10,#0x30] ; load counter
	cmp r1,#9
	addlt r1,r1,#1
	strh r1,[r10,#0x30] ; store counter
	;replaced instruction
VenomLeave:
	b 0x29b1a8

Float100:
	.word 0x42c80000
.pool

VenomChanceIncrease:
	ldrh r7,[r1,#4];infliction rate
	ldr r1, [sp,#0x34]; ally enemy
	ldrb r1,[r1,0x7dc]
	ldr r2,[sp,#0xb0]; skill id
	ldr r3,[sp,#0x28]; skill level
	ldr r0,=VenomInflictionTag
	ldr r0,[r0]
	str r0,[sp]
	bl GetValueFromSkillLevel
	cmp r0,#0
	beq VenomChanceIncreaseLeave
	;r0 now has chance increase
	ldr r1,[sp,#0xA8]
	add r1,r1,#0x600
	ldrb r2,[r1,#0x30] ; Stack
	mul r2,r0,r2
	add r0,r2,r7
	b 0x210564
VenomChanceIncreaseLeave:
	mov r0,r7
	b 0x210564
	
VenomPoisonFactor:
	strh r0,[r4,#0x56]
	ldrb r1,[r7,0x7dc]
	ldr r2,[sp,#0x18]; skill id
	mov r3,r11; skill level
	ldr r0,=VenomPoisonFactorTag
	ldr r0,[r0]
	str r0,[sp]
	bl GetValueFromSkillLevel
	cmp r0,#0
	beq PoisonFactorLeave
	;r0 now has chance increase
	mov r1,r9
	add r1,r1,#0x600
	ldrb r2,[r1,#0x30] ; Stack
	mul r2,r0,r2
	mov r0,#0
	strb r0,[r1,#0x30] ; reset stack
	ldrh r0,[r4,#0x56]
	add r0,r0,r2
	strh r0,[r4,#0x56]
PoisonFactorLeave:
	b 0x23a2ec
	
VenomInflictionTag:
	.word 0x713
VenomPoisonFactorTag:
	.word 0x714
.pool