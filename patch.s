.arm.little

.open "code_orig.bin","code.bin",0x100000
loc_23d9a4 equ 0x23d9a4 
loc_283640 equ 0x283640
ReadSkillSubHeaders equ 0x304de0
GetValueFromSkillLevel equ 0x303a4c
GetStat			equ 0x30115c
CheckEquip		equ 0x2850ac
getSkillFromID	equ 0x304ea4
SkillSubheaderCheckR2	equ 0x2e14EC
CheckExtraState_R1	equ 0x302944
SetState_R1 equ 0x2f1e38
ClearState_R1 equ 0x2e513c
loc_26b53c equ 0x26B53c
noFile equ 0xc8804471
check_Elemental_Resistance equ 0x282134
GetValueofSubheader equ 0x2bbe50
CheckIfUnitHasSkillSubheader equ 0x2DE87C
DoesSkillHaveSubheaderR2 equ 0x28ca30
DoesCharacterHavePassive equ 0x2da34c
GetSkillIDFromCharAndSubheader equ 0x2ccad4
;buccaneer name
.org 0x2a0EE8
	.word BuccaneerName, AlchemistName

;.org 0x17ebe0
.org 0x17e390
.include "Names/ClassName.s"
	
.include "Tables/Tables.s"
.include "Skills/AGLDamage.s"
.include "Skills/CounterDisplay.s"
.include "Skills/ChargeSkills.s"
.include "Skills/LimitBreak.s"
.include "Skills/ForceBoost.s"
.include "Skills/RepeatSkills.s"
.include "Skills/ChaseSkills.s"
.include "Skills/ResistanceChange.s"
.include "Skills/VenomFormula.s"
.include "Skills/TpDefense.s"
.include "Skills/WeaknessCheck.s"

;For class req for equipment
ProtectorID:
	mov		r1,#0x4
	b		loc_23d9a4

BuccaneerID:
	mov		r1,#0x80000
	b		loc_23d9a4

AlchemistID:
	mov		r1,#0x100000
	b		loc_23d9a4
	
ClassIDDefault:
	mov		r0,#0
	pop		{r4-r6,pc}
	

WeaponFree:
	add		r0,r5,#0xD90
	add		r0,r0,#0xC
	b		WeaponFreeEscape
	
