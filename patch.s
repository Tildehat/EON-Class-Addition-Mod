.arm.little

.open "code_orig.bin","code.bin",0x100000
loc_23d9a4 equ 0x23d9a4 
loc_283640 equ 0x283640
ReadSkillSubHeaders equ 0x304de0
GetStat			equ 0x30115c
CheckEquip		equ 0x2850ac
getSkillFromID	equ 0x304ea4
SkillSubheaderCheckR2	equ 0x2e14EC
CheckExtraState_R1	equ 0x302944
loc_26b53c equ 0x26B53c

;buccaneer name
.org 0x2a0EE8
	.word BuccaneerName

.org 0x17ebe0

.include "Names/ClassName.s"
	
.include "Tables/Tables.s"
.include "Skills/AGLDamage.s"
.include "Skills/CounterDisplay.s"
.include "Skills/ChargeSkills.s"
.include "Skills/LimitBreak.s"
.include "Skills/ForceBoost.s"
.include "Skills/RepeatSkills.s"
.include "Skills/ChaseSkills.s"

;For class req for equipment
ProtectorID:
	mov		r1,#0x4
	b		loc_23d9a4

BuccaneerID:
	mov		r1,#0x80000
	b		loc_23d9a4
	
ClassIDDefault:
	mov		r0,#0
	pop		{r4-r6,pc}
	

WeaponFree:
	add		r0,r5,#0xD90
	add		r0,r0,#0xC
	b		WeaponFreeEscape


;Small Effect that plays when entering force boost
.org 0x34a64c
	b ForceBoostEffect

;Double Chase Cut Damage
.org 0x22493c
	b DoubleChase
	DoubleChaseExit:
	cmp	r3,#0
	.word 0x1E000A10

;Insert Pincushion Check
.org 0x22477c
	b PincushionDamage
DamageExit:

.org 0x2248a8
	b AglDefenseDamage
AglDefenseDamageExit:
;.org 0x2248bc
;	nop
	
	
;attack buff
.org 0x284320
	b AglBuff
continueBuff:

.org 0x284498
exitBuff:
	
	
;defensive buff
.org 0x284a4c
	b AglDebuff
continueDebuff:

.org 0x284ba0
exitDebuff:
	

	
.org 0x323c6c
	b CheckAttackSkill
Reblossom:
	bl	CheckEquip
	cmp		r0,#0
	movgt	r6,#1
	mov	r1,#5 ; gun
	mov	r0,r5
	bl	CheckEquip
	cmp		r0,#0
	movgt	r0,#1
	add	r1,r0,r6
	cmp	r1,#1
	nop
	blt	LeaveReblossom
	nop
	
	
.org 0x323CD0
	LeaveReblossom:
	
	
;change The Text ID of Reblossom
.org 0x34257c
b changeReblossomText
	LeaveReblossomProcText:
	

;For charge Skills
.org 0x356b70
	beq		EnhanceChase
	
.org 0x356BB4
	beq		EscapeChargeCheck
	
.org 0x356BCC
ChargeChase:
	.org 0x356BDC
	add	 r10,r6,#0x1600
	
;Get rid of Level Lock
	
;.org 0x486fdc
;	cmp r0,#0
;.org 0x486fe8
;	cmp r0,#0
	
;.org 0x25620c
;	cmp r0,#0
;.org 0x256218
;	cmp r0,#0
	
.org 0x2908cc
	b WeaponFree
	WeaponFreeEscape:
	mov		r1,#0x4000000
	
;Buccaneer Force Boost
.org 0x218FF4
	add		r0,r4,#0x80
	mov		r1,#0x4000000
	
.org 0x356Bf8
	EscapeChargeCheck:
	
	
.org 0x1D43F4
	b ChaseEverything
	ChaseEverythingEscape:

;Starting for editing data to add the class option/functionality
;For Class ID bits
.org 0x283520
	beq		ClassIDDefault
	
.org 0x283530
	beq		ClassIDDefault
	
	
.org 0x28364c
	beq		ClassIDDefault

.org 0x283540
	cmp	r1, #0x15 ; Amount of classes for a switch statement
.org 0x28359c
	.word	BuccaneerID

.org 0x3c8058
	cmp	r5,#0x13
.org 0x3c7ac8
	cmp	r6,#0x13
	
.org 0x4b961b
	.byte 0x13	;Add Buccaneer to Class Make
				;if want more classes neeed to make a new table?
				;only if there is no TTD table movement
	
.org 0x3af4FC
	cmp r1,#0x14 ; Class Make Enumerates 20 classes


.org 0x3af4a8
	add	r2,r0,#0xF2

