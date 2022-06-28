
_interrupt:

;Timer0.c,3 :: 		void interrupt(){
;Timer0.c,5 :: 		aa++;
	INFSNZ      _aa+0, 1 
	INCF        _aa+1, 1 
;Timer0.c,6 :: 		UART2_Write_Text("hi");
	MOVLW       ?lstr1_Timer0+0
	MOVWF       FARG_UART2_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Timer0+0)
	MOVWF       FARG_UART2_Write_Text_uart_text+1 
	CALL        _UART2_Write_Text+0, 0
;Timer0.c,7 :: 		if (aa == 4000){
	MOVF        _aa+1, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVLW       160
	XORWF       _aa+0, 0 
L__interrupt5:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;Timer0.c,8 :: 		LATB.B0 = ~LATB.B0;
	BTG         LATB+0, 0 
;Timer0.c,9 :: 		aa = 0;
	CLRF        _aa+0 
	CLRF        _aa+1 
;Timer0.c,10 :: 		}
L_interrupt0:
;Timer0.c,11 :: 		TMR0L = 6;
	MOVLW       6
	MOVWF       TMR0L+0 
;Timer0.c,12 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Timer0.c,15 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;Timer0.c,16 :: 		void main() {
;Timer0.c,17 :: 		OSCCON = 0x62;
	MOVLW       98
	MOVWF       OSCCON+0 
;Timer0.c,18 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;Timer0.c,19 :: 		TRISB = 0;
	CLRF        TRISB+0 
;Timer0.c,20 :: 		LATB = 0X00;
	CLRF        LATB+0 
;Timer0.c,21 :: 		UART2_Init(115200);
	BSF         BAUDCON2+0, 3, 0
	CLRF        SPBRGH2+0 
	MOVLW       16
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;Timer0.c,23 :: 		T0CON = 0Xc0;
	MOVLW       192
	MOVWF       T0CON+0 
;Timer0.c,24 :: 		INTCON = 0Xc0; // interrupt is enabled
	MOVLW       192
	MOVWF       INTCON+0 
;Timer0.c,25 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;Timer0.c,26 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Timer0.c,27 :: 		TMR0L = 6;
	MOVLW       6
	MOVWF       TMR0L+0 
;Timer0.c,28 :: 		while(1){
L_main1:
;Timer0.c,30 :: 		}
	GOTO        L_main1
;Timer0.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
