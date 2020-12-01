CheckAttackSkill:
	mov	r0,r5
	add		r0,r0,#0x1000
	ldrb	r0,[r0,#0x7DC]
	ldrsh	r1,[r4,#0xA] ; get skill ID
	cmp 	r1,0x1
	beq		LeaveReblossom
	mov		r2,#1
	bl		getSkillFromID
	ldrb	r1,[r0,#1]
	cmp		r1,#0
	cmpne	r1,#1
	bne		LeaveReblossom
	add r0,r5,#0x1800 
	add r0,r0,#0xC
	mov	r1,#7 ; Rapier
	mov	r0,r5
	mov	r6,#0
	b		Reblossom
	
	
changeReblossomText:
	adr		r1,ReblossomSkillID
	ldr		r1,[r1]
	b LeaveReblossomProcText

ReblossomSkillID:
	.word 0x317
.pool