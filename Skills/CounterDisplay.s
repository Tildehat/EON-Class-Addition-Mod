ResonanceCounterDisplay:
	cmp r1,#2
	cmpne r1,#0x1a4
	b ResonanceCounterDisplayLeave
	
	
EhnacedChaseCounterDisplay:
	cmp	r9,#0x310
	beq		EnhanceChaseCheck
	cmp	r9,r1
	b EhnacedChaseCounterDisplayLeave