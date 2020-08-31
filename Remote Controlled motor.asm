
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Remote Controlled motor.c,26 :: 		void Interrupt(){               //External interrupt occured
;Remote Controlled motor.c,28 :: 		delay_us(370);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      111
	MOVWF      R13+0
L_Interrupt0:
	DECFSZ     R13+0, 1
	GOTO       L_Interrupt0
	DECFSZ     R12+0, 1
	GOTO       L_Interrupt0
	NOP
	NOP
;Remote Controlled motor.c,29 :: 		if(PORTB.F0==0){
	BTFSC      PORTB+0, 0
	GOTO       L_Interrupt1
;Remote Controlled motor.c,30 :: 		delay_us(889);
	MOVLW      4
	MOVWF      R12+0
	MOVLW      117
	MOVWF      R13+0
L_Interrupt2:
	DECFSZ     R13+0, 1
	GOTO       L_Interrupt2
	DECFSZ     R12+0, 1
	GOTO       L_Interrupt2
	NOP
;Remote Controlled motor.c,31 :: 		if(PORTB.F0==1){
	BTFSS      PORTB+0, 0
	GOTO       L_Interrupt3
;Remote Controlled motor.c,32 :: 		delay_us(889);
	MOVLW      4
	MOVWF      R12+0
	MOVLW      117
	MOVWF      R13+0
L_Interrupt4:
	DECFSZ     R13+0, 1
	GOTO       L_Interrupt4
	DECFSZ     R12+0, 1
	GOTO       L_Interrupt4
	NOP
;Remote Controlled motor.c,33 :: 		if(PORTB.F0==0){
	BTFSC      PORTB+0, 0
	GOTO       L_Interrupt5
;Remote Controlled motor.c,34 :: 		ir_read = 1;
	MOVLW      1
	MOVWF      _ir_read+0
;Remote Controlled motor.c,35 :: 		INTCON  = 0;                //Disabe the external interrupt
	CLRF       INTCON+0
;Remote Controlled motor.c,36 :: 		}}}
L_Interrupt5:
L_Interrupt3:
L_Interrupt1:
;Remote Controlled motor.c,37 :: 		INTF_bit = 0;                //Clear Interrupt flag
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Remote Controlled motor.c,38 :: 		}
L_end_Interrupt:
L__Interrupt28:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_display_results:

;Remote Controlled motor.c,39 :: 		void display_results (){
;Remote Controlled motor.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);            //Clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Remote Controlled motor.c,41 :: 		text = "Direction:   " ;
	MOVLW      ?lstr1_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,42 :: 		Lcd_Out(1, 2, text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,43 :: 		if(dr == 0){
	BTFSC      _dr+0, BitPos(_dr+0)
	GOTO       L_display_results6
;Remote Controlled motor.c,44 :: 		text = "CW" ;
	MOVLW      ?lstr2_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,45 :: 		Lcd_Out(1, 12, text);}
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_display_results7
L_display_results6:
;Remote Controlled motor.c,47 :: 		text = "CCW" ;
	MOVLW      ?lstr3_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,48 :: 		Lcd_Out(1, 12, text);}
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_display_results7:
;Remote Controlled motor.c,49 :: 		text = "Speed(%)=" ;
	MOVLW      ?lstr4_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,50 :: 		Lcd_Out(2, 3, text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,51 :: 		ByteToStr(i, mytext);
	MOVF       _i+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _mytext+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;Remote Controlled motor.c,52 :: 		Lcd_Out(2, 12, Ltrim(mytext));
	MOVLW      _mytext+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,53 :: 		}
L_end_display_results:
	RETURN
; end of _display_results

_main:

