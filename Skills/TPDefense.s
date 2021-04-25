
tpDefense:
	ldr r1,=tpDamageTag
	ldr r1,[r1]
	mov r0,r6
	bl ReadSkillSubHeaders
	cmp r0,#0
	ldrneh r1,[r6,#0x18]
	tstne r1,r11
	beq tpDefenseLeave
	ldr r0,[sp,#0x44] ; get character struct?
	mov r2,#9 ; Current TP
	mov r1,#7 ;idk
	bl GetStat ;r0 now holds the TP stat
	mov r1,#100
	sub r0,r1,r0,asr#4 ; divide by 16
	mov r1,#0x11
	.word 0xee000a10 ; Vmov s0,r0
	.word 0xeeb80a40, 0xeebd0ac0, 0xee100a10
	bl 0x284c10
	.word 0xee000a10, 0xee014a10, 0xeef80ac0, 0xeeb80ac1, 0xee208aa8,0xee200a08,0xeebd0ac0,0xee104a10 ; float calculation stuff
tpDefenseLeave:
	ldr r1,=HeroicSteelTag
	ldr r1,[r1]
	b 0x24a150

HeroicSteelTag:
	.word 0x4d3

tpDamageTag:
	.word 0x712
.pool