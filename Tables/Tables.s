; have the skill.bin for skill ids for the classes
.align 4
SkillList:	
.incbin "Tables/Skill.bin"

; TTD ids of char make textures
.align 4
CharMakePortraitList:	
.incbin "Tables/CharMakePortrait.bin"

;Array List for starting weapons
.align 4
StartingWeaponTable:
.incbin "Tables/StartingWeapons.bin"

; Class order 
.align 4
ClassOrderTable:
.incbin "Tables/ClassOrder.bin"

; Array to grabbing the portrait from ID to place in the TTD
.align 4
PortraitTTDArray:
.incbin "Tables/PortraitTTDArray.bin"


; Array for including all selectable portraits during class creation per class
.align 4
PortraitSelect:
.incbin "Tables/PortraitSelect.bin"

.align 4
ClassCreateOrder:
.incbin "Tables/ClassIDCreateOrder.bin"

.align 4