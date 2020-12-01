
;Add in the string to get the skill table
SkillTable:
	.word 0x4e22d8, 0x4e2298, 0x4e22fc, 0x4e22e8, 0x4e22f0, 0x4e2318, 0x4e22a8, 0x4e2290, 0x4e22b8, 0x4e22e0, 0x4e22cc, 0x4e2304, 0x4e22c0, 0x4e2334, 0x4e2320, 0x4e22b0, 0x4e2328, 0x4e22a0, 0x4e2310
	.word BuccaneerSkill
	.word 0x4e5758 ;ternimator 
	
BuccaneerSkill: 
	.sjis "Buccaneer"
.align 4

;Adding in a string for the class name
BuccaneerName:
	adr		r0,BuccaneerString
	bx lr

BuccaneerString: 
	.sjis "Ｂｕｃｃａｎｅｅｒ"