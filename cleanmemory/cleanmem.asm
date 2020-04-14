	PROCESSOR 6502		; set the processor
	SEG CODE		; segment code
	ORG $F000 		; define the code origin at $F000

START:
	SEI			; disable interrupts
	CLD			; disable the BCD decimal math mode
	LDX #$FF		; loads the X register with #$FF
	TXS			; transfer X register to S(tack) register

;;; Clear the Zero Page region ($00 to $FF)
;;; Meaning the entire TIA register space and also RAM
	LDA #0			; A = 0
	LDX #$FF		; X = #$FF

MEMLOOP:
	STA $0,X		; store A(0) at address $0 + X
	DEX			; X--
	BNE MEMLOOP		; loop until X == 0 (Z-flag set)

;;; Fill ROM size to exactly 4kb
	ORG $FFFC
	.WORD START		; reset vector at $FFFC (where program starts)
	.WORD START		; interrupt vector at $FFFE (unused in VCS)
	