.org 0x3Af588
	ldrsb	r10,[r0,#0xF2]
	
.org 0x3af628
	ldrsb	r5,[r0,#0xF2]


.org 0x26aa54
	.word CharMakePortraitList	
	
.org 0x26aa44
	.word CharMakePortraitList
	
;Need to move some data for character making because some values get overwritten during subclassing need to make sure there's absolute space to add in any more classes '
.org 0x3aef6c
	ldrsb	r5,[r0,#0xF2] ; Test using 0x40
	
.org 0x2a0e80
	ldrsb	r0,[r0,#0xF2]
	
.org 0x39e7a0
	ldrb	r0,[r0,#0xF2]
	
.org 0x39e7f8
	ldrsb	r0,[r0,#0xF2]
	
.org 0x3af3b0
	ldrsb	r1,[r0,#0xF2]
	
.org 0x3af3c8
	ldrsb	r5,[r0,#0xF2]
		
.org 0x3af08c
	ldrsb	r5,[r0,#0xF2]
	
.org 0x3af338
	ldrsb	r1,[r0,#0xF2]
	
.org 0x3aefec
	ldrsb	r11,[r0,#0xF2]
	
.org 0x48ead4
	ldrsb	r0,[r0,#0xF2]
	
;resonance counter
.org 0x26b4d4
	b	ResonanceCounterDisplay
ResonanceCounterDisplayLeave:

;enhanced chase charge
.org 0x26b440
	b	EhnacedChaseCounterDisplay
EhnacedChaseCounterDisplayLeave:
	
.org 0x2971a8
	b	LimitBreak
	nop
LimitBreakLeave:
	
	
.org 0x29f918
	.word	0x333 ; Change Chain Burst to check chase skills

;Lady Luck changes	
.org 0x2c6718
	mov	r5,#1	;adjust for lady luck allow crit for every skill
.org 0x2c68d4
	nop			;adjust so every skill can have increase crit chance
.org 0x2c6bb4 
	nop			;adjust so every skill can have increase crit damage
	
	
;retire starting weapons
.org 0x20017c
	cmp r5,#0x13

.org 0x200198
	nop
	ldr	r6,[r1,r5,lsl#3]
	
.org 0x2001ac
	nop
	nop
	add	r0,r1,r5,lsl#3
	
.org 0x200264
	.word StartingWeaponTable
	
;Starting Weapons

.org 0x20c6f4
	cmp r5,#0x13

.org 0x20c714
	nop
	ldr	r7,[r1,r5,lsl#3]
	
.org 0x20c728
	nop
	nop
	add	r0,r1,r5,lsl#3
	
.org 0x20C7D4
	.word StartingWeaponTable
	
.org 0x3c7d00
	.word ClassOrderTable
	
.org 0x3c828c
	.word ClassOrderTable
	
.org 0x3d1744 ; Draws Buff Table
	cmp r2,#0x13
	
.org 0x3fec68
	cmp r0,#0x13
	
;Vamp Check
.org 0x2742c0
	mov	r4,#0x15
.org 0x2742d0
	mov	r4,#0x14
	
	
;Force Boost status
.org 0x378344
b BuccForceBoostDisplay	

;PortraitIDs
.org 0x274674
	cmp	r2, #0xa5
.org 0x275354
	cmp	r2, #0xa5
.org 0x2755e4
	cmp	r0, #0xa5


.org 0x37c59c
	cmp	r2, #0xa5
.org 0x37c8b0
	cmp	r2, #0xa5
.org 0x37c8cc
	cmp	r2, #0xa5
	
.org 0x37d708
	cmp	r0, #0xa5
.org 0x37ea98
	cmp	r0, #0xa5
	
.org 0x2755fc
.word PortraitTTDArray

.org 0x366738
.word PortraitTTDArray


;increasing the max amount of reads to the portrait selection

.org 0x275000
	moveq	r0,#0x2a
	
.org 0x275228
	moveq	r0,#0x2a
	
.org 0x37d5e0
	moveq	r0,#0x2a
	
.org 0x37ebcc
	moveq	r0,#0x2a

.org 0x275080
	cmp r2,#0x2a

.org 0x37e9b4
	cmp r2,#0x2a
	
.org 0x2752a4
	cmp r2,#0x2a
	
.org 0x37d6d8
	cmp r2,#0x2a
	
.org 0x292a54
.word 0x320


.org 0x37ef8c
.word PortraitSelect
.org 0x37d748
.word PortraitSelect
.org 0x2752d4
.word PortraitSelect
.org 0x275098
.word PortraitSelect

;Get Id from portrait or whatever
;.org 0x274edc
;	ldr r0,[r1,#0x40]
;	bx lr
	
;.org 0x4b8e94
;	.incbin "PortraitOrderList.bin"
	
.org 0x274fd8
	mov	r0,#0x13
	
;skillTable Class Names
.org 0x1b9d94
.word SkillTable

.org 0x1b9d1c
	mov	r0,r5,lsl#2 ; grabbing subclass

.org 0x1b9ce4
	cmp	r4,#0x15 

.org 0x1d9b0c
	cmp	r4,#0x15

.org 0x1d9b40
	mov	r0,r5,lsl#2
	
.org 0x1d9b9c
	cmp	r6,#0x13
	


.org 0x1d9bb0
.word SkillTable

;making more room for the new class skill table poin
.org 0x1b9cb8
	sub sp,sp, #0x158
.org 0x1b9ccc
	mov	r2,#0x58
	
.org 0x1b9d38
	add sp,sp, #0x158
	
.org 0x1b9d88
	add sp,sp, #0x158

.org 0x1d9adc
	sub sp,sp, #0x158
.org 0x1d9af0
	mov	r2,#0x58
	
.org 0x1d9ba4
	add sp,sp, #0x158

;has stuff for getting the proper skill from id and sub
.org 0x1b1268
	mov r2,r0,lsl#2
	
;this stuff is for character skills
.org 0x28bf5c
	cmp r2,#0x13

.org 0x1d0424
	.word SkillList
.org 0x27cc08
	.word SkillList
.org 0x28bf74
	.word SkillList
.org 0x2df844
	.word SkillList
.org 0x2fd788
	.word SkillList
	

;for sound find a place to move either the skill or sound	
;need to move back 0x8 for every class added
.org 0x1b1280
.word 0x5ba0a0
	
.org 0x1b9d98
.word 0x5ba0a0

.org 0x1d9bac
.word 0x5ba0a0

.Close