;Remote Controlled motor.c,54 :: 		void main() {
;Remote Controlled motor.c,55 :: 		OPTION_REG = 0;
	CLRF       OPTION_REG+0
;Remote Controlled motor.c,56 :: 		PORTB = 0;
	CLRF       PORTB+0
;Remote Controlled motor.c,57 :: 		TRISB = 1;
	MOVLW      1
	MOVWF      TRISB+0
;Remote Controlled motor.c,58 :: 		PORTC = 0;
	CLRF       PORTC+0
;Remote Controlled motor.c,59 :: 		TRISC = 0;
	CLRF       TRISC+0
;Remote Controlled motor.c,60 :: 		PORTD = 0;
	CLRF       PORTD+0
;Remote Controlled motor.c,61 :: 		TRISD = 0;
	CLRF       TRISD+0
;Remote Controlled motor.c,62 :: 		PWM1_Init(10000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      74
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Remote Controlled motor.c,63 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Remote Controlled motor.c,64 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Remote Controlled motor.c,65 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Remote Controlled motor.c,66 :: 		text = "Remote" ;
	MOVLW      ?lstr5_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,67 :: 		Lcd_Out(1, 6, text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,68 :: 		text = "Controlled DCM" ;
	MOVLW      ?lstr6_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,69 :: 		Lcd_Out(2, 2, text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,70 :: 		delay_ms(1000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;Remote Controlled motor.c,71 :: 		while(1){
L_main9:
;Remote Controlled motor.c,72 :: 		ret:
___main_ret:
;Remote Controlled motor.c,73 :: 		INTCON = 0x90;   //External Interrupt enabled
	MOVLW      144
	MOVWF      INTCON+0
;Remote Controlled motor.c,74 :: 		while(!ir_read);         //Wait until IR RC5 protocl received
L_main11:
	MOVF       _ir_read+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	GOTO       L_main11
L_main12:
;Remote Controlled motor.c,75 :: 		ir_read = 0;
	CLRF       _ir_read+0
;Remote Controlled motor.c,76 :: 		delay_us(12446);
	MOVLW      49
	MOVWF      R12+0
	MOVLW      124
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	NOP
;Remote Controlled motor.c,77 :: 		for(j = 0; j < 6; j++)
	CLRF       _j+0
L_main14:
	MOVLW      6
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;Remote Controlled motor.c,79 :: 		if (PORTB.F0 == 0) command|= (1<<( 5 - j));//Set bit (11-j)
	BTFSC      PORTB+0, 0
	GOTO       L_main17
	MOVF       _j+0, 0
	SUBLW      5
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main31:
	BTFSC      STATUS+0, 2
	GOTO       L__main32
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main31
L__main32:
	MOVF       R0+0, 0
	IORWF      _command+0, 1
	GOTO       L_main18
L_main17:
;Remote Controlled motor.c,80 :: 		else               command&=~(1<<(5 - j)); //Clear bit (11-j)
	MOVF       _j+0, 0
	SUBLW      5
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main33:
	BTFSC      STATUS+0, 2
	GOTO       L__main34
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main33
L__main34:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      _command+0, 1
L_main18:
;Remote Controlled motor.c,81 :: 		delay_us(1778);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      236
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	NOP
;Remote Controlled motor.c,77 :: 		for(j = 0; j < 6; j++)
	INCF       _j+0, 1
;Remote Controlled motor.c,82 :: 		}
	GOTO       L_main14
L_main15:
;Remote Controlled motor.c,83 :: 		if (command == 12) {
	MOVF       _command+0, 0
	XORLW      12
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;Remote Controlled motor.c,84 :: 		PORTC = 0;
	CLRF       PORTC+0
;Remote Controlled motor.c,85 :: 		PWM1_Stop();
	CALL       _PWM1_Stop+0
;Remote Controlled motor.c,86 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Remote Controlled motor.c,87 :: 		text = "Motor is OFF" ;
	MOVLW      ?lstr7_Remote_32Controlled_32motor+0
	MOVWF      _text+0
;Remote Controlled motor.c,88 :: 		Lcd_Out(1, 3, text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Remote Controlled motor.c,89 :: 		goto ret;   }
	GOTO       ___main_ret
L_main20:
;Remote Controlled motor.c,90 :: 		if (command == 16){ dr = 1;
	MOVF       _command+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_main21
	BSF        _dr+0, BitPos(_dr+0)
;Remote Controlled motor.c,91 :: 		display_results();
	CALL       _display_results+0
;Remote Controlled motor.c,92 :: 		PORTC = 1;
	MOVLW      1
	MOVWF      PORTC+0
;Remote Controlled motor.c,93 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;Remote Controlled motor.c,94 :: 		goto ret;     }
	GOTO       ___main_ret
L_main21:
;Remote Controlled motor.c,95 :: 		if (command == 17){ dr = 0;
	MOVF       _command+0, 0
	XORLW      17
	BTFSS      STATUS+0, 2
	GOTO       L_main22
	BCF        _dr+0, BitPos(_dr+0)
;Remote Controlled motor.c,96 :: 		display_results();
	CALL       _display_results+0
;Remote Controlled motor.c,97 :: 		PORTC = 2;
	MOVLW      2
	MOVWF      PORTC+0
;Remote Controlled motor.c,98 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;Remote Controlled motor.c,99 :: 		goto ret;    }
	GOTO       ___main_ret
L_main22:
;Remote Controlled motor.c,100 :: 		if (command == 32){ i++;
	MOVF       _command+0, 0
	XORLW      32
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	INCF       _i+0, 1
;Remote Controlled motor.c,101 :: 		if(i > 100) i = 100;}
	MOVLW      128
	XORLW      100
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main24
	MOVLW      100
	MOVWF      _i+0
L_main24:
L_main23:
;Remote Controlled motor.c,102 :: 		if (command == 33) {i--;
	MOVF       _command+0, 0
	XORLW      33
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	DECF       _i+0, 1
;Remote Controlled motor.c,103 :: 		if(i < 1) i = 0;}
	MOVLW      128
	XORWF      _i+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main26
	CLRF       _i+0
L_main26:
L_main25:
;Remote Controlled motor.c,104 :: 		PWM1_Set_Duty(i * 255 / 100);
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Remote Controlled motor.c,105 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;Remote Controlled motor.c,106 :: 		display_results();
	CALL       _display_results+0
;Remote Controlled motor.c,107 :: 		}
	GOTO       L_main9
;Remote Controlled motor.c,108 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
