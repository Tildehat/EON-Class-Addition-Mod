CheckIfWeaknessHit:
	ldr r0,[sp,#0xa8]
	ldr r1,[sp,#0xAC]
	ldr r2,[sp,#0xb0]
	mov r3, #0
	bl check_Elemental_Resistance
	ldr r1,=Float1
	ldr r1,[r1]
	.word 0xEE100A10 ; Vmov r0,S0
	cmp r0,r1
	ble 0x210e80
	b 0x210e58
	
Float1:
	.word 0x42c80000
.pool