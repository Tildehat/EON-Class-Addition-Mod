LimitBreak:
	ldrh	r2,[r8,#0xE4]
	cmp		r4,r2
	movge	r4,r2
	b	LimitBreakLeave