recoilProc:
	mov r0,r10
	ldr r1,[sp,#0x80]
	mov r2,#0x3b0 ; blade recoil subheader
	add r2,r2,#1
	bl SkillSubheaderCheckR2 ; check if blade recoil first hit
	cmp r0,#0
	ldr r0,[sp,#0x168];get element
	streqb r0,[r10,#0xA21];not blade recoil proc
	streqb r0,[r10,#0xa20]
	b RecoilLeave

;WeaponCrit:
;	mov r1,#0x710
;	add r1,r1,#5
;	add r2,sp,#4
;	mov r0,r6
;	bl CheckIfUnitHasSkillSubheader
;	cmp r0,#0
;	moveq r2,#0x69
;	beq 0x2c6754
;	add r0,r6,#0x1000
;	ldrb	r0,[r0,#0x7dc]
;	mov	r1,r9
;	mov r2,#1
;	bl  getSkillFromID
;	ldrh r0,[r0,#0x4]
;	and r0,r0,0x1000
;	cmp	r0,#0
;	movne r5,#1
;	mov r2,#0x69
;	b 0x2c6754
	
	
;PlayerScissorWrath:
;	mov r1,#0x6e0 
;	add r1,r1,#0x2
;	mov r0,r4
;	add r2,sp,#0x1c
;	bl GetSkillIDFromCharAndSubheader
	
;	b 0x29f254
	
;.org 0x29f23c
;	bne PlayerScissorWrath
	
;make knives ranged
;.org 0x2c14b0
;	b	0x34464c

;.org 0x34464c
;	cmp	r0,#2
;	cmpne r0,#5
;	cmpne r0,#8
;	beq 0x2c1518
;	b	0x2c14bc


;fix blade recoil
	.org 0x2ae5c4
	mov r0,r10
	ldr r1,[sp,#0x80]
	mov r2,#0xCD ; blade recoil subheader
	bl SkillSubheaderCheckR2 ; check if blade recoil first hit
	cmp r0,#0
	ldr r0,[sp,#0x168];get element
	streqb r0,[r10,#0xA21];not blade recoil store
	;strb r0,[r10,#0xa20]
	beq recoilProc
	strneb r0,[r10,#0xa20]
RecoilLeave:
	nop
	nop
	nop
	
.org 0x293284
	ldrb r1,[r4,#0xa21]
	
.org 0x2cb284
	ldrb r1,[r5,#0xa21]
	

; this code is for reimplementing some per-bind subheader for crit damage
    .org 0x2C6ABC
        mov r11, #0
        ldr r0, [sp, #0x10]
        add r0, r0, #0x1400
        add r0, r0, #0x3FC
        ldrh r0, [r0, #0xC]
        tst r0, #0x400
        addne r11, r11, #0x1
        tst r0, #0x800
        addne r11, r11, #0x1
        tst r0, #0x1000
        addne r11, r11, #0x1
        cmp r11, #0
        beq #0x2C6B1C
        mov r1, #0x490
        add r1, r1, #0xD
        add r2, sp, #0x4
        mov r0, r6
        bl #0x2DE87C
        cmp r0, #0
        beq #0x2C6B1C
        ldr r0, [sp, #0x4]
        mla r5, r11, r0, r5
        b #0x2C6B1C

; end crit bonus on binds code
    
	
;riot formula for tp cost check
.org 0x2b0dd4
;	cmp r12,r7
;	ldreq r1,[sp,#0x5c];not a weapon skill, load from stack
;	ldrne r1,[sp,#0x24];weapon skill
;	ldrh r0,[r1,#6]


.org 0x23a2e8
	b VenomPoisonFactor
.org 0x210560
	b VenomChanceIncrease

.org 0x29b038 ; hit count
	b VenomFormulaWeaknessCheck

.org 0x24a14c
	;defensive passives
	b tpDefense

;common element mucking
.org 0x2a8714
	ldr r1,[sp,#0x168]
	nop
	cmp r1,#0
	beq 0x2a8730
.org 0x2a8728
	orr r0,r0,r1 


;common element
.org 0x235050
	ldrh r1,[sp,#0x18];get element
.org 0x235060
	ands r0,r1

.org 0x34ef38
	ldrh r1,[r7,#0x18] ; get element of palm
	add r2,r10,#0x1700
	b PalmElementAndCharge

;Small Effect that plays when entering force boost
.org 0x34a64c
	b ForceBoostEffect

;Double Chase Cut Damage
.org 0x22493c
	b DoubleChase
	DoubleChaseExit:
	cmp	r3,#0
	.word 0x1E000A10

.org 0x1fcf04
	b 0x1fd0d8

;Insert Pincushion Check
.org 0x22477c
	b PincushionDamage
DamageExit:

.org 0x2248a8
	b AglDefenseDamage
AglDefenseDamageExit:
	
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
	
;Corrosive Formula Resistance
.org 0x2b4aa4
	b Corrosive
	
	
;vital hit max hp check
;.org 0x359908
;	ldr r0,[r0,#0x84]
;.org 0x3599f0
;	ldr r0,[r0,#0x84]
	
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

;.org 0x26b470
;	bne ReprisalCounter
	
;.org 0x26b350
;	add r11,r7,r6,lsl#2
;	add r8,r5,#0x600
;	add r10,r5,#0x1600
;	b CooldownCounter
;CooldownCounterNormal:
;	add r2,r5,#0x2c
;	add r0,r5,0x54



;.org 0x26b394
;	b 0x26b3ec ; full guard

;resonance counter
.org 0x26b4d4
	b	ResonanceCounterDisplay
ResonanceCounterDisplayLeave:

;enhanced chase charge
.org 0x26b4fc
	bne	EhnacedChaseCounterDisplay
	
.org 0x2971a8
	b	LimitBreak
	nop
LimitBreakLeave:
	
	
.org 0x29f918
	.word	0x333 ; Change Chain Burst to check chase skills

;Lady Luck changes	
.org 0x2c6718
	mov	r5,#1	;adjust for lady luck allow crit for every skill
.org 0x2c68f0
	nop			;adjust so every skill can have increase crit chance
.org 0x2c6bb4 
	nop			;adjust so every skill can have increase crit damage
	
;.org 0x2c6750
;	b WeaponCrit

;analytic strike stuff
.org 0x210e54
	b CheckIfWeaknessHit
	ldr r0,[sp,#0x14]
	add r0,r0,#0x64
	bic r1,r11,#0xfd00
	bics r1,r1,#0xfe

.org 0x24efc8
	b GauntletMemory


;Starting for editing data to add the class option/functionality
;For Class ID bits
.org 0x283520
	beq		ClassIDDefault
	
.org 0x283530
	beq		ClassIDDefault
	
	
.org 0x28364c
	beq		ClassIDDefault

.org 0x283540
	cmp	r1, #0x16 ; Amount of classes for a switch statement
.org 0x28359c
	.word	BuccaneerID,AlchemistID

;check for bitfield classes
.org 0x3c8058
	cmp	r5,#0x14
.org 0x3c7ac8
	cmp	r6,#0x14
	
.org 0x4b961b
	.byte 0x13	;Add Buccaneer to Class Make
				;if want more classes neeed to make a new table?
				;only if there is no TTD table movement
	
.org 0x3af4FC
	cmp r1,#0x15 ; Class Make Enumerates 20 classes
.org 0x3af664
	.word ClassCreateOrder
	
.org 0x3af4b0
	ldmia r10, {r0,r1,r8-r10,r12}
.org 0x3af4bc
	stmia r3, {r0,r1,r8-r10,r12}
	mov r1,r11

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
	
;Character creation change thing that fucks with sp???
.org 0x20c784 ; Retire
	mov r0,#0

.org 0x200214 ; Create
	mov r0,#0
	
.org 0x27701c ; Rest
	mov r0,#0
	
;retire starting weapons
.org 0x20017c
	cmp r5,#0x14

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
	cmp r5,#0x14

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

; Draws Buff Table
.org 0x3d1744 
	cmp r2,#0x14
.org 0x3fec68
	cmp r0,#0x14
	
;Vamp Check
.org 0x2742c0
	mov	r4,#0x16
.org 0x2742d0
	mov	r4,#0x15
	
	
;Force Boost status
.org 0x378344
b BuccForceBoostDisplay	

;PortraitIDs
.org 0x274674
	cmp	r2, #0xb0
.org 0x275354
	cmp	r2, #0xb0
.org 0x2755e4
	cmp	r0, #0xb0


.org 0x37c59c
	cmp	r2, #0xb0
.org 0x37c8b0
	cmp	r2, #0xb0
.org 0x37c8cc
	cmp	r2, #0xb0
	
.org 0x37d708
	cmp	r0, #0xb0
.org 0x37ea98
	cmp	r0, #0xb0
	
.org 0x2755fc
.word PortraitTTDArray

.org 0x366738
.word PortraitTTDArray


;increasing the max amount of reads to the portrait selection

.org 0x275000
	moveq	r0,#0x2d
	
.org 0x275228
	moveq	r0,#0x2d
	
.org 0x37d5e0
	moveq	r0,#0x2d
	
.org 0x37ebcc
	moveq	r0,#0x2d

.org 0x275080
	cmp r2,#0x2d

.org 0x37e9b4
	cmp r2,#0x2d
	
.org 0x2752a4
	cmp r2,#0x2d
	
.org 0x37d6d8
	cmp r2,#0x2d
	
.org 0x292a54
.word 0x3ff ; some cap to display skills in force boost section?


.org 0x37ef8c
.word PortraitSelect
.org 0x37d748
.word PortraitSelect
.org 0x2752d4
.word PortraitSelect
.org 0x275098
.word PortraitSelect

;for getting class ID atlus originally did some shit for vamp...
.org 0x274ee0
	sub r0,r1,#0x13
	bx lr


;charamake_job_index stuff
.org 0x3fb9c8
	cmp r2,#0x15
.org 0x37d6f0
	cmp r2,#0x15
.org 0x280cd4
	cmp r2,#0x15
.org 0x3fb9c8
	cmp r2,#0x15


;Get Id from portrait or whatever
;.org 0x274edc
;	ldr r0,[r1,#0x40]
;	bx lr
	
.org 0x4b8e94
	.incbin "Tables/PortraitOrderList.bin"
	
;.org 0x274fd8 ; class name index during creation for bucc
;	mov	r0,#0x13
	
;skillTable Class Names UNUSED?
.org 0x1b9d94
.word SkillTable

.org 0x1b9d1c
	mov	r0,r5,lsl#2 ; grabbing subclass UNUSED

.org 0x1b9ce4
	cmp	r4,#0x15 ;get skiltable file name (Unused)



;getting skill file name
.org 0x1d9b0c
	cmp	r4,#0x15 ; get skilltalbe file name

.org 0x1d9b40
	add	r0,r5,r5,lsl#2 ; grabbing subclass
	
.org 0x1d9b9c
	cmp	r6,#0x14 ;get skill name

.org 0x1d9bb0
.word SkillTable

;making more room for the new class skill table poin
.org 0x1b9cb8
	sub sp,sp, #0x160
.org 0x1b9ccc
	mov	r2,#0x60
	
.org 0x1b9d38
	add sp,sp, #0x160
	
.org 0x1b9d88
	add sp,sp, #0x160

.org 0x1d9adc
	sub sp,sp, #0x160
.org 0x1d9af0
	mov	r2,#0x60
	
.org 0x1d9ba4
	add sp,sp, #0x160

;has stuff for getting the proper skill from id and sub
.org 0x1b1268
	add r2,r0,r0,lsl#2
	
;this stuff is for character skills
.org 0x28bf5c
	cmp r2,#0x14

.org 0x27cbac
	cmp r0,#0x15

.org 0x1d03e4
	cmp r0,#0x15
	
.org 0x1d0398
	cmp r0,#0x15
	
.org 0x28bf04
	cmp r3,#0x16

.org 0x2df7ac
	cmp r2,#0x15
	
.org 0x2fd648
	cmp r0,#0x15

.org 0x2fd58c
	cmp r0,#0x15

.org 0x1d0424
	.word SkillList
.org 0x27cc08
	.word SkillList
.org 0x28bf70
	.word 0x3ff
	.word SkillList
.org 0x2df844
	.word SkillList
.org 0x2fd788
	.word SkillList

.org 0x296790
	.word 0x3ff
.org 0x2d9da8
	.word 0x3ff
	
;skill order...
.org 0x211f04
	bx lr

;for sound find a place to move either the skill or sound	
;need to move back 0x8 for every class added
.org 0x1b1280
.word 0x5ba098
	
.org 0x1b9d98
.word 0x5ba098

.org 0x1d9bac
.word 0x5ba098


.org 0x48bff8
	ldr r0,[r4,#0x94];get char point
	ldrsb r8,[r0,#0xa];get subclass
	add r2,r1,r8
	b 0x48c03c

.org 0x48c0f0
	.word 0x3e80
	


.org 0x2b4e00 ; force buff removal
	b DrawingStanceReset


.org 0x227f9c
	b	DrawingReset ; When buff turn count ticks down

.org 0x2a256c ; multiplayer function
DrawingReset:
	ldrh r1,[r6,#0xFA]; get subheader
	bl getSkillFromID ; getEnemyAllySkillFromID
	mov r1,#0x35c
	bl ReadSkillSubHeaders
	cmp r0,#0
	beq DrawResetLeave
	mov r0,r5
	add r0,r0,#0x28
	mov r1,#0x1000
	bl 0x2e513c
DrawResetLeave:
	ldr r0,[sp,#0x88]
	b 0x227fa0
DrawingStanceReset:
	add	r0,r7,r11,lsl#2
	ldrh r1,[r0,#6]; load skill
	ldr r0,[r4,#0x7dc]
	bl getSkillFromID
	mov r1,#0x35c
	bl ReadSkillSubHeaders
	cmp r0,#0
	beq DrawResetLeave2
	mov r0,r6
	add r0,r0,#0x28
	mov r1,#0x1000
	bl 0x2e513c
DrawResetLeave2:
	mov r3,#0
	b 0x2b4e04

.org 0x118ff8 ;when files get loaded
	b 0x119020 ; skip the check if HPB is loaded
.org 0x28ca5c
checkFileExist:
	tst r0, #0x80000000
	moveq r1,#0
	streq r1,[r4,#0x10]
	beq	0x119120	;found file load from rom path
	ldr r1,[r4,#0x10]
	cmp r1,#1
	movne r1,#1
	strne r1,[r4,#0x10]
	bne 0x11900c	;no file in the rom check HPB
	moveq r1,#0
	streq r1,[r4,#0x10]
	tst r0, #0x80000000
	b 0x119120
.org 0x11911c
	b checkFileExist


.org 0x310668 ;when files get loaded
	b 0x31068c ; skip the check if HPB is loaded
checkFileExistModelAndSound:
;	tst r0, #0x80000000
;	bne 0x31067c	;no file in the rom check HPB
;	mov	r5,r0
;	b	0x31074c	;found file load from rom path
	
.org 0x310748
	;b checkFileExistModelAndSound
.org 0x3107a8
	b 0x31067c


.Close